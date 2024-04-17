module update_vga
    (
        input bright;
        input cell_state;
        input wire[11:0] cell_rgb;
        output reg[11:0] rgb;
    );
    
	parameter LIGHT_GREY = 12'b1011_1011_1011;
	parameter DARK_GREY = 12'b0011_0011_0011;

    always@ (*) begin
    	if (~bright)
		    rgb = DARK_GREY;
	    else if (cell_state)
		    rgb = cell_rgb;
	    else
		    rgb = LIGHT_GREY;
    end
endmodule