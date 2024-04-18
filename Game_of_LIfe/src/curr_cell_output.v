module curr_cell_output
    (
        input clk,
        input wire[9:0] hc,
        input wire[9:0] vc,
        input wire[255:0] board,
        output reg cell_state
    );

    localparam H_OFFSET = 224;
    localparam  V_OFFSET = 35;
    localparam CELL_SIZE = 30;
    localparam  ROW_SIZE = 16;

    wire[7:0] index;
    assign index = (((vc - V_OFFSET) / CELL_SIZE) * ROW_SIZE) + ((hc - H_OFFSET) / CELL_SIZE);

    always @(posedge clk) begin
        cell_state <= board[index];
    end
endmodule