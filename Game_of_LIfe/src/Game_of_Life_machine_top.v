////////////////////////////////////////////////////////////
////////// Creators: Asher Holtham & Krishna Srikanth
////////// Creation date: sat. Apr 13 2024
////////// Design name: Game_of_Life_machine_top
////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Game_of_Life_machine_top 
    (   
        clk,
        sys_enable,
        BtnL, BtnR, BtnU, BtnD, BtnC, 
        Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        board,
        generation_cnt, death_cnt, birth_cnt
	);


	/*  INPUTS */
	input clk;
    input wire[3:0] sys_enable;
	input BtnL, BtnR, BtnU, BtnD, BtnC, Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;	
    
    wire [15:0] cell_inputs;
    assign cell_inputs = {Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0};
	/*  INPUTS */

	/*  OUTPUTS */
    output reg[255:0] board;
    output reg[31:0] generation_cnt;
    output reg[31:0] death_cnt;
    output reg[31:0] birth_cnt;
    /*  OUTPUTS */ 

    /* INTERNAL SIGNALS */
    reg[31:0] death_cnt_reg;
    reg[31:0] birth_cnt_reg;
    reg[255:0] internal_board;
    wire[7:0] sys_clk;
    wire reset;
    wire[3:0] enable;
    reg[3:0] state;
    

    localparam
        INI	= 4'b0001,
        SET	= 4'b0010,
        ALG = 4'b0100,
        STOP = 4'b1000;

    assign reset = BtnL;
    assign enable = (state && sys_enable);

    initial begin 
        state = 4'b0000;
        sys_clk = 0;
    end
    /* INTERNAL SIGNALS */

    /* MODULES */
    init initializer(
        .clk(sys_clk[15]),
        .enable(enable[0]),
        .death_cnt(death_cnt),
        .birth_cnt(birth_cnt),
        .output_board(board));

    set_up set_up_m(
        .clk(sys_clk[15]),
        .enable(enable[1]),
        .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC),
        .cell_inputs(cell_inputs),
        .output_board(board));

    algorithm_machine algorithm_m(
        .clk(sys_clk[7]),
        .enable(enable[2]),
        .input_board(prev_board),
        .death_cnt(death_cnt),
        .birth_cnt(birth_cnt),
        .output_board(board));
    /* MODULES */

    /* MACHINE */
    always @(posedge clk)
        sys_clk <= sys_clk + 1;

    always @(posedge sys_clk[15])
        internal_board = board;
        
    always @(posedge sys_clk[15], posedge reset) 
    begin
        if (reset || (state == 4'b0000))
        begin
            state <= INI;
            sys_clk <= 0;
            generation_cnt <= 0;
        end
        else
        begin
            case(state)
                INI:
                    state <= SET;
                SET:
                    if(BtnR)
                        state <= ALG;
                ALG:
                    if(BtnR)
                        state <= STOP;
                    generation_cnt <= generation_cnt + 1;
                STOP:
                    if(BtnR)
                        state <= ALG;
            endcase
        end 
    end
    /* MACHINE */
endmodule