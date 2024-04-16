module algorithm     
    (
        input clk,
        input reset,
        input select,
        input reg[255:0] input_board,
        output reg[255:0] board_o
    ); 

    integer i;
    integer j;
    reg[3:0] num_adj;
    reg[7:0] index;
    reg[255:0] internal_board;
    reg[7:0] adjacency_matrix[3:0];

    initial begin
        adjacency_matrix[0] = 1;
        adjacency_matrix[1] = 15;
        adjacency_matrix[2] = 16;
        adjacency_matrix[3] = 17;
    end

    always @(posedge clk, posedge reset) begin
        if(reset)
            board_o <= 0;
        else if(clk && select) begin
            index = 0;
            for(i = 0; i <= 255; i = i + 1) begin
                num_adj = 0;
                for(j = 0; j <= 3; j = j + 1) begin
                    if(input_board[index + adjacency_matrix[j]] == 1'b1) 
                        num_adj = num_adj + 1;
                end
                for(j = 0; j <= 3; j = j + 1) begin
                    if(input_board[index - adjacency_matrix[j]] == 1'b1) 
                        num_adj = num_adj + 1;
                end

                past_cell_state = input_board[index];

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
        end

    end

endmodule