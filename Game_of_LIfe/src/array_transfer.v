`timescale 1ns / 1ps

module array_transfer 
    (
        input clk,
        input reset,
        input reg[2:0] select,
        input reg[255:0] board_setup,
        input reg[255:0] board_alrogithm,
        output reg[255:0] board_o
    ); 

    always @(posedge clk, posedge reset) begin
        if(reset)
            board_o <= 0;
        else if(clk) begin
            if(select[0]) 
                board_o <= board_setup;
            else 
                board_o <= board_alrogithm;
        end
    end

endmodule