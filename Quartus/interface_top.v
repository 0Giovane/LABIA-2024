// Copyright (C) 2024  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 23.1std.1 Build 993 05/14/2024 SC Lite Edition"
// CREATED		"Fri Aug 23 19:23:58 2024"

module interface_top(
	reset,
	CLOCK_50
);


input wire	reset;
input wire	CLOCK_50;

wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	[11:0] SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;





Memo	b2v_inst(
	.clock(SYNTHESIZED_WIRE_11),
	.reset(reset),
	.avancar(SYNTHESIZED_WIRE_1),
	.girar(SYNTHESIZED_WIRE_2),
	.remover(SYNTHESIZED_WIRE_3),
	
	.gamepad_input(SYNTHESIZED_WIRE_4),
	.head_out(SYNTHESIZED_WIRE_6),
	.left_out(SYNTHESIZED_WIRE_7),
	.under_out(SYNTHESIZED_WIRE_8),
	.barrier_out(SYNTHESIZED_WIRE_9),
	.clock_out(SYNTHESIZED_WIRE_5));
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
	.clock(SYNTHESIZED_WIRE_5),
	.reset(reset),
	.head(SYNTHESIZED_WIRE_6),
	.left(SYNTHESIZED_WIRE_7),
	.under(SYNTHESIZED_WIRE_8),
	.barrier(SYNTHESIZED_WIRE_9),
	.avancar(SYNTHESIZED_WIRE_1),
	.girar(SYNTHESIZED_WIRE_2),
	.remover(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst2.Acompanhando_Muro = 2;
	defparam	b2v_inst2.Iniciando = 3;
	defparam	b2v_inst2.Procurando_Muro = 0;
	defparam	b2v_inst2.Removendo = 4;
	defparam	b2v_inst2.Rotacionando = 1;
	defparam	b2v_inst2.Standby = 5;
	defparam	b2v_inst2.WIDTH = 3;


PLL	b2v_inst3(
	.inclk0(CLOCK_50),
	.c0(SYNTHESIZED_WIRE_11)
	);


Gamepad	b2v_inst4(
	.Clock50(SYNTHESIZED_WIRE_11),
	.Reset(reset),
	
	
	
	
	
	
	
	
	.Saidas(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst4.AGUARDAR_ATIVACAO = 0;
	defparam	b2v_inst4.ESTADO_0 = 1;
	defparam	b2v_inst4.ESTADO_1 = 2;
	defparam	b2v_inst4.ESTADO_2 = 3;
	defparam	b2v_inst4.ESTADO_3 = 4;
	defparam	b2v_inst4.ESTADO_4 = 5;
	defparam	b2v_inst4.ESTADO_5 = 6;
	defparam	b2v_inst4.ESTADO_6 = 7;
	defparam	b2v_inst4.ESTADO_7 = 8;


endmodule
