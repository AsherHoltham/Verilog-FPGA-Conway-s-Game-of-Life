////////////////////////////////////////////////////////////
////////// Creators: Asher Holtham & Krishna Srikanth
////////// Creation date: sat. Apr 13 2024
////////// Design name: Game_of_Life_machine_top
////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Game_of_Life_machine_top 
    (   
        ClkPort,          // the 100 MHz incoming clock signal
		BtnL, BtnR, BTnU, BTnD, BtnC, 
		Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0, // 16  switches
        reg[0:0] board[15:0][15:0],
        generation_cnt, death_cnt, birth_cnt, I
	);


	/*  INPUTS */
	// Clock & I/O
	input ClkPort;	
	input BtnL, BtnR, BTnU, BTnD, BtnC, Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;	
	
	/*  OUTPUTS */
    output reg[0:0] board[15:0][15:0];
    output integer generation_cnt;
    output integer death_cnt;
    output integer birth_cnt;
    output integer I;

    /* INTERNAL VARIABLES */
    wire reset;
    wire[3:0] enable;
    reg[3:0] state;

    localparam
        INI	= 4'b0001,
        SET	= 4'b0010,
        ALG = 4'b0100,
        STOP = 4'b1000;

    assign reset = BtnL;
    assign enable = state;
    state = 4'b0000;

    /* MODULES */
    init initializer(
        .enable(enable[0]);
        .death_cnt(death_cnt);
        .birth_cnt(brith_cnt);
        .generation_cnt(generation_cnt);
        .output_board(board));

    set_up set_up_machine(
        .clk(ClkPort),
        .enable(enable[1]),
        .BTnU(BTnU), .BTnD(BTnD), .BtnC(BtnC),
        .Sw15(Sw15), .Sw14(Sw14), .Sw13(Sw13), .Sw12(Sw12), 
        .Sw11(Sw11), .Sw10(Sw10), .Sw9(Sw9), .Sw8(Sw8), 
        .Sw7(Sw7), .Sw6(Sw6), .Sw5(Sw5), .Sw4(Sw4), 
        .Sw3(Sw3), .Sw2(Sw2), .Sw1(Sw1), .Sw0(Sw0),
        .I(I),
        .output_board(board));

    algorithm algorithm_machine(
        .clk(ClkPort);
        .enable(enable[2]);
        .death_cnt(death_cnt);
        .birth_cnt(brith_cnt);
        .generation_cnt(generation_cnt);
        .output_board(board));

    always @(posedge ClkPort, posedge reset) 
    begin
        if (reset)
            state <= INI;
        else
        begin
            case(state);
                INI:
                    state <= SET;
                SET:
                    if(BtnR)
                        state <= ALG;
                ALG:
                    if(BtnR)
                        state <= STOP;
                STOP:
                    if(BtnR)
                        state <= ALG;
            endcase
        end 
    end
endmodule