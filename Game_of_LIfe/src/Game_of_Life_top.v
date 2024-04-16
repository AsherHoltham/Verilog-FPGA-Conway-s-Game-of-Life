`timescale 1ns / 1ps

module Game_of_Life
    (
    // Button, Switch and Clock signal inputs
	input ClkPort,
    input BtnL, BtnR, BtnU, BtnD, BtnC, 
    input Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,

	//VGA signal
	output hSync, vSync,
	output [3:0] vgaR, vgaG, vgaB,
	
	//SSG signal 
	output An0, An1, An2, An3, An4, An5, An6, An7,
	output Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	
    //Memory outputs
	output MemOE, MemWR, RamCS, QuadSpiFlashCS
    );

    wire bright;
	wire[9:0] hc, vc;
    wire[15:0] generation;
    wire[255:0] board;
	wire [6:0] ssdOut;
	wire [3:0] anode;
	wire [11:0] rgb;

    assign Dp = 1;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg} = ssdOut[6 : 0];
    assign {An7, An6, An5, An4, An3, An2, An1, An0} = {4'b1111, anode};

	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];
	
	// disable mamory ports
	assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;

    Game_of_Life_machine GLmachine (.clk(ClkPort), .BtnL(BtnL), .BtnR(BtnR), .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC), 
        .Sw15(Sw15), .Sw14(Sw14), .Sw13(Sw13), .Sw12(Sw12), .Sw11(Sw11), .Sw10(Sw10), .Sw9(Sw9), .Sw8(Sw8), .Sw7(Sw7), 
        .Sw6(Sw6), .Sw5(Sw5), .Sw4(Sw4), .Sw3(Sw3), .Sw2(Sw2), .Sw1(Sw1), .Sw0(Sw0),
        .board_o(board), .generation_cnt_o(generation));
	Births_Generation_output outp(.clk(ClkPort), .generation(generation), .anode(anode), .ssdOut(ssdOut));
	display_controller dc(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .bright(bright), .hCount(hc), .vCount(vc));


endmodule