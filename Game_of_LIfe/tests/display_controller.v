`timescale 1ns / 1ps

module display_controller
	(
	input clk,
	output hSync, vSync,
	output reg bright,
	output reg[9:0] hc, 
	output reg [9:0] vc
	);
	
	reg pulse;
	reg clk25;

	initial begin
		clk25 = 0;
		pulse = 0;
	end
	
	always @(posedge clk)
		pulse = ~pulse;

	always @(posedge pulse)
		clk25 = ~clk25;
		
	always @ (posedge clk25) begin
		if (hc < 799)
			hc <= hc + 1;
		else if (vc < 524) begin
			hc <= 0;
			vc <= vc + 1;
		end else begin
			hc <= 0;
			vc <= 0;
		end
	end

	assign hSync = (hc < 96) ? 1:0;
	assign vSync = (vc < 2) ? 1:0;
		
	always @(posedge clk25) begin
		if ((hc > 252 && hc < 675) && ((hc - 253) % 30 == 0 || (hc - 254) % 30 == 0))
		  bright <= 0;
		else if ((vc > 63 && vc < 486) && ((vc - 64) % 30 == 0 || (vc - 65) % 30 == 0))
		  bright <= 0;
	    else if(hc > 224 && hc < 703 && vc > 35 && vc < 514)
		  bright <= 1;
		else
		  bright <= 0;
	end	
endmodule