`include "environment.vh"

module init 
    (
        output environment_t input_environment, 
        output environment_t output_engironment
        output integer death_cnt;
        output integer birth_cnt;
    );

    death_cnt = 0;
    birth_cnt = 0;
    for(integer i = 0; i <= 15; i = i + 1){
        for(integer j = 0; j <= 15; j = j + 1){
            input_environment[i][j] = 1'b0;
            output_environment[i][j] = 1'b0;
        }
    }


endmodule