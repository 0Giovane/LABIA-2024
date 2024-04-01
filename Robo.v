module Robo (clock, reset, head, left, avancar, girar);
input wire clock;
input wire reset ;
input wire head ; 
input wire left ;
output reg avancar ;
output reg girar ;
reg A,B,An,Bn;
reg [1:0] contador;

always @(*)
begin

	if (reset) begin
		An = 1'b0;
		contador = 2'b00;
	end else if (!head && left) begin
		An = 1'b1;
	end else begin
		An = 1'b0;
	end

	if (reset) begin
		Bn = 1'b0;
	end else if (!A && head || head && left || B && !left) begin
		Bn = 1'b1;
	end else begin
		Bn = 1'b0;
	end

end

always @(*)
begin

	if (!head && left || !A && !B && !head) begin
		avancar = 1'b1;
	end else begin
		avancar = 1'b0;
	end

	if (head || B && !left || A && !left) begin
		girar = 1'b1;
	end else begin
		girar = 1'b0;
	end

end

always @(posedge clock)
begin
	contador <= contador +1;
	if (contador == 2'b10) begin
		A <= An;
		B <= Bn;
		contador <= 2'b00;
	end
end

endmodule