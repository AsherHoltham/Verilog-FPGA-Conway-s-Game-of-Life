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
        board_o,
        generation_cnt_o, death_cnt_o, birth_cnt_o
	);


	/*  INPUTS */
	input clk;
    input wire[3:0] sys_enable;
	input BtnL, BtnR, BtnU, BtnD, BtnC, Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;	
    
    wire [15:0] cell_inputs;
    assign cell_inputs = {Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0};
	/*  INPUTS */

	/*  OUTPUTS */
    output reg[255:0] board_o;
    output reg[31:0] generation_cnt_o;
    output reg[31:0] death_cnt_o;
    output reg[31:0] birth_cnt_o;
    /*  OUTPUTS */ 

    /* INTERNAL SIGNALS */
    reg[31:0] death_cnt_reg;
    reg[31:0] birth_cnt_reg;
    reg[255:0] internal_board;
    reg[255:0] board;
    wire[7:0] sys_clk;
    wire reset;
    wire[3:0] enable;
    reg[3:0] state;
    

    localparam
        SET	= 3'b001,
        ALG = 3'b010,
        STOP = 3'b100;

    assign reset = BtnL;
    assign enable = (state);

    initial begin 
        state = 0;
        sys_clk = 0;
        internal_board = 0;
        death_cnt_reg = 0;
        birth_cnt_reg = 0;
    end
    /* INTERNAL SIGNALS */

    /* MODULES */
    set_up set_up_m(
        .clk(sys_clk[27]),
        .enable(enable[0]),
        .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC),
        .cell_inputs(cell_inputs),
        .output_board(board));

    algorithm_machine algorithm_m(
        .clk(sys_clk[27]),
        .enable(enable[1]),
        .input_board(internal_board),
        .death_cnt(death_cnt_reg),
        .birth_cnt(birth_cnt_reg),
        .output_board(board));
    /* MODULES */

    /* MACHINE */
    always @(posedge clk)
        sys_clk <= sys_clk + 1;
        
    always @(posedge sys_clk[27], posedge reset) 
    begin
        internal_board <= board;
        board_o <= board;
        if (reset || (state == 3'b000))
        begin
            board_o <= 0;
            board <= 0;
            internal_board <= 0;
            generation_cnt_o <= 0;
            death_cnt_o <= 0;
            birth_cnt_o <= 0;
            output_board <= 0;
            state <= SET;
        end
        else
        begin
            case(state)
                SET:
                    if(BtnR)
                        state <= ALG;
                ALG:
                    if(BtnR)
                        state <= STOP;
                    generation_cnt_o <= generation_cnt_o + 1;
                    birth_cnt_o <= birth_cnt_o + birth_cnt_reg;
                    death_cnt_o <= death_cnt_o + death_cnt_reg;
                STOP:
                    if(BtnR)
                        state <= ALG;
            endcase
        end
    end
    /* MACHINE */
endmodule