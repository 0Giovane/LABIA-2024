module Top (input clk, input reset);

  wire head, left, under, barrier, avancar, girar, remover;

  robo robo_inst(
    .clock(clk),
    .reset(reset),
    .head(head),
    .left(left),
    .under(under),
    .barrier(barrier),
    .avancar(avancar),
    .girar(girar),
    .remover(remover)
  );

  memo memo_inst(
    .clock(clk),
    .reset(reset),
    .avancar(avancar),
    .girar(girar),
    .remover(remover),
    .head_out(head),
    .left_out(left),
    .under_out(under),
    .barrier_out(barrier)
  );

endmodule
