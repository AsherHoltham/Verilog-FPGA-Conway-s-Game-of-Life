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

    reg[3:0] index;

    initial
        index = 0;

    always @(posedge clk, posedge reset) begin
        if(reset)
            board_output <= 0;
        else if(select) begin
            board_output <= board_input;
            if(BtnC)
                board_output[(index*16)+:16] <= cell_inputs;
        end
    end
    always @(posedge BtnU, posedge BtnD, posedge reset) begin
        if(reset)
            index <= 0;
        else begin
            if(BtnU) 
                index = index - 1;
            else if(BtnD) 
                index = index + 1;
        end
    end
endmodule