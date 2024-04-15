module init 
    (
        input enable,
        output integer death_cnt;
        output integer birth_cnt;
        output integer generation_cnt;
        output reg[0:0] output_board[15:0][15:0]
    );

    if(enale)
    begin
        death_cnt <= 0;
        birth_cnt <= 0;
        generation_cnt <= 0;
        for(integer i = 0; i <= 15; i = i + 1){
            for(integer j = 0; j <= 15; j = j + 1){
                output_board[i][j]  <= 1'b0;
            }
        }
    end
endmodule