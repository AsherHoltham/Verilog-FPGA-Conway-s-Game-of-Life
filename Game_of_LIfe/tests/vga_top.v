`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:00 12/14/2017 
// Design Name: 
// Module Name:    vga_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// Date: 04/04/2020
// Author: Yue (Julien) Niu
// Description: Port from NEXYS3 to NEXYS4
//////////////////////////////////////////////////////////////////////////////////
module vga_top(
	input ClkPort,
	
	//VGA signal
	output hSync, vSync,
	output [3:0] vgaR, vgaG, vgaB,
	);
	
	wire bright;
	wire[9:0] hc, vc;
	wire [11:0] rgb;
	
	display_controller dc(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .bright(bright), .hc(hc), .vc(vc));
	vga_bitchange vbc(.clk(ClkPort), .bright(bright), .hCount(hc), .vCount(vc), .rgb(rgb));
	
	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];
endmodule
