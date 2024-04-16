`timescale 1ns / 1ps
module set_up 
    (
        input clk,
        input enable,
        input BtnU, BtnD, BtnC, 
        input wire [15:0] cell_inputs,
        output reg[255:0] output_board
    );


    reg[3:0] I = 0;
    reg[7:0] starting_I = 0;

    always@(posedge clk)
    begin
        starting_I = I * 16;
        if(enable)
        begin
            if(BtnC)
            begin
                output_board[starting_I +:16] <= cell_inputs;
            end
            if((BtnU) && (I > 4'b0000)) 
                I <= I - 1;
            if((BtnD) && (I < 4'b1111)) 
                I <= I + 1;
        end
    end
endmodule