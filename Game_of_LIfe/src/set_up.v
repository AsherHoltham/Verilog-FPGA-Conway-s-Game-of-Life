module set_up 
    (
        input clk,
        input enable,
        input BTnU, BTnD, BtnC, 
		input Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        output integer I,
        output reg[0:0] output_board[15:0][15:0]
    );

    if(enable)
    begin
        I = 0;
        wire[15:0] cell_inputs;
        always@(posedge clk)
        begin
            assign cell_inputs = {Sw15, Sw14, Sw13, Sw12 ,Sw11, Sw10, Sw9, Sw8 ,Sw7, Sw6, Sw5, Sw4 ,Sw3, Sw2, Sw1, Sw0};
            if(BtnC)
            begin
                for(integer i = 0; i <= 15; i = i + 1){
                    output_board[I][i] <= cell_inputs[i];
                }
            end
            if((BtnU) && (I > 0)) 
                I <= I - 1;
            if((BtnD) && (row_index < 15)) 
                I <= I + 1;
        end
    end

endmodule