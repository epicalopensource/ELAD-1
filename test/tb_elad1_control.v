// tb_elad1_control.v - self-checking testbench for ELAD1_CONTROL
// iverilog -g2012 -o tb test/tb_elad1_control.v src/elad1_control.v src/elad1_digital_top.v && vvp tb
`timescale 1ns/1ps
`default_nettype none
module tb;
    reg  [7:0] ui = 0;
    reg  ena = 0, rst_n = 0, clk = 0, clk_run = 1;
    wire [7:0] uo, uio_out, uio_oe;
    wire [4:0] en, clr;
    wire hen, agg_clk;
    integer errors = 0, checks = 0;

    elad1_digital_top dut (.ui_in(ui), .uo_out(uo), .uio_in(8'h00), .uio_out(uio_out), .uio_oe(uio_oe),
                           .ena(ena), .clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .hen(hen), .agg_clk(agg_clk));

    localparam real TCLK = 20.0;                 // 50 MHz
    always #(TCLK/2) if (clk_run) clk = ~clk;

    task check(input cond, input [8*64-1:0] msg);
        begin checks = checks + 1;
            if (!cond) begin errors = errors + 1; $display("FAIL @%0t: %0s", $time, msg); end end
    endtask

    // ------------------------------------------------------------ continuous safety monitors
    integer idle_cycles = 99, clr_low_cycles [0:4];
    integer k;
    reg [4:0] en_prev = 0;
    initial for (k = 0; k < 5; k = k + 1) clr_low_cycles[k] = 0;
    always @(posedge clk) begin
        idle_cycles <= (en == 0) ? idle_cycles + 1 : 0;
        for (k = 0; k < 5; k = k + 1) clr_low_cycles[k] <= clr[k] ? 0 : clr_low_cycles[k] + 1;
    end
    always @(en or clr or hen) begin
        #0.01;
        check($countones(en) <= 1, "M1 more than one structure connected");
        check((en & clr) == 0, "M2 connected structure is still clamped");
        check(!hen || (en[3:0] != 0), "M3 heater on outside matching mode");
    end
    always @(posedge clk) begin
        en_prev <= en;
        if (en != 0 && en_prev == 0) begin   // a new connection: break-before-make history
            check(idle_cycles >= 4, "M5 <4 idle cycles before connect");
            for (k = 0; k < 5; k = k + 1)
                if (en[k]) check(clr_low_cycles[k] >= 2, "M6 clamp released <2 cycles before connect");
        end
    end
    reg agg_prev = 1'bx;   // ignore the power-up x->0 settle (RTL artifact; dfrtp reset is level-sensitive)
    always @(agg_clk) begin
        #0.01 if (!$isunknown(agg_prev)) check(en[4] == 1'b1, "M4 aggressor toggling outside noise mode");
        agg_prev = agg_clk;
    end

    // ------------------------------------------------------------ helpers
    task apply(input [6:0] cfg);
        begin
            @(negedge clk) ui[6:0] = cfg;       // config first
            repeat (2) @(negedge clk);
            ui[7] = 1;                          // APPLY rising
            repeat (3) @(negedge clk);
            ui[7] = 0;
            wait (uo[0] == 1'b1);               // ACTIVE
            repeat (3) @(negedge clk);
        end
    endtask
    function [4:0] exp_en(input [6:0] c);
        case (c[1:0])
            2'b01: exp_en = c[2] ? 5'b00010 : 5'b00001;
            2'b10: exp_en = c[2] ? 5'b01000 : 5'b00100;
            2'b11: exp_en = 5'b10000;
            default: exp_en = 5'b00000;
        endcase
    endfunction
    task expect_cfg(input [6:0] c);
        reg [4:0] e;
        begin
            e = exp_en(c);
            check(en == e, "T2 path enables");
            check(clr == ~e, "T2 clamps = ~enables");
            check(hen == (c[3] & (c[1:0] == 2'b01 || c[1:0] == 2'b10)), "T2 heater gating");
            check(uo[3:2] == c[1:0] && uo[4] == (c[1:0] != 0 ? c[2] : c[2]), "T2 status echo");
            check(uio_oe == 0 && uio_out == 0, "T2 uio tied off");
        end
    endtask
    task period_cycles(output integer pc);
        realtime t0, t1;
        begin @(posedge agg_clk) t0 = $realtime; @(posedge agg_clk) t1 = $realtime;
              pc = (t1 - t0) / TCLK; end
    endtask

    integer m, s, r, p;
    reg [6:0] c;
    initial begin
        $dumpfile("tb_elad1_control.vcd"); $dumpvars(0, tb);
        // T1 reset state
        #1; check(en == 0 && clr == 5'b11111 && !hen && !agg_clk, "T1 reset safe state");
        #100 ena = 1; #50 rst_n = 1;
        repeat (5) @(negedge clk);
        check(en == 0 && clr == 5'b11111 && uo[0] == 0, "T1 safe after reset release");

        // T2 every mode x struct, heater request where legal
        for (m = 0; m < 4; m = m + 1)
            for (s = 0; s < 2; s = s + 1) begin
                c = {2'b00, 1'b0, (m == 1 || m == 2) ? 1'b1 : 1'b0, s[0], m[1:0]};
                apply(c); expect_cfg(c);
                check(uo[7] == 0, "T2 no error on legal config");
            end

        // T3 illegal stimulus requests are refused and flagged
        apply(7'b0_0_0_1_0_11); check(!hen && uo[7], "T3 heater refused in noise mode");
        apply(7'b0_0_1_0_0_01); check(!uo[6] && uo[7], "T3 aggressor refused in mirror mode");

        // T4 aggressor rates
        for (r = 0; r < 4; r = r + 1) begin
            apply({r[1:0], 1'b1, 1'b0, 1'b0, 2'b11});
            period_cycles(p);
            check(p == (2 << r), "T4 aggressor divide ratio");
            $display("  rate %0d -> agg period %0d clk", r, p);
        end
        apply(7'b00_0_0_0_00);                      // idle: aggressor must stop
        repeat (40) @(negedge clk); check(agg_clk == 0, "T4 aggressor stops in idle");

        // T5 ena drop while heater on -> immediate safe state
        apply(7'b00_0_1_0_01); check(hen, "T5 precondition heater on");
        // check 5 ns after the drop: on gates the reset passes ~3 cells (AND, synchronizer, output
        // flops); 5 ns is still before the next clock edge (10 ns away), so it proves the reset is async
        #3 ena = 0; #5;
        check(!hen && en == 0 && clr == 5'b11111, "T5 async safe on ena low");
        #200 ena = 1; repeat (5) @(negedge clk);
        check(en == 0 && uo[0] == 0, "T5 stays safe until a new APPLY");

        // T6 clock stop holds state; reset with stopped clock still forces safe
        apply(7'b00_0_1_1_10);
        clk_run = 0; #500;
        check(en == 5'b01000 && hen, "T6 state held with clock stopped");
        rst_n = 0; #5;   // 5 ns: gate delays of the reset path (see T5); the clock is stopped here
        check(en == 0 && !hen && clr == 5'b11111, "T6 reset with stopped clock -> safe");
        #100 rst_n = 1; clk_run = 1; repeat (5) @(negedge clk);
        check(en == 0, "T6 safe after restart");

        // T7 config moves during the transaction -> error, fallback to idle
        @(negedge clk) ui[6:0] = 7'b00_0_0_0_01; repeat (2) @(negedge clk); ui[7] = 1;
        repeat (4) @(negedge clk); ui[6:0] = 7'b00_0_0_0_10;   // illegal change inside QUIET
        wait (uo[0]); repeat (2) @(negedge clk);
        check(uo[7] && en == 0 && clr == 5'b11111, "T7 moved config -> ERR + idle");
        ui[7] = 0;

        // T8 APPLY held high = exactly one transaction
        apply(7'b00_0_0_0_01);
        @(negedge clk) ui[7] = 1; repeat (60) @(negedge clk);
        check(en == 5'b00001 && uo[0], "T8 held APPLY -> single transaction");
        ui[7] = 0;

        $display("RESULT: %0d checks, %0d errors", checks, errors);
        $finish;
    end
endmodule
`default_nettype wire
