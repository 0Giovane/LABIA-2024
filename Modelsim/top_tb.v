`timescale 1ns/1ns

module Top_tb;

  reg clk;
  reg reset;
  reg manual_clock;
  reg [11:0] gamepad_input;
  wire [3:0] robo_row; 
  wire [4:0] robo_col;
  wire [1:0] robo_orientacao;
  wire head, left, under, barrier;

  // Instantiate the Top module
  Top top_inst (
    .clock(clk),
    .reset(reset),
    .manual_clock(manual_clock),
    .gamepad_input(gamepad_input)
  );

  assign robo_row = top_inst.memo_inst.robo_row;
  assign robo_col = top_inst.memo_inst.robo_col;
  assign robo_orientacao = top_inst.memo_inst.robo_orientacao;

  assign head = top_inst.memo_inst.head_out;
  assign left = top_inst.memo_inst.left_out;
  assign under = top_inst.memo_inst.under_out;
  assign barrier = top_inst.memo_inst.barrier_out;

  // Generate clock signal
  always begin
    #5 clk = ~clk; // Clock period of 10 time units
  end

  initial begin
    // Initialize signals
    clk = 0;
    reset = 0;


    // Apply reset
    #10 reset = 1;
    #10 reset = 0;
    print_map();

    // Run the simulation for a certain time
    #1000 $finish;
  end

  // Função para buscar valor da célula no mapa
  function [2:0] get_map_value(input [3:0] row, input [4:0] col);
      integer start_bit;
  begin
      start_bit = 60'd59 - (col * 3);
      get_map_value = top_inst.memo_inst.fileira_mapa[row][start_bit -: 3];
  end
  endfunction

  // Monitor signals and display their values on every clock cycle
  always @(negedge clk) begin
    $display("Time: %0d, robo_row: %0d, robo_col: %0d, robo_orientacao: %0d",
             $time, top_inst.memo_inst.robo_row, top_inst.memo_inst.robo_col, top_inst.memo_inst.robo_orientacao);
  end

  // Task to print matrix values
  task print_map;
      integer i, j;
      begin
          $display("Map values:");
          for (i = 0; i < 10; i = i + 1) begin
              $write("Row %0d: ", i);
              $write("%b ", top_inst.memo_inst.fileira_mapa[i]);
              $display("");    
          end
      end
  endtask


endmodule

