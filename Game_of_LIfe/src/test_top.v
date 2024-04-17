module test_top
    (
        ClkPort,
        BtnL, BtnR, BtnU, BtnD, BtnC, 
        Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        board_out, generation_cnt_out       
    );
	/*  INPUTS */
	input ClkPort;
	input BtnL, BtnR, BtnU, BtnD, BtnC, Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;
	
    
    wire [15:0] cell_inputs;
    assign cell_inputs = {Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0};
	/*  INPUTS */

	/*  OUTPUTS */
    output wire board_out;
    output wire[15:0] generation_cnt_out;

    assign board_out = board_o[0];
    /*  OUTPUTS */ 

    /* INTERNAL SIGNALS */
    reg[255:0] board_o;
    /* INTERNAL SIGNALS */

    /* TEST MODULE */
    Game_of_Life_machine machine_test (.clk(ClkPort), .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC), .board_o(board_o), .generation_cnt_o(generation_cnt_out));
    /* TEST MODULE */

endmodule