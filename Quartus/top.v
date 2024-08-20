module top(
	clock,
	reset
);


input wire	clock;
input wire	reset;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;

Robo	b2v_inst(
	.clock(clock),
	.reset(reset),
	.head(SYNTHESIZED_WIRE_0),
	.left(SYNTHESIZED_WIRE_1),
	.under(SYNTHESIZED_WIRE_2),
	.barrier(SYNTHESIZED_WIRE_3),
	.avancar(SYNTHESIZED_WIRE_4),
	.girar(SYNTHESIZED_WIRE_5),
	.remover(SYNTHESIZED_WIRE_6));
	defparam	b2v_inst.Acompanhando_Muro = 2;
	defparam	b2v_inst.Iniciando = 3;
	defparam	b2v_inst.Procurando_Muro = 0;
	defparam	b2v_inst.Removendo = 4;
	defparam	b2v_inst.Rotacionando = 1;
	defparam	b2v_inst.Standby = 5;
	defparam	b2v_inst.WIDTH = 3;


Memo	b2v_inst2(
	.clock(clock),
	.reset(reset),
	.avancar(SYNTHESIZED_WIRE_4),
	.girar(SYNTHESIZED_WIRE_5),
	.remover(SYNTHESIZED_WIRE_6),
	.head_out(SYNTHESIZED_WIRE_0),
	.left_out(SYNTHESIZED_WIRE_1),
	.under_out(SYNTHESIZED_WIRE_2),
	.barrier_out(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst2.BARRIER3 = 3'b010;
	defparam	b2v_inst2.BARRIER6 = 3'b011;
	defparam	b2v_inst2.BARRIER9 = 3'b100;
	defparam	b2v_inst2.BLACK = 3'b111;
	defparam	b2v_inst2.EAST = 2'b11;
	defparam	b2v_inst2.NORTH = 2'b00;
	defparam	b2v_inst2.PATH = 3'b001;
	defparam	b2v_inst2.SOUTH = 2'b10;
	defparam	b2v_inst2.WALL = 3'b000;
	defparam	b2v_inst2.WEST = 2'b01;


endmodule
