module Top(
	reset,
	manual_clock,
	clock,
	gamepad_input
);

input wire	reset;
input wire	manual_clock;
input wire	clock;
input wire [11:0] gamepad_input;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;

Memo	memo_inst(
	.clock(clock),
	.reset(reset),
	.avancar(SYNTHESIZED_WIRE_0),
	.girar(SYNTHESIZED_WIRE_1),
	.remover(SYNTHESIZED_WIRE_2),
	.manual_clock(manual_clock),
	.gamepad_input(gamepad_input),
	.head_out(SYNTHESIZED_WIRE_4),
	.left_out(SYNTHESIZED_WIRE_5),
	.under_out(SYNTHESIZED_WIRE_6),
	.barrier_out(SYNTHESIZED_WIRE_7),
	.clock_out(SYNTHESIZED_WIRE_3));
	defparam	memo_inst.BARRIER3 = 3'b010;
	defparam	memo_inst.BARRIER6 = 3'b011;
	defparam	memo_inst.BARRIER9 = 3'b100;
	defparam	memo_inst.BLACK = 3'b111;
	defparam	memo_inst.EAST = 2'b11;
	defparam	memo_inst.NORTH = 2'b00;
	defparam	memo_inst.PATH = 3'b001;
	defparam	memo_inst.SOUTH = 2'b10;
	defparam	memo_inst.WALL = 3'b000;
	defparam	memo_inst.WEST = 2'b01;


Robo robo_inst(
	.clock(SYNTHESIZED_WIRE_3),
	.reset(reset),
	.head(SYNTHESIZED_WIRE_4),
	.left(SYNTHESIZED_WIRE_5),
	.under(SYNTHESIZED_WIRE_6),
	.barrier(SYNTHESIZED_WIRE_7),
	.avancar(SYNTHESIZED_WIRE_0),
	.girar(SYNTHESIZED_WIRE_1),
	.remover(SYNTHESIZED_WIRE_2));
	defparam	robo_inst.Acompanhando_Muro = 2;
	defparam	robo_inst.Iniciando = 3;
	defparam	robo_inst.Procurando_Muro = 0;
	defparam	robo_inst.Removendo = 4;
	defparam	robo_inst.Rotacionando = 1;
	defparam	robo_inst.Standby = 5;
	defparam	robo_inst.WIDTH = 3;

endmodule
