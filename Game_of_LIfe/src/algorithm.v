module algorithm     
    (
        input clk,
        input reset,
        input select,
        input wire[255:0] board_input,
        output reg[255:0] board_output
    ); 

    integer i;
    integer j;
    reg[3:0] num_adj;
    reg[255:0] index;
    reg[255:0] internal_board;
    reg[7:0] adjacency_matrix[3:0];
    reg past_cell_state;

    initial begin
        adjacency_matrix[0] = 1;
        adjacency_matrix[1] = 15;
        adjacency_matrix[2] = 16;
        adjacency_matrix[3] = 17;
    end

    always @(posedge clk, posedge reset) begin
        if(reset)
            board_output <= 0;
        else if(select) begin
            index = 0;
            internal_board = 0;
            for(i = 0; i <= 255; i = i + 1) begin
                num_adj = 0;
                for(j = 0; j <= 3; j = j + 1) 
                    if(board_input[index + adjacency_matrix[j]] == 1'b1) 
                        num_adj = num_adj + 1;
                
                for(j = 0; j <= 3; j = j + 1)
                    if(board_input[index - adjacency_matrix[j]] == 1'b1) 
                        num_adj = num_adj + 1;

                past_cell_state = board_input[index];

                if ((past_cell_state == 1'b1 && (num_adj == 2 || num_adj == 3)) || (past_cell_state == 1'b0 && num_adj == 3))
                    internal_board[index] = 1'b1;
                    
                index = index + 1;
            end
            board_output <= internal_board;
        end
    end
endmodule