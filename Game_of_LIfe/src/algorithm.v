//algorithm module for game of life

module algorithm 
    (
        input clk, 
        input enable,
        output reg[0:0] output_board[15:0][15:0],
        output integer death_cnt;
        output integer birth_cnt;
        output integer generation_cnt
    );

    if(enable)
    begin
        integer neighbor_cnt = 0;
        integer birth_cnt_tmp =0;
        integer death_cnt_tmp =0;
        integer deltaY[7:0] = {1, 1, 1, -1, -1, -1, 0, 0, 0};
        integer deltaX[7:0] = {1, 0, -1, 1, 0, -1, 1, 0, -1};
        reg[0:0] internal_board[15:0][15:0];

        always@(posedge clk)
        begin
            for(integer i = 0; i <= 15; i = i + 1){
                for(integer j = 0; j <= 15; j = j + 1){
                    internal_board[i][j] = output_board[i][j];
                }
            }
            birth_cnt_tmp =0;
            death_cnt_tmp =0;

            for(integer i = 0; i <= 15; i = i + 1){
                for(integer j = 0; j <= 15; j = j + 1){
                    for(integer n = 0; n <= 7; n = n + 1){
                        integer i_new = i + deltaY[n];
                        integer j_new = j + deltaX[n];

                        if(i_new == -1) i_new = 15;
                        if(j_new == -1) j_new = 15;
                        if(i_new == 16) i_new = 0;
                        if(j_new == 16) j_new = 0;

                        if(internal_board[i_new][j_new] == 1'b1) 
                            neighbor_cnt = neighbor_cnt + 1;
                    }

                    if((internal_board[i][j] == 1'b0) && (neighbor_cnt == 3))
                    begin
                        output_board[i][j] <= 1'b1;
                        birth_cnt_tmp = birth_cnt_tmp + 1;
                    end 
                    if((internal_board[i][j] == 1'b1) && ((neighbor_cnt > 3) || (neighbor_cnt < 2)))
                    begin
                        output_board[i][j] <= 1'b0;
                        death_cnt_tmp = death_cnt_tmp + 1;
                    end
                    neighbor_cnt = 0;
                }
            }
            death_cnt <= death_cnt + death_cnt_tmp;
            birth_cnt <= birth_cnt + birth_cnt_tmp;
            generation_cnt <= generation_cnt + 1;
        end  
    end
endmodule