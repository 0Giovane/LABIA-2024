`timescale 1ns/1ns

module Memo_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg avancar;
    reg girar;
    reg remover;
    reg manual_clock;
    reg [11:0] gamepad_input;
    wire flag_mode;
    wire head_out;
    wire left_out;
    wire under_out;
    wire barrier_out;
    wire clock_out;  // Clock for the robot

    // Instantiate the Memo module
    Memo uut (
        .clock(clk),
        .reset(reset),
        .avancar(avancar),
        .girar(girar),
        .remover(remover),
        .manual_clock(manual_clock),
        .gamepad_input(gamepad_input),
        .head_out(head_out),
        .left_out(left_out),
        .under_out(under_out),
        .barrier_out(barrier_out),
        .clock_out(clock_out)
    );

    reg [1:0] robo_orientacao;
    reg [3:0] robo_row;    // Coluna da posição do robô (4 bits para 0-9)
    reg [4:0] robo_col;    // Coluna da posição do robô (5 bits para 0-19)

    assign robo_row = uut.robo_row;
    assign robo_col = uut.robo_col;
    assign robo_orientacao = uut.robo_orientacao;
    assign flag_mode = uut.flag_mode;

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
        manual_clock = 0;
        gamepad_input = 12'h0;

        // Apply reset
        #10;
        reset = 1;
        #10;
        reset = 0;

        // Print matrix values
        print_map();

        // Simulate some inputs
        avancar = 1;
        manual_clock = 1;
        #10;
        // avancar = 0;
        manual_clock = 0;
        // girar = 0;
        avancar = 0;
        remover = 1;
        $write("%b ", uut.fileira_mapa[7][59:57]);
        #30
        uut.fileira_mapa[7][59:57] = 3'b001;
        $write("%b ", uut.fileira_mapa[7][59:57]);
        #30
        $write("%b ", uut.fileira_mapa[7][59:57]);
        #30
        $write("%b ", uut.fileira_mapa[7][59:57]);
        avancar = 1;

        // Gamepad interaction
        gamepad_input = 12'b100000000000; // MODE pressionado
        #10;
        gamepad_input = 12'h0;
        #20;

        manual_clock = 1;
        #15;
        manual_clock = 0;
        #15;
        manual_clock = 1;
        #10;
        gamepad_input = 12'b100000000000;
        #5;
        gamepad_input = 12'h0;
        manual_clock = 0;

        #2;
        manual_clock = 1;

        #8;
        manual_clock = 0;

        #5;
        reset=1;
        #5;
        reset=0;

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
                $write("%b ", uut.fileira_mapa[i]);
                $display("");    
            end
        end
    endtask

endmodule
