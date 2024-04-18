`timescale 1ns / 1ps

module vga_bitchange(
	input clk,
	input bright,
	input [9:0] hCount, vCount,
	output reg [11:0] rgb
   );
	
	parameter BLACK = 12'b0000_0000_0000;
	parameter WHITE = 12'b1111_1111_1111;
	
	always@ (*) begin
    	if (~bright)
		  rgb = BLACK;
	   else 
		  rgb = WHITE;
	end
endmodule
