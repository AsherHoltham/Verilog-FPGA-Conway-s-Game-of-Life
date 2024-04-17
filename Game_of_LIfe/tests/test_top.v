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
	/*  INPUTS */

	/*  OUTPUTS */
    output wire board_out;
    output wire generation_cnt_out;
    /*  OUTPUTS */ 

    /* INTERNAL SIGNALS */
    wire[255:0] board_o;
    wire[15:0] generation_cnt_o;
    /* INTERNAL SIGNALS */

    /* ASSIGN OUTPUT */
    assign board_out = board_o[0];
    assign generation_cnt_out = generation_cnt_o[0];
    /* ASSIGN OUTPUT */
    
    /* TEST MODULE */
    Game_of_Life_machine machine_test (.clk(ClkPort), .BtnL(BtnL), .BtnR(BtnR), .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC), .Sw15(Sw15), .Sw14(Sw14), .Sw13(Sw13), .Sw12(Sw12), .Sw11(Sw11), .Sw10(Sw10), .Sw9(Sw9), .Sw8(Sw8), .Sw7(Sw7), .Sw6(Sw6), .Sw5(Sw5), .Sw4(Sw4), .Sw3(Sw3), .Sw2(Sw2), .Sw1(Sw1), .Sw0(Sw0), .board_o(board_o), .generation_cnt_o(generation_cnt_o));
    /* TEST MODULE */
endmodule