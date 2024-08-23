module top(
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

Memo	b2v_inst(
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
	defparam	b2v_inst.BARRIER3 = 3'b010;
	defparam	b2v_inst.BARRIER6 = 3'b011;
	defparam	b2v_inst.BARRIER9 = 3'b100;
	defparam	b2v_inst.BLACK = 3'b111;
	defparam	b2v_inst.EAST = 2'b11;
	defparam	b2v_inst.NORTH = 2'b00;
	defparam	b2v_inst.PATH = 3'b001;
	defparam	b2v_inst.SOUTH = 2'b10;
	defparam	b2v_inst.WALL = 3'b000;
	defparam	b2v_inst.WEST = 2'b01;


Robo	b2v_inst2(
	.clock(SYNTHESIZED_WIRE_3),
	.reset(reset),
	.head(SYNTHESIZED_WIRE_4),
	.left(SYNTHESIZED_WIRE_5),
	.under(SYNTHESIZED_WIRE_6),
	.barrier(SYNTHESIZED_WIRE_7),
	.avancar(SYNTHESIZED_WIRE_0),
	.girar(SYNTHESIZED_WIRE_1),
	.remover(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst2.Acompanhando_Muro = 2;
	defparam	b2v_inst2.Iniciando = 3;
	defparam	b2v_inst2.Procurando_Muro = 0;
	defparam	b2v_inst2.Removendo = 4;
	defparam	b2v_inst2.Rotacionando = 1;
	defparam	b2v_inst2.Standby = 5;
	defparam	b2v_inst2.WIDTH = 3;


endmodule
