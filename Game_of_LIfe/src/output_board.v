module output_board     
    (
        input clk,
        input reset,
        input wire[255:0] board_input,
        output reg[255:0] board_output
    ); 

    always @(posedge clk, posedge reset) begin
        if(reset)
            board_output <= 0;
        else
            board_output <= board_input;
    end
endmodule