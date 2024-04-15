//algorithm module for game of life

module algorithm 
    (
        input integer death_cnt;
        input integer birth_cnt;
        input reg[0:0] input_board[15:0][15:0], 
        output reg[0:0] output_board[15:0][15:0]
    );
    
    integer neighbor_cnt = 0;
    integer n_yaxis[7:0] = {1, 1, 1, -1, -1, -1, 0, 0, 0};
    integer n_xaxis[7:0] = {1, 0, -1, 1, 0, -1, 1, 0, -1};


    for(integer i = 0; i <= 15; i = i + 1){
        for(integer j = 0; j <= 15; j = j + 1){
            for(integer n = 0; n <= 7; n = n + 1){
                integer i_new = i + n_yaxis[n];
                integer j_new = j + n_xaxis[n];
                if(i_new == -1){
                    i_new = 15;
                }
                if(j_new == -1){
                    j_new = 15;
                }
                if(i_new == 16){
                    i_new = 0;
                }
                if(j_new == 16){
                    j_new = 0;
                }

                if(input_environment[i_new][j_new] == 1){
                    neighbor_cnt = neighbor_cnt + 1;
                }
            }
            if((input_environment[i][j] == 0) && (neighbor_cnt == 3)){
                output_environment[i][j] = 1'b1;
                birth_cnt = birth_cnt + 1;
            } 
            if((input_environment[i][j] == 1) && ((neighbor_cnt == 3) || (neighbor_cnt == 2))){
                output_environment[i][j] = 1'b1;
            }
            if((input_environment[i][j] == 1) && ((neighbor_cnt > 3) || (neighbor_cnt < 2))){
                output_environment[i][j] = 1'b0;
                death_cnt = death_cnt + 1;
            }
            neighbor_cnt = 0;
        }
    }
    
endmodule








