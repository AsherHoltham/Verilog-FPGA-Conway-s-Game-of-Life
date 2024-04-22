`timescale 1ns / 1ps

module array_transfer 
    (
        input clk,
        input reset,
        input wire[2:0] select,
        input wire[255:0] board_setup,
        input wire[255:0] board_alrogithm,
        output reg[255:0] board_output
    ); 


    always @(posedge clk, posedge reset) begin
        if(reset)
            board_output <= 0;
        else if(select[0]) 
            board_output <= board_setup;
        else
            board_output <= board_alrogithm;
    end
endmodule