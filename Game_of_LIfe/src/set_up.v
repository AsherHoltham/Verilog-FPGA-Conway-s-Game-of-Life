module set_up     
    (
        input clk,
        input reset,
        input select,
        input BtnU, BtnD, BtnC, 
        input wire[15:0] cell_inputs,
        input wire[255:0] board_input,
        output reg[255:0] board_output
    ); 

    reg[7:0] index;

    initial
        index = 0;

    always @(posedge clk, posedge reset) begin
        if(reset)
        begin
            board_output <= 0;
            index <= 0;
        end
        else if(select) begin
            board_output <= board_input;
            if(BtnC)
                board_output[(index * 16) +:16] <= cell_inputs;
            if((BtnU) && (index > 0)) 
                index <= index - 1;
            if((BtnD) && (index < 15)) 
                index <= index + 1;
        end
    end
endmodule