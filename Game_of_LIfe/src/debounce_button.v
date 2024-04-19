module debounce_button (
    input clk,            
    input input_BtnN,   
    output reg BtnN 
);

    parameter INTERVAL = 1000000;

    reg [20:0] cnt = 0;              
    reg sampled_BtnN = 0;              

    initial begin
        sampled_BtnN = 0;
    end 

    always @(posedge clk) begin
        if (input_BtnN != sampled_BtnN) begin
            cnt <= 0;
            sampled_BtnN <= input_BtnN;
        end else if (cnt < INTERVAL) begin
            cnt <= cnt + 1;
        end else begin
            BtnN <= sampled_BtnN;
        end
    end
endmodule