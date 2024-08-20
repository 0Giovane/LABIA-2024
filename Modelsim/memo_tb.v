`timescale 1ns/1ns

module Memo_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg avancar;
    reg girar;
    reg remover;
    wire head_out;
    wire left_out;
    wire under_out;
    wire barrier_out;
    wire [3:0] robo_row;
    wire [4:0] robo_col;
    wire [1:0] robo_orientacao;

    // Instantiate the memo module
    Memo uut (
        .clock(clk),
        .reset(reset),
	    .avancar(avancar),
        .girar(girar),
        .remover(remover),
        .head_out(head_out),
        .left_out(left_out),
        .under_out(under_out),
        .barrier_out(barrier_out)
    );

    assign robo_row = uut.robo_row;
    assign robo_col = uut.robo_col;
    assign robo_orientacao = uut.robo_orientacao;

    // Função para converter valor de row e col no vetor unidimensional
    function [7:0] get_map_index;
        input [3:0] row; // 4 bits to index rows (0-9)
        input [4:0] col; // 5 bits to index columns (0-19)
        reg [7:0] index;
    begin
        index = row * 8'd20 + col; // Calcular o index no vetor unidimensional
        get_map_index = index; // Return the calculated index
    end
    endfunction

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period of 10 time units
	forever begin
	    $write("Row: %0d ", uut.robo_row);
	    $write("Col: %0d ", uut.robo_col);
	    $write("Orientacao: %0d ", uut.robo_orientacao);
	    $display("");
	end
    end

    // Testbench initialization and stimulus
    initial begin
        // Initialize inputs
        reset = 0;
        avancar = 0;
        girar = 0;
        remover = 0;

	// Print matrix values
        print_map();

        // Apply reset
        #10;
        reset = 1;

        // Wait for a short while to let the module process
        #10;
	
	reset = 0;
	avancar = 1;

	#10
	
	avancar = 0;
	girar= 1;

	#10
	$write("Row: %0d ", uut.robo_row);
	$write("Col: %0d ", uut.robo_col);
	$write("Orientacao: %0d ", uut.robo_orientacao);
	$display("");

    // End the simulation
    #100;
    $finish;
    end

    // Task to print matrix values
    task print_map;
        integer i, j;
        begin
            $display("Map values:");
            for (i = 0; i < 10; i = i + 1) begin
                $write("Row %0d: ", i);
                for (j = 0; j < 20; j = j + 1) begin
                    $write("%h ", uut.map[get_map_index(i,j)]);
                end
                $display("");
            end
        end
    endtask

endmodule

