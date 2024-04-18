`timescale 1ns / 1ps

module Game_of_Life
    (
	input ClkPort,
    input BtnL, BtnR, BtnU, BtnD, BtnC, 
    input Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
	output hSync, vSync, 
	output [3:0] vgaR, vgaG, vgaB,
	output An0, An1, An2, An3, An4, An5, An6, An7, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp
	);

    /* INTERNAL SIGNALS */
    wire[15:0] generation;
    wire[255:0] board;

    wire bright;
	wire[9:0] hc, vc;

	wire [6:0] ssdOut;
	wire [3:0] anode;
	wire [11:0] rgb;
	wire [11:0] cell_rgb;
	wire [4:0] cell_row;
	wire [4:0] cell_col;
	wire cell_state;
    /* INTERNAL SIGNALS */

    /* ASSIGNMENTS */
    assign Dp = 1;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg} = ssdOut[6 : 0];
    assign {An7, An6, An5, An4, An3, An2, An1, An0} = {4'b1111, anode};

	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];
	/* ASSIGNMENTS */

	/* MODULES */
    Main_machine algo_(.clk(ClkPort), .BtnL(BtnL), .BtnR(BtnR), .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC), .Sw15(Sw15), .Sw14(Sw14), .Sw13(Sw13), .Sw12(Sw12), .Sw11(Sw11), .Sw10(Sw10), .Sw9(Sw9), .Sw8(Sw8), .Sw7(Sw7), .Sw6(Sw6), .Sw5(Sw5), .Sw4(Sw4), .Sw3(Sw3), .Sw2(Sw2), .Sw1(Sw1), .Sw0(Sw0), .board_o(board), .generation_cnt_o(generation));
	ssd_generation_output SSD_(.clk(ClkPort), .generation(generation), .anode(anode), .ssdOut(ssdOut));
	display_controller dc_(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .bright(bright), .row(cell_row), .col(cell_col), .hc(hc), .vc(vc));
	cell_rom ROM_(.clk(ClkPort), .row(cell_row), .col(cell_col), .color_data(cell_rgb));
	curr_cell_output cell_(.clk(ClkPort), .hc(hc), .vc(vc), .board(board), .cell_state(cell_state));
	update_vga vga_(.bright(bright), .cell_state(cell_state), .cell_rgb(cell_rgb), .rgb(rgb));
    /* MODULES */
endmodule