//algorithm module for game of life
`timescale 1ns / 1ps

module algorithm_machine
    (
        input clk, 
        input enable,
        input wire[31:0] death_cnt_imp,
        input wire[31:0] birth_cnt_imp,
        input reg[255:0] board
        output reg[255:0] output_board,
        output reg[31:0] death_cnt,
        output reg[31:0] birth_cnt;
    );


    /* INTERNAL */
    reg[3:0] neighbor_cnt;
    reg[255:0] internal_board;
    reg[8:0] index;
    reg past_cell_state;

    reg TL;
    reg T;
    reg TR;
    reg R;
    reg L;
    reg BL;
    reg B;
    reg BR;
    /* INTERNAL */

    initial begin 
        neighbor_cnt = 0;
        internal_board = 0;
        index = 0;
        past_cell_state = board[0];
    end

    always @(posedge clk) begin
        if(enable) begin
            for(index = 0; index < 256; index = index + 1)
            begin
                past_cell_state <= board[index];
                neighbor_cnt = 0;
                TL = index -17;
                T = index - 16;
                TR = index - 15;
                R = index - 1;
                L = index + 1;
                BL = index + 15;
                B = index + 16;
                BR = index + 17;

                if(board[TL] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                if(board[T] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                if(board[TR] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                if(board[R] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                if(board[L] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                if(board[BL] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                if(board[B] == 1'b1) neighbor_cnt = neighbor_cnt + 1;
                if(board[BR] == 1'b1) neighbor_cnt = neighbor_cnt + 1;

                if (past_cell_state == 1'b1 && (neighbor_cnt == 2 || neighbor_cnt == 3)) begin
                    internal_board[index] <= 1'b1;
                end else if (past_cell_state == 1'b1 && (neighbor_cnt < 2 || neighbor_cnt > 3)) begin
                    internal_board[index] <= 1'b0;
                    death_cnt <= death_cnt_imp + 1;
                end else if (past_cell_state == 1'b0 && neighbor_cnt == 3) begin
                    internal_board[index] <= 1'b1;
                    birth_cnt <= birth_cnt_imp + 1;
                end else begin
                    internal_board[index] <= past_cell_state;
                end
            end 
            output_board <= internal_board;
        end
    end
endmodule