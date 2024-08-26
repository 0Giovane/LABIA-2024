module Top(
	reset,
	manual_clock,
	clock,
	gamepad_input,
	v_sync,
	ColunasSprites,
	LinhasSprites,
	LEDG
);

input wire	reset;
input wire	manual_clock;
input wire	clock;
input wire [11:0] gamepad_input;
input wire v_sync;

output wire [17:0] LinhasSprites;
output wire [23:0] ColunasSprites;
output wire [8:0] LEDG;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;

Map map_inst(
	.Clock50(clock),
	.Reset(reset),
	.avancar(SYNTHESIZED_WIRE_0),
	.girar(SYNTHESIZED_WIRE_1),
	.remover(SYNTHESIZED_WIRE_2),
	.manual_clock(manual_clock),
	.Entradas(gamepad_input),
	.v_sync(v_sync),
	.head_out(SYNTHESIZED_WIRE_4),
	.left_out(SYNTHESIZED_WIRE_5),
	.under_out(SYNTHESIZED_WIRE_6),
	.barrier_out(SYNTHESIZED_WIRE_7),
	.ColunasSprites(ColunasSprites),
	.LinhasSprites(LinhasSprites),
	.LEDG(LEDG),
	.ClockRobo(SYNTHESIZED_WIRE_3));
	defparam	map_inst.LIXO1 = 3'b010;
	defparam	map_inst.LIXO2 = 3'b011;
	defparam	map_inst.LIXO3 = 3'b100;
	defparam	map_inst.BLACK = 3'b111;
	defparam	map_inst.EAST = 2'b11;
	defparam	map_inst.NORTH = 2'b00;
	defparam	map_inst.PATH = 3'b001;
	defparam	map_inst.SOUTH = 2'b10;
	defparam	map_inst.WALL = 3'b000;
	defparam	map_inst.WEST = 2'b01;


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
