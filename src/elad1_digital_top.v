// Digital view of tt_um_epicalopensource_elad1 used for RTL verification and for hardening
// ELAD1_CONTROL: the analog core is represented only by the controller outputs.
`default_nettype none
module elad1_digital_top (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena, clk, rst_n,
    output wire [4:0] en,      // {N, PC, PG, MC, MG}
    output wire [4:0] clr,     // {N, PC, PG, MC, MG}
    output wire       hen, agg_clk
);
    elad1_control u_ctl (
        .clk(clk), .rst_n(rst_n), .ena(ena), .ui_in(ui_in),
        .en_mg(en[0]), .en_mc(en[1]), .en_pg(en[2]), .en_pc(en[3]), .en_n(en[4]),
        .clr_mg(clr[0]), .clr_mc(clr[1]), .clr_pg(clr[2]), .clr_pc(clr[3]), .clr_n(clr[4]),
        .hen(hen), .agg_clk(agg_clk), .status(uo_out));
    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;
    wire _unused = &{uio_in, 1'b0};
endmodule
`default_nettype wire
