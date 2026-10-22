// ============================================================================
// elad1_control.v  -  ELAD-1 registered configuration controller
//   Implemented as cell ELAD1_CONTROL (sky130_fd_sc_hd, hardened separately and
//   instanced in the analog top).  Every output that touches the analog domain
//   is a flop output (glitch-free); ui_in never drives a switch directly.
//
//   ui_in[1:0] MODE    00 idle | 01 mirror | 10 pair | 11 noise
//   ui_in[2]   STRUCT  0 grouped | 1 common-centroid   (matching modes only)
//   ui_in[3]   HEATER  request (honoured only in mirror / pair)
//   ui_in[4]   AGGR    request (honoured only in noise)
//   ui_in[6:5] RATE    aggressor = clk/2, /4, /8, /16
//   ui_in[7]   APPLY   rising edge starts a transaction (synchronized)
//
//   Transaction:  ACTIVE/IDLE --APPLY--> STOP (heater + aggressor off, 2 clocks,
//   then all paths off) --> QUIET (paths open, QUIET_CYC clocks) --> LOAD (clamps follow new config, CLAMP_CYC clocks,
//   config re-checked) --> CONNECT (selected paths on) --> ACTIVE (heater /
//   aggressor enables applied).  Any reset source forces the safe state
//   asynchronously; release is synchronous, so a stopped clock stays safe.
// ============================================================================
`default_nettype none

module elad1_control #(
    parameter integer QUIET_CYC = 4,   // break-before-make hold (review vs. discharge sims)
    parameter integer CLAMP_CYC = 2    // clamp release -> path enable spacing
) (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ena,
    input  wire [7:0] ui_in,
    // analog-domain controls (all registered)
    output reg        en_mg, en_mc, en_pg, en_pc, en_n,      // path enables  (1 = connect)
    output reg        clr_mg, clr_mc, clr_pg, clr_pc, clr_n, // gate clamps   (1 = clamp)
    output reg        hen,                                   // heater switch enable
    output reg        agg_clk,                               // divided aggressor clock (0 when off)
    // status (static once ACTIVE)
    output wire [7:0] status
);
    // ---------------------------------------------------------------- reset
    // async assert on !rst_n or !ena, synchronous de-assert (2 flops)
    wire arst_n = rst_n & ena;
    reg  [1:0] rsync;
    always @(posedge clk or negedge arst_n)
        if (!arst_n) rsync <= 2'b00;
        else         rsync <= {rsync[0], 1'b1};
    wire rstn_i = rsync[1];

    // ---------------------------------------------------------------- APPLY sync + edge
    reg [2:0] apply_s;
    always @(posedge clk or negedge rstn_i)
        if (!rstn_i) apply_s <= 3'b000;
        else         apply_s <= {apply_s[1:0], ui_in[7]};
    wire apply_rise = apply_s[1] & ~apply_s[2];

    // ---------------------------------------------------------------- FSM
    localparam [2:0] S_SAFE = 3'd0, S_STOP = 3'd5, S_QUIET = 3'd1, S_LOAD = 3'd2,
                     S_CONN = 3'd3, S_ACTIVE = 3'd4;
    reg [2:0] state;
    reg [3:0] cnt;
    reg [6:0] cfg;           // captured {RATE, AGGR, HEATER, STRUCT, MODE}
    reg       err;           // sticky until next APPLY

    wire [1:0] mode   = cfg[1:0];
    wire       strct  = cfg[2];
    wire       h_req  = cfg[3];
    wire       a_req  = cfg[4];
    wire [1:0] rate   = cfg[6:5];
    wire       m_match = (mode == 2'b01) | (mode == 2'b10);
    wire       m_noise = (mode == 2'b11);

    // decoded selection of the *captured* configuration
    wire s_mg = (mode == 2'b01) & ~strct;
    wire s_mc = (mode == 2'b01) &  strct;
    wire s_pg = (mode == 2'b10) & ~strct;
    wire s_pc = (mode == 2'b10) &  strct;
    wire s_n  = m_noise;

    reg agg_en;

    always @(posedge clk or negedge rstn_i) begin
        if (!rstn_i) begin
            state <= S_SAFE; cnt <= 4'd0; cfg <= 7'd0; err <= 1'b0;
            {en_mg, en_mc, en_pg, en_pc, en_n}      <= 5'b00000;
            {clr_mg, clr_mc, clr_pg, clr_pc, clr_n} <= 5'b11111;
            hen <= 1'b0; agg_en <= 1'b0;
        end else begin
            if (apply_rise && (state == S_SAFE || state == S_ACTIVE)) begin
                // 1) stimulus off first: heater and aggressor (paths still connected)
                cfg   <= ui_in[6:0];
                err   <= 1'b0;
                hen   <= 1'b0; agg_en <= 1'b0;
                cnt   <= 4'd0;
                state <= S_STOP;
            end else begin
                case (state)
                S_STOP: begin                          // 1b) let the divider flush to 0, then break
                    if (cnt == 4'd1) begin
                        {en_mg, en_mc, en_pg, en_pc, en_n} <= 5'b00000;
                        cnt   <= 4'd0;
                        state <= S_QUIET;
                    end else cnt <= cnt + 4'd1;
                end
                S_QUIET: begin                         // 2) hold all paths open
                    if (cnt == QUIET_CYC - 1) begin
                        cnt <= 4'd0;
                        // 3) clamps follow the new configuration while paths are open
                        clr_mg <= ~s_mg; clr_mc <= ~s_mc;
                        clr_pg <= ~s_pg; clr_pc <= ~s_pc; clr_n <= ~s_n;
                        state  <= S_LOAD;
                    end else cnt <= cnt + 4'd1;
                end
                S_LOAD: begin
                    if (cnt == CLAMP_CYC - 1) begin
                        cnt <= 4'd0;
                        if (ui_in[6:0] != cfg) begin   // config bits moved during transaction
                            err <= 1'b1;
                            {clr_mg, clr_mc, clr_pg, clr_pc, clr_n} <= 5'b11111;
                            cfg   <= 7'd0;             // fall back to IDLE
                            state <= S_ACTIVE;
                        end else state <= S_CONN;
                    end else cnt <= cnt + 4'd1;
                end
                S_CONN: begin                          // 4) make: selected paths only
                    en_mg <= s_mg; en_mc <= s_mc; en_pg <= s_pg; en_pc <= s_pc; en_n <= s_n;
                    state <= S_ACTIVE;
                end
                S_ACTIVE: begin                        // 5) stimulus enables, mode-gated
                    hen    <= h_req & m_match;
                    agg_en <= a_req & m_noise;
                    if ((h_req & ~m_match) | (a_req & ~m_noise)) err <= 1'b1;
                end
                default: state <= S_SAFE;
                endcase
            end
        end
    end

    // ---------------------------------------------------------------- aggressor divider
    // Runs only while agg_en; held at 0 otherwise (no internal activity in matching modes).
    // Physically placed inside ELAD1_AGGRESSOR so the switching is localized there.
    reg [3:0] div;
    always @(posedge clk or negedge rstn_i)
        if (!rstn_i)      begin div <= 4'd0; agg_clk <= 1'b0; end
        else if (!agg_en) begin div <= 4'd0; agg_clk <= 1'b0; end
        else begin
            div     <= div + 4'd1;
            agg_clk <= div[rate];   // registered: clk/2,/4,/8,/16, 50 % duty
        end

    wire active = (state == S_ACTIVE);
    assign status = {err, agg_en, hen, (active ? strct : 1'b0), (active ? mode : 2'b00),
                     ~(active | (state == S_SAFE)), active};
    // status[7] ERR  [6] AGG_ON  [5] HEAT_ON  [4] STRUCT  [3:2] MODE  [1] BUSY  [0] ACTIVE
endmodule

`default_nettype wire
