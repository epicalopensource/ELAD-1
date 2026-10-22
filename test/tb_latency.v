`timescale 1ns/1ps
module lat; reg [7:0] ui=0; reg ena=1, rst_n=0, clk=0; wire [7:0] uo,a,b; wire [4:0] en,clr; wire h,g;
elad1_digital_top d(.ui_in(ui),.uo_out(uo),.uio_in(8'h0),.uio_out(a),.uio_oe(b),.ena(ena),.clk(clk),.rst_n(rst_n),.en(en),.clr(clr),.hen(h),.agg_clk(g));
always #50 clk=~clk; realtime t0, tb, tc;
initial begin #300 rst_n=1; #500; @(negedge clk) ui[6:0]=7'b0000001; @(negedge clk); ui[7]=1; t0=$realtime;
 @(posedge uo[1]) tb=$realtime; @(posedge uo[0]) tc=$realtime;
 $display("APPLY->BUSY %0.1f clk, APPLY->ACTIVE %0.1f clk", (tb-t0)/100, (tc-t0)/100); $finish; end
endmodule
