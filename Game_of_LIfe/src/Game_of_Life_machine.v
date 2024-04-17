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
    reg[2:0] state;
    wire reset;

    assign reset = (BtnL || (state == 3'b000));

    wire [255:0] board_alg;
    wire [255:0] board_set;
    wire [255:0] board_output;

    localparam
        SET	= 3'b001,
        ALG = 3'b010,
        STOP = 3'b100;
    /* INTERNAL SIGNALS */

    /* MODULES */
    array_transfer tran_(.clk(ClkPort), .reset(reset), .select(state), .board_setup(board_set), .board_alrogithm(board_alg), .board_output(board_output));
    set_up set_(.clk(ClkPort), .reset(reset), .select(state[0]), .BtnU(BtnU), .BtnD(BtnD), .BtnC(BtnC), .cell_inputs(cell_inputs), .board_input(board_output), .board_output(board_set));
    algorithm algo_(.clk(ClkPort), .reset(reset), .select(state[1]), .board_input(board_output), .board_output(board_alg));
    /* MODULES */

    initial 
        state = 3'b000;
    
    always @(posedge ClkPort, posedge reset) 
    begin
        if (reset)
            board_o <= 0;
        else    
            board_o <= board_output;
    end

    always @(posedge ClkPort, posedge reset) 
    begin
        if (reset)
        begin
            generation_cnt_o <= 0;
            state <= SET;
        end
        else if(ClkPort)
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