`timescale 1ns/1ns

module Top_tb;

  reg clk;
  reg reset;

  // Instantiate the Top module
  Top top_inst (
    .clk(clk),
    .reset(reset)
  );

  wire [4:0] robo_row;
  wire [5:0] robo_col;
  wire [1:0] robo_orientacao;
  wire head, left, under, barrier;

  assign robo_row = top_inst.memo_inst.robo_row;
  assign robo_col = top_inst.memo_inst.robo_col;
  assign robo_orientacao = top_inst.memo_inst.robo_orientacao;

  assign head = top_inst.head;
  assign left = top_inst.left;
  assign under = top_inst.under;
  assign barrier = top_inst.barrier;

  // Generate clock signal
  always begin
    #5 clk = ~clk; // Clock period of 10 time units
  end

  initial begin
    // Initialize signals
    clk = 0;
    reset = 0;

    print_map();

    // Apply reset
    #10 reset = 1;
    #10 reset = 0;

    // Run the simulation for a certain time
    #1000 $finish;
  end

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
                for (j = 0; j < 20; j = j + 1) begin
                    $write("%h ", top_inst.memo_inst.map[i][j]);
                end
                $display("");
            end
        end
    endtask

endmodule

