module update_vga
    (
        input bright,
        input cell_state,
        input wire[11:0] cell_rgb,
        output reg[11:0] rgb
    );
    
    parameter RED   = 12'b1111_0000_0000;	
    parameter WHITE = 12'b1111_1111_1111;

    always@ (*) begin
    	if (~bright)
		    rgb = RED;
	    else if (cell_state)
		    rgb = cell_rgb;
	    else
		    rgb = WHITE;
    end
endmodule