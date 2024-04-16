////////////////////////////////////////////////////////////
////////// Creators: Asher Holtham & Krishna Srikanth
////////// Creation date: sat. Apr 13 2024
////////// Design name: Game_of_Life_machine_top
////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Game_of_Life_machine 
    (   
        clk,
        sys_enable,
        BtnL, BtnR, BtnU, BtnD, BtnC, 
        Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        board_o, generation_cnt_o, death_cnt_o, birth_cnt_o
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
    reg[31:0] sys_clk;
    wire reset;
    reg[2:0] state;
    reg[3:0] neighbor_cnt;
    integer index;
    reg past_cell_state;
    reg[3:0] I;
    reg[7:0] starting_I;

    localparam
        SET	= 3'b001,
        ALG = 3'b010,
        STOP = 3'b100;

    assign reset = BtnL;

    initial begin 
        state = 0;
        death_cnt_reg = 0;
        birth_cnt_reg = 0;
        neighbor_cnt = 0;
        internal_board = 0;
        index = 0;
        I = 0;
        starting_I = 0;
    end
    /* INTERNAL SIGNALS */

    /* MACHINE */
    always @(posedge clk)
        sys_clk <= sys_clk + 1;
        
    always @(posedge sys_clk[27], reset) 
    begin
        if (reset || (state == 3'b000))
        begin
            board_o <= 0;
            internal_board <= 0;
            generation_cnt_o <= 0;
            death_cnt_o <= 0;
            birth_cnt_o <= 0;
            state <= SET;
            I <= 0;
        end
        else
        begin
            case(state)
                SET: 
                begin
                    if(BtnR)
                        state <= ALG;

                    starting_I = I * 16;
                    if(enable) begin
                        if(BtnC) begin
                            output_board[starting_I +:16] <= cell_inputs;
                        end
                        if((BtnU) && (I > 4'b0000)) 
                            I <= I - 1;
                        if((BtnD) && (I < 4'b1111)) 
                            I <= I + 1;
                    end
                end
                ALG:
                begin
                    if(BtnR)
                        state <= STOP;
                    for(index = 0; index < 256; index = index + 1)
                    begin
                        past_cell_state = board_o[index];
                        neighbor_cnt = 0;

                        if(board_o[index - 17] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                        if(board_o[index - 16] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                        if(board_o[index - 15] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                        if(board_o[index - 1] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                        if(board_o[index + 1] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                        if(board_o[index + 15] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                        if(board_o[index + 16] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                        if(board_o[index + 17] == 1'b1) neighbor_cnt = neighbor_cnt + 1;

                        if (past_cell_state == 1'b1 && (neighbor_cnt == 2 || neighbor_cnt == 3)) begin
                            internal_board[index] = 1'b1;
                        end else if (past_cell_state == 1'b1 && (neighbor_cnt < 2 || neighbor_cnt > 3)) begin
                            internal_board[index] = 1'b0;
                            death_cnt_reg = death_cnt_reg + 1;
                        end else if (past_cell_state == 1'b0 && neighbor_cnt == 3) begin
                            internal_board[index] = 1'b1;
                            birth_cnt_reg = birth_cnt_reg + 1;
                        end else begin
                            internal_board[index] = past_cell_state;
                        end
                    end
                    board_o <= internal_board;
                    generation_cnt_o <= generation_cnt_o + 1;
                    birth_cnt_o <= birth_cnt_o + birth_cnt_reg;
                    death_cnt_o <= death_cnt_o + death_cnt_reg;
                    birth_cnt_reg = 0;
                    death_cnt_reg = 0;
                end
                STOP:
                    if(BtnR)
                        state <= ALG;
            endcase
        end
    end
    /* MACHINE */
endmodule