// ELAD1_CONTROL - hardening wrapper around src/elad1_control.v.
// Only renames the top module, so the GDS cell, the LEF macro, the gate-level netlist and the
// xschem symbol (ELAD1_CONTROL.sym) all carry the same name. Port names and order are unchanged.
`default_nettype none
module ELAD1_CONTROL (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ena,
    input  wire [7:0] ui_in,
    output wire       en_mg, en_mc, en_pg, en_pc, en_n,
    output wire       clr_mg, clr_mc, clr_pg, clr_pc, clr_n,
    output wire       hen,
    output wire       agg_clk,
    output wire [7:0] status
);
    elad1_control u_ctl (
        .clk(clk), .rst_n(rst_n), .ena(ena), .ui_in(ui_in),
        .en_mg(en_mg), .en_mc(en_mc), .en_pg(en_pg), .en_pc(en_pc), .en_n(en_n),
        .clr_mg(clr_mg), .clr_mc(clr_mc), .clr_pg(clr_pg), .clr_pc(clr_pc), .clr_n(clr_n),
        .hen(hen), .agg_clk(agg_clk), .status(status));
endmodule
`default_nettype wire
