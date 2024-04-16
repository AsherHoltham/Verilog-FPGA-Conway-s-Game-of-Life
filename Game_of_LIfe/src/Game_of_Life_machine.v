////////////////////////////////////////////////////////////
////////// Creators: Asher Holtham & Krishna Srikanth
////////// Creation date: sat. Apr 13 2024
////////// Design name: Game_of_Life_machine_top
////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Game_of_Life_machine 
    (   
        ClkPort,
        BtnL, BtnR, BtnU, BtnD, BtnC, 
        Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        board_o, generation_cnt_o, birth_cnt_o
	);


	/*  INPUTS */
	input ClkPort;
	input BtnL, BtnR, BtnU, BtnD, BtnC, Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;	
    
    wire [15:0] cell_inputs;
    assign cell_inputs = {Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0};
	/*  INPUTS */

	/*  OUTPUTS */
    output reg[255:0] board_o;
    output reg[31:0] generation_cnt_o;
    output reg[31:0] birth_cnt_o;
    /*  OUTPUTS */ 

    /* INTERNAL SIGNALS */
    reg[31:0] birth_cnt_reg;
    reg[255:0] internal_board;
    reg[31:0] sys_clk;
    wire reset;
    reg[2:0] state;
    wire[7:0] adjacency_matrix;
    reg[3:0] num_adj;
    reg[7:0] index;
    reg past_cell_state;
    integer i;
    integer j;

    localparam
        SET	= 3'b001,
        ALG = 3'b010,
        STOP = 3'b100;

    assign reset = (BtnL || (state == 3'b000));
    assign adjacency_matrix = {board_o[index - 17], board_o[index - 16], board_o[index - 15], board_o[index - 1],  
                               board_o[index + 1], board_o[index + 15], board_o[index + 16], board_o[index + 17]};

    initial begin 
        state = 0;
        birth_cnt_reg = 0;
        num_adj = 0;
        internal_board = 0;
        index = 0;
    end
    /* INTERNAL SIGNALS */

    /* MACHINE */
    always @(posedge ClkPort)
        sys_clk <= sys_clk + 1;
        
    always @(posedge sys_clk[27], posedge reset) 
    begin
        if (reset)
        begin
            index <= 0;
            board_o <= 0;
            internal_board <= 0;
            generation_cnt_o <= 0;
            birth_cnt_o <= 0;
            state <= SET;
        end
        else if(sys_clk[27])
        begin
            case(state)
                SET: 
                begin
                    if(BtnR)
                    begin
                        state <= ALG;
                        index <= 0;
                    end

                    if(BtnC) begin
                       board_o[(index * 16) +:16] <= cell_inputs;
                    end
                    if((BtnU) && (index > 0)) 
                       index <= index - 1;
                    if((BtnD) && (index < 15)) 
                       index <= index + 1;
                end
                ALG:
                begin
                    if(BtnR) state <= STOP;

                    for(i = 0; i <= 255; i = i + 1)
                    begin
                        num_adj = 0;
                        for(j = 0; j <= 7; j = j + 1)
                        begin
                            if(adjacency_matrix[j] == 1'b1)
                                num_adj = num_adj + 1;
                        end
                        past_cell_state = board_o[index];

                        if (past_cell_state == 1'b1 && (num_adj == 2 || num_adj == 3)) begin
                            internal_board[index] = 1'b1;
                        end else if (past_cell_state == 1'b1 && (num_adj < 2 || num_adj > 3)) begin
                            internal_board[index] = 1'b0;
                        end else if (past_cell_state == 1'b0 && num_adj == 3) begin
                            internal_board[index] = 1'b1;
                            birth_cnt_reg = birth_cnt_reg + 1;
                        end else begin
                            internal_board[index] = past_cell_state;
                        end
                        index = index + 1;
                        
                    end
           
                    board_o <= internal_board;
                    generation_cnt_o <= generation_cnt_o + 1;
                    birth_cnt_o <= birth_cnt_o + birth_cnt_reg;
                    birth_cnt_reg = 0;
                end
                STOP:
                    if(BtnR) state <= ALG;
            endcase
        end
    end
    /* MACHINE */
endmodule