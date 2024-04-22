module algorithm
    (
        input clk,
        input reset,
        input select,
        input wire[255:0] board_input,
        output reg[255:0] board_output
    );

    /* INTERNAL */
    integer i;
    integer j;
    integer adjacency_matrix[7:0];
    integer num_adj;
    reg[255:0] internal_board;
    reg past_cell_state;
    /* INTERNAL */

    initial begin
        adjacency_matrix[0] = 1;
        adjacency_matrix[1] = 15;
        adjacency_matrix[2] = 16;
        adjacency_matrix[3] = 17;
        adjacency_matrix[4] = -1;
        adjacency_matrix[5] = -15;
        adjacency_matrix[6] = -16;
        adjacency_matrix[7] = -17;
    end

    always @(posedge clk, posedge reset) begin
        if(reset)
            board_output <= 0;
        else begin
            internal_board = 0;
            for(i = 0; i <= 255; i = i + 1) begin
                num_adj = 0;
                for(j = 0; j <= 7; j = j + 1) begin
                    if (i + adjacency_matrix[j] >= 0 && i + adjacency_matrix[j] <= 255 &&
                        !((i % 16 == 0 && (adjacency_matrix[j] == -1 || adjacency_matrix[j] == -17 || adjacency_matrix[j] == 15)) ||
                        (i % 16 == 15 && (adjacency_matrix[j] == 1 || adjacency_matrix[j] == 17 || adjacency_matrix[j] == -15)) ||
                        (i < 16 && (adjacency_matrix[j] == -16 || adjacency_matrix[j] == -15 || adjacency_matrix[j] == -17)) ||
                        (i > 239 && (adjacency_matrix[j] == 16 || adjacency_matrix[j] == 15 || adjacency_matrix[j] == 17))))
                        if (board_input[i + adjacency_matrix[j]] == 1'b1)
                            num_adj = num_adj + 1;
                end

                past_cell_state = board_input[i];
                if ((past_cell_state == 1'b1 && (num_adj == 2 || num_adj == 3)) || (past_cell_state == 1'b0 && num_adj == 3))
                    internal_board[i] = 1'b1;
            end
            board_output <= internal_board;
        end
    end
endmodule