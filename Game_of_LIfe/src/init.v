module init 
    (
        input wire[31:0] clk,
        input enable,
        output reg[31:0] death_cnt,
        output reg[31:0] birth_cnt,
        output reg[255:0] output_board
    );

    always@(posedge clk[15])
    begin
        if(enable)
        begin
            death_cnt <= 0;
            birth_cnt <= 0;
            output_board <= 0;
        end
    end
endmodule