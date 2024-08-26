`timescale 1ns/1ns

module Top_tb;

  reg clk;
  reg reset;
  reg manual_clock;
  reg [11:0] gamepad_input;
  wire [3:0] LinhaRobo; 
  wire [4:0] ColunaRobo;
  wire [1:0] OrientacaoRobo;
  wire head, left, under, barrier, flag_mode, clock_robo, avancar, girar, remover;
  reg v_sync;
  wire [23:0] ColunasSprites;
  wire [17:0] LinhasSprites;
  wire [8:0] LEDG;

  // Instantiate the Top module
  Top top_inst (
    .clock(clk),
    .reset(reset),
    .manual_clock(manual_clock),
    .gamepad_input(gamepad_input),
    .v_sync(v_sync),
    .LinhasSprites(LinhasSprites),
    .ColunasSprites(ColunasSprites),
    .LEDG(LEDG)
  );

  assign LinhaRobo = top_inst.map_inst.LinhaRobo;
  assign ColunaRobo = top_inst.map_inst.ColunaRobo;
  assign OrientacaoRobo = top_inst.map_inst.OrientacaoRobo;

  assign head = top_inst.map_inst.head_out;
  assign left = top_inst.map_inst.left_out;
  assign under = top_inst.map_inst.under_out;
  assign barrier = top_inst.map_inst.barrier_out;

  assign avancar = top_inst.SYNTHESIZED_WIRE_0;
  assign girar = top_inst.SYNTHESIZED_WIRE_1;
  assign remover = top_inst.SYNTHESIZED_WIRE_2; 

  assign flag_mode = top_inst.map_inst.flag_mode;
  assign clock_robo = top_inst.SYNTHESIZED_WIRE_3;

  // Generate clock signal
  always begin
    #5 clk = ~clk; // Clock period of 10 time units
  end

  initial begin
    gamepad_input = 12'h0;

    // Initialize signals
    clk = 0;
    reset = 0;
    v_sync = 0;

    // Apply reset
    #10 reset = 1;
    #10 reset = 0;

    v_sync = 1;
    gamepad_input[11] = 1; // Ativa o clock automático

    print_map();

    // Run the simulation for a certain time
    #1000 $finish;
  end

  // Função para buscar valor da célula no mapa
  function [2:0] get_map_value(input [3:0] row, input [4:0] col);
      integer start_bit;
  begin
      start_bit = 60'd59 - (col * 3);
      get_map_value = top_inst.map_inst.fileira_mapa[row][start_bit -: 3];
  end
  endfunction

  // Monitor signals and display their values on every clock cycle
  always @(negedge clk) begin
    $display("Time: %0d, LinhaRobo: %0d, ColunaRobo: %0d, OrientacaoRobo: %0d",
             $time, top_inst.map_inst.LinhaRobo, top_inst.map_inst.ColunaRobo, top_inst.map_inst.OrientacaoRobo);
  end

  // Task to print matrix values
  task print_map;
      integer i, j;
      begin
          $display("Map values:");
          for (i = 0; i < 10; i = i + 1) begin
              $write("Row %0d: ", i);
              $write("%b ", top_inst.map_inst.fileira_mapa[i]);
              $display("");    
          end
      end
  endtask


endmodule

