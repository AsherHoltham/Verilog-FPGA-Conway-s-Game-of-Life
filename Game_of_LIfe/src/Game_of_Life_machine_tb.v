module Game_of_Life_machine_tb;

reg clk = 0;
reg[0:0] board[15:0][15:0];
integer generation_cnt, death_cnt, birth_cnt, I;

Game_of_Life_machine uut(ClkPort,
        BtnL, BtnR, BtnU, BtnD, BtnC, 
        Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        board, generation_cnt, death_cnt, birth_cnt, I);

always@ #5 clk = ~clk;

endmodule