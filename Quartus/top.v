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
// CREATED		"Fri Aug 30 15:54:20 2024"

module top(
	reset,
	CLOCK_50,
	Pino1,
	Pino2,
	Pino3,
	Pino4,
	Pino6,
	Pino9,
	Manual_CLOCK,
	VGA_VS,
	VGA_HS,
	VGA_BLANK_N,
	VGA_CLK,
	select,
	LEDG,
	VGA_B,
	VGA_G,
	VGA_R
);


input wire	reset;
input wire	CLOCK_50;
input wire	Pino1;
input wire	Pino2;
input wire	Pino3;
input wire	Pino4;
input wire	Pino6;
input wire	Pino9;
input wire	Manual_CLOCK;
output wire	VGA_VS;
output wire	VGA_HS;
output wire	VGA_BLANK_N;
output wire	VGA_CLK;
output wire	select;
output wire	[8:0] LEDG;
output wire	[7:0] VGA_B;
output wire	[7:0] VGA_G;
output wire	[7:0] VGA_R;

wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	[11:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_23;
wire	[23:0] SYNTHESIZED_WIRE_14;
wire	[9:0] SYNTHESIZED_WIRE_17;
wire	[29:0] SYNTHESIZED_WIRE_18;
wire	[9:0] SYNTHESIZED_WIRE_19;
wire	[23:0] SYNTHESIZED_WIRE_20;

assign	VGA_VS = SYNTHESIZED_WIRE_22;
assign	VGA_CLK = SYNTHESIZED_WIRE_23;




Map	b2v_inst(
	.Clock50(SYNTHESIZED_WIRE_21),
	.Reset(reset),
	.v_sync(SYNTHESIZED_WIRE_22),
	.avancar(SYNTHESIZED_WIRE_2),
	.girar(SYNTHESIZED_WIRE_3),
	.remover(SYNTHESIZED_WIRE_4),
	.manual_clock(Manual_CLOCK),
	.Entradas(SYNTHESIZED_WIRE_5),
	.head_out(SYNTHESIZED_WIRE_7),
	.left_out(SYNTHESIZED_WIRE_8),
	.under_out(SYNTHESIZED_WIRE_9),
	.barrier_out(SYNTHESIZED_WIRE_10),
	.ClockRobo(SYNTHESIZED_WIRE_6),
	.ColunasSprites(SYNTHESIZED_WIRE_18),
	.LEDG(LEDG),
	.LinhasSprites(SYNTHESIZED_WIRE_20));
	defparam	b2v_inst.BLACK = 3'b111;
	defparam	b2v_inst.EAST = 2'b11;
	defparam	b2v_inst.LIXO1 = 3'b010;
	defparam	b2v_inst.LIXO2 = 3'b011;
	defparam	b2v_inst.LIXO3 = 3'b100;
	defparam	b2v_inst.NORTH = 2'b00;
	defparam	b2v_inst.PATH = 3'b001;
	defparam	b2v_inst.SOUTH = 2'b10;
	defparam	b2v_inst.WALL = 3'b000;
	defparam	b2v_inst.WEST = 2'b01;


Robo	b2v_inst2(
	.clock(SYNTHESIZED_WIRE_6),
	.reset(reset),
	.head(SYNTHESIZED_WIRE_7),
	.left(SYNTHESIZED_WIRE_8),
	.under(SYNTHESIZED_WIRE_9),
	.barrier(SYNTHESIZED_WIRE_10),
	.avancar(SYNTHESIZED_WIRE_2),
	.girar(SYNTHESIZED_WIRE_3),
	.remover(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst2.Acompanhando_Muro = 2;
	defparam	b2v_inst2.Iniciando = 3;
	defparam	b2v_inst2.Procurando_Muro = 0;
	defparam	b2v_inst2.Removendo = 4;
	defparam	b2v_inst2.Rotacionando = 1;
	defparam	b2v_inst2.Standby = 5;
	defparam	b2v_inst2.WIDTH = 3;


PLL	b2v_inst3(
	.inclk0(CLOCK_50),
	.c0(SYNTHESIZED_WIRE_21),
	.c1(SYNTHESIZED_WIRE_23));


Gamepad	b2v_inst4(
	.Clock50(SYNTHESIZED_WIRE_21),
	.Reset(reset),
	.Pino1(Pino1),
	.Pino2(Pino2),
	.Pino3(Pino3),
	.Pino4(Pino4),
	.Pino6(Pino6),
	.Pino9(Pino9),
	.v_sync(SYNTHESIZED_WIRE_22),
	.Select(select),
	.Saidas(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst4.AGUARDAR_ATIVACAO = 0;
	defparam	b2v_inst4.ESTADO_0 = 1;
	defparam	b2v_inst4.ESTADO_1 = 2;
	defparam	b2v_inst4.ESTADO_2 = 3;
	defparam	b2v_inst4.ESTADO_3 = 4;
	defparam	b2v_inst4.ESTADO_4 = 5;
	defparam	b2v_inst4.ESTADO_5 = 6;
	defparam	b2v_inst4.ESTADO_6 = 7;
	defparam	b2v_inst4.ESTADO_7 = 8;


VGA	b2v_inst6(
	.Clock(SYNTHESIZED_WIRE_23),
	.Reset(reset),
	.RGB(SYNTHESIZED_WIRE_14),
	.v_sync(SYNTHESIZED_WIRE_22),
	.h_sync(VGA_HS),
	.blank(VGA_BLANK_N),
	.B(VGA_B),
	.ColunaOut(SYNTHESIZED_WIRE_17),
	.G(VGA_G),
	.LinhaOut(SYNTHESIZED_WIRE_19),
	.R(VGA_R));


Grafico	b2v_inst7(
	.Clock50(SYNTHESIZED_WIRE_21),
	.Clock25(SYNTHESIZED_WIRE_23),
	.Reset(reset),
	.Coluna(SYNTHESIZED_WIRE_17),
	.ColunasSprites(SYNTHESIZED_WIRE_18),
	.Linha(SYNTHESIZED_WIRE_19),
	.LinhasSprites(SYNTHESIZED_WIRE_20),
	.RGB(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst7.AGUARDAR_COLUNA = 2;
	defparam	b2v_inst7.CODIGO_AZUL = 3'b001;
	defparam	b2v_inst7.CODIGO_BRANCO = 3'b010;
	defparam	b2v_inst7.CODIGO_CIANO = 3'b011;
	defparam	b2v_inst7.CODIGO_LARANJA = 3'b100;
	defparam	b2v_inst7.CODIGO_PRETO = 3'b101;
	defparam	b2v_inst7.CODIGO_TRANSPARENTE = 3'b000;
	defparam	b2v_inst7.CODIGO_VERDE = 3'b110;
	defparam	b2v_inst7.CODIGO_VERMELHO = 3'b111;
	defparam	b2v_inst7.COLUNA_DIREITA = 684;
	defparam	b2v_inst7.COLUNA_MAPA_1 = 364;
	defparam	b2v_inst7.COLUNA_MAPA_10 = 508;
	defparam	b2v_inst7.COLUNA_MAPA_11 = 524;
	defparam	b2v_inst7.COLUNA_MAPA_12 = 540;
	defparam	b2v_inst7.COLUNA_MAPA_13 = 556;
	defparam	b2v_inst7.COLUNA_MAPA_14 = 572;
	defparam	b2v_inst7.COLUNA_MAPA_15 = 588;
	defparam	b2v_inst7.COLUNA_MAPA_16 = 604;
	defparam	b2v_inst7.COLUNA_MAPA_17 = 620;
	defparam	b2v_inst7.COLUNA_MAPA_18 = 636;
	defparam	b2v_inst7.COLUNA_MAPA_19 = 652;
	defparam	b2v_inst7.COLUNA_MAPA_2 = 380;
	defparam	b2v_inst7.COLUNA_MAPA_20 = 668;
	defparam	b2v_inst7.COLUNA_MAPA_3 = 396;
	defparam	b2v_inst7.COLUNA_MAPA_4 = 412;
	defparam	b2v_inst7.COLUNA_MAPA_5 = 428;
	defparam	b2v_inst7.COLUNA_MAPA_6 = 444;
	defparam	b2v_inst7.COLUNA_MAPA_7 = 460;
	defparam	b2v_inst7.COLUNA_MAPA_8 = 476;
	defparam	b2v_inst7.COLUNA_MAPA_9 = 492;
	defparam	b2v_inst7.COR_AZUL = 24'b000000000000000011111111;
	defparam	b2v_inst7.COR_BRANCO = 24'b111111111111111111111111;
	defparam	b2v_inst7.COR_CIANO = 24'b000000001111111111111111;
	defparam	b2v_inst7.COR_LARANJA = 24'b111111111010010100000000;
	defparam	b2v_inst7.COR_PRETO = 24'b000000000000000000000000;
	defparam	b2v_inst7.COR_TRANSPARENTE = 24'b000000000000000000000000;
	defparam	b2v_inst7.COR_VERDE = 24'b000000001111111100000000;
	defparam	b2v_inst7.COR_VERMELHO = 24'b111111110000000000000000;
	defparam	b2v_inst7.FILEIRA_FINAL_LADO_DIREITO = 17;
	defparam	b2v_inst7.FILEIRA_FINAL_LADO_ESQUERDO = 16;
	defparam	b2v_inst7.IDLE = 0;
	defparam	b2v_inst7.LER_CELULA_PRETA = 4;
	defparam	b2v_inst7.LER_CURSOR = 14;
	defparam	b2v_inst7.LER_FILEIRA_MAPA = 1;
	defparam	b2v_inst7.LER_FUNDO = 3;
	defparam	b2v_inst7.LER_LIXO_1 = 6;
	defparam	b2v_inst7.LER_LIXO_2 = 8;
	defparam	b2v_inst7.LER_LIXO_3 = 10;
	defparam	b2v_inst7.LER_ROBO = 12;
	defparam	b2v_inst7.LINHA_INFERIOR = 314;
	defparam	b2v_inst7.LINHA_MAPA_1 = 235;
	defparam	b2v_inst7.LINHA_MAPA_10 = 376;
	defparam	b2v_inst7.LINHA_MAPA_2 = 251;
	defparam	b2v_inst7.LINHA_MAPA_3 = 267;
	defparam	b2v_inst7.LINHA_MAPA_4 = 283;
	defparam	b2v_inst7.LINHA_MAPA_5 = 299;
	defparam	b2v_inst7.LINHA_MAPA_6 = 314;
	defparam	b2v_inst7.LINHA_MAPA_7 = 329;
	defparam	b2v_inst7.LINHA_MAPA_8 = 344;
	defparam	b2v_inst7.LINHA_MAPA_9 = 360;
	defparam	b2v_inst7.MERGE_CELULA_PRETA = 5;
	defparam	b2v_inst7.MERGE_CURSOR = 15;
	defparam	b2v_inst7.MERGE_LIXO_1 = 7;
	defparam	b2v_inst7.MERGE_LIXO_2 = 9;
	defparam	b2v_inst7.MERGE_LIXO_3 = 11;
	defparam	b2v_inst7.MERGE_ROBO = 13;


endmodule
