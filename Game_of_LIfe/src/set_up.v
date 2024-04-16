module set_up     
    (
        input clk,
        input reset,
        input select,
        input BtnU, BtnD, BtnC, 
        input reg[15:0] cell_inputs,
        input reg[255:0] input_board,
        output reg[255:0] board_o
    ); 

    reg[7:0] index;

    initial begin
        index = 0;
    end

    always @(posedge clk, posedge reset) begin
        if(reset)
            board_o <= 0;
            index <= 0;
        else if(clk && select) begin
            if(BtnC) begin
                board_o[(index * 16) +:16] <= cell_inputs;
            end
            if((BtnU) && (index > 0)) 
                index <= index - 1;
            if((BtnD) && (index < 15)) 
                index <= index + 1;
        end

    end
endmodule