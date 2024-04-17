`timescale 1ns / 1ps

module display_controller
	(
	input clk,
	output hSync, vSync,
	output reg bright,
	output reg[4:0] row,
	output reg[4:0] col,
	output reg[9:0] hc, 
	output reg [9:0] vc
	);
	
	reg pulse;
	reg clk25;
	wire[4:0] row_out;
	wire[4:0] col_out;
		
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
		
	assign row_out = (((vc - 225) % 30));
	assign col_out = (((vc - 36) % 30));

	assign hSync = (hc < 96) ? 1:0;
	assign vSync = (vc < 2) ? 1:0;
		
	always @(posedge clk25) begin
    	if (((hc < 225) && (hc > 702) && (vc < 36) && (vc > 513))) begin
        	bright <= 0;
        	row <= 0;
        	col <= 0;
    	end else if (hc > 252) begin
        	if ((((hc - 253) % 30) == 0) || (((hc - 254) % 30) == 0)) begin
            	bright <= 0;
            	row <= 0;
            	col <= 0;
        	end
    	end else begin
        	bright <= 1;
        	row <= row_out;
        	col <= col_out;
    	end
	end
endmodule
