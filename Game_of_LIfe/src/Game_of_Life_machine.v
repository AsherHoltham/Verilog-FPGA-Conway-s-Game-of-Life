////////////////////////////////////////////////////////////
////////// Creators: Asher Holtham & Krishna Srikanth
////////// Creation date: sat. Apr 13 2024
////////// Design name: Game_of_Life_machine_top
////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Game_of_Life_machine 
    (   
        ClkPort,
        BtnL, BtnR, BtnU, BtnD, BtnC, 
        Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,
        board_o, generation_cnt_o
	);


	/*  INPUTS */
	input ClkPort;
	input BtnL, BtnR, BtnU, BtnD, BtnC, Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;	
    
    wire [15:0] cell_inputs;
    assign cell_inputs = {Sw15, Sw14, Sw13, Sw12, Sw11, Sw10, Sw9, Sw8, Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0};
	/*  INPUTS */

	/*  OUTPUTS */
    output reg[255:0] board_o;
    output reg[15:0] generation_cnt_o;
    /*  OUTPUTS */ 

    /* INTERNAL SIGNALS */
    reg[31:0] sys_clk;
    reg[2:0] state;
    wire[2:0] enable;
    wire reset;

    assign enable = state;
    assign reset = (BtnL || (state == 3'b000));

    wire [255:0] board_alg;
    wire [255:0] board_set;

    localparam
        SET	= 3'b001,
        ALG = 3'b010,
        STOP = 3'b100;
    /* INTERNAL SIGNALS */

    /* MODULES */
    array_transfer transf_(.clk(sys_clk[15]), .reset(reset), .select(select), .board_setup(board_set), .board_alrogithm(board_alg), .board_o(board_o));
    set_up set_(.clk(sys_clk[15]), .reset(reset), .select(select[0]), .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC), .cell_inputs(cell_inputs), .input_board(board_o), .board_o(board_set));
    algorithm algo_   (.clk(sys_clk[28]), .reset(reset), .select(select[1]), .input_board(board_o), .board_o(board_alg));  
    /* MODULES */

    initial begin 
        state = 3'b000;
    end

    always @(posedge ClkPort)
        sys_clk <= sys_clk + 1;
        
    always @(posedge sys_clk[28], posedge reset) 
    begin
        if (reset)
        begin
            board_alg <= 0;
            board_set <= 0;
            generation_cnt_o <= 0;
            state <= SET;
        end
        else if(sys_clk[27])
        begin
            case(state)
                SET:
                    if(BtnR) state <= ALG;
                ALG:
                begin
                    if(BtnR) state <= STOP;
                    generation_cnt_o <= generation_cnt_o + 1;
                end
                STOP:
                    if(BtnR) state <= ALG;
            endcase
        end
    end
endmodule