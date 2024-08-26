module Map(Clock50, Reset, Entradas, v_sync, ColunasSprites, LinhasSprites, LEDG, avancar, girar, remover, manual_clock, head_out, left_out, under_out, barrier_out, ClockRobo);

input Clock50, Reset, v_sync;
input [11:0] Entradas;
input avancar, girar, remover, manual_clock;

output reg head_out, left_out, under_out, barrier_out;
output wire ClockRobo; // Clock para o robô
output reg [29:0] ColunasSprites; // 6 * 5 bits
output reg [23:0] LinhasSprites; // 6 * 4 bits
output reg [8:0] LEDG;

// ------ Registradores internos ------
reg [59:0] fileira_mapa [0:9]; // Matriz 10x20 x 3 bits
reg [1:0] barrier_counter; // Contador de clock para BARRIER
integer row, col;
reg [2:0] current_barrier;

reg flag_mode; // Flag para ativação do MODE no gamepad
wire selected_clock; // Assume "manual_clock" ou "clock" dependendo da "flag_mode"

reg [1:0] OrientacaoRobo;  // Orientação do robô

// Posicao de Sprites
reg [4:0] ColunaCelulaPreta;
reg [4:0] ColunaLixo1;
reg [4:0] ColunaLixo2;
reg [4:0] ColunaLixo3;
reg [4:0] ColunaRobo;
reg [4:0] ColunaCursor;

reg [3:0] LinhaCelulaPreta;
reg [3:0] LinhaLixo1;
reg [3:0] LinhaLixo2;
reg [3:0] LinhaLixo3;
reg [3:0] LinhaRobo;
reg [3:0] LinhaCursor;

reg [5:0] ContadorFrames;
reg HabilitaNovaLeitura;

// Parâmetros para as celulas
parameter WALL = 3'h0,
            PATH = 3'h1,
            LIXO1 = 3'h2,
            LIXO2 = 3'h3,
            LIXO3 = 3'h4,
            BLACK = 3'h7;

// Par?metros para a orientação do robô
parameter NORTH = 2'b00, 
            WEST = 2'b01, 
            SOUTH  = 2'b10, 
            EAST  = 2'b11;

// Flag baseado na deteccao de borda de subida de v_sync

reg v_sync_Primeiro_FlipFLop, v_sync_Segundo_FlipFLop;
wire Flag;

// Lógica para vsync
always @(negedge Clock50)
begin
	v_sync_Primeiro_FlipFLop <= v_sync;
	v_sync_Segundo_FlipFLop <= v_sync_Primeiro_FlipFLop;
end

assign Flag = v_sync_Primeiro_FlipFLop && !v_sync_Segundo_FlipFLop;

// Função para buscar valor da célula no mapa
function [2:0] get_map_value(input [3:0] row, input [4:0] col);
    integer start_bit;
begin
    start_bit = 60'd59 - (col * 3);
    get_map_value = fileira_mapa[row][start_bit -: 3];
end
endfunction

// Função para setar valor da célula no mapa
task set_column_bits(input [3:0] row, input [4:0] column, input [2:0] value);
    integer start_bit;
begin
    start_bit = 60'd59 - (col * 3);
    fileira_mapa[row][start_bit -: 3] = value;
end
endtask

// Lógica para selecionar o clock com base no flag_mode
assign selected_clock = (!flag_mode) ? manual_clock : Clock50;
assign ClockRobo = selected_clock; // Saída de clock para o robô

// Lógica da movimentação do robô
always @(posedge ClockRobo) begin
	// Lógica para girar
	if (girar) begin
			if (OrientacaoRobo == EAST) // Retorna para o NORTH
					OrientacaoRobo <= NORTH; 
			else
					OrientacaoRobo <= OrientacaoRobo + 2'b01; // Rotaciona no sentido anti-hor?rio
	end

	// Lógica para avançar
	else if (avancar) begin
			case (OrientacaoRobo)
					NORTH:
							LinhaRobo <= LinhaRobo - 4'b0001;
					WEST:
							ColunaRobo <= ColunaRobo - 4'b0001;
					SOUTH:
							LinhaRobo <= LinhaRobo + 4'b0001;
					EAST:
							ColunaRobo <= ColunaRobo + 4'b0001;
			endcase
	end

	// Lógica para remover
	else if (remover) begin
			barrier_counter <= barrier_counter + 2'b01;

			if (barrier_counter == 2'b10) begin // Conta até 2
					case (OrientacaoRobo)
							NORTH: begin
									row = LinhaRobo - 4'b0001;
									col = ColunaRobo;
							end
							WEST: begin
									row = LinhaRobo;
									col = ColunaRobo - 4'b0001;
							end
							SOUTH: begin
									row = LinhaRobo + 4'b0001;
									col = ColunaRobo;
							end
							EAST: begin
									row = LinhaRobo;
									col = ColunaRobo + 4'b0001;
							end
					endcase

					current_barrier = get_map_value(row, col);

					// Realiza o downgrade da barreira
					case (current_barrier)
							LIXO3: 
									set_column_bits(row, col, LIXO2);
							LIXO2: 
									set_column_bits(row, col, LIXO1);
							LIXO1: 
							begin
									set_column_bits(row, col, PATH);
									barrier_out <= 0;
							end
					endcase
					barrier_counter <= 2'b00; // Reseta o contador
			end
	end
end

always @(posedge Clock50 or posedge Reset) begin
	if (Reset) begin		
		flag_mode <= 0;

		ColunaCelulaPreta <= 0;
		ColunaLixo1 <= 2;
		ColunaLixo2 <= 5;
		ColunaLixo3 <= 7;
		ColunaRobo <= 0;
		ColunaCursor <= 0;
		
		LinhaCelulaPreta <= 9;		
		LinhaLixo1 <= 6;		
		LinhaLixo2 <= 8;		
		LinhaLixo3 <= 8;		
		LinhaRobo <= 9;		
		LinhaCursor <= 9;
		
		HabilitaNovaLeitura = 1;

		OrientacaoRobo <= NORTH;
		barrier_counter <= 2'b00;
		barrier_out <= 0;

		// Inicialização da matriz no reset
		fileira_mapa[0] <= 60'b000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[1] <= 60'b000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[2] <= 60'b000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[3] <= 60'b000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[4] <= 60'b000_000_001_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[5] <= 60'b000_000_001_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[6] <= 60'b000_000_010_000_000_000_000_001_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[7] <= 60'b000_000_001_000_000_000_000_001_000_000_000_000_000_000_000_000_000_000_000_000;
		fileira_mapa[8] <= 60'b001_001_001_001_001_011_001_100_001_001_001_001_001_001_001_001_001_001_001_001;
		fileira_mapa[9] <= 60'b111_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000_000;
	end

	if (HabilitaNovaLeitura && Flag) begin
		HabilitaNovaLeitura <= 0;
		ContadorFrames <= 0;		
		
		// Tratamento de entradas do gamepad
		// Entradas[11] = Saida_Mode
		// Entradas[10] = Saida_Start
		// Entradas[9] = Saida_Z
		// Entradas[8] = Saida_Y
		// Entradas[7] = Saida_X
		// Entradas[6] = Saida_C
		// Entradas[5] = Saida_B
		// Entradas[4] = Saida_A
		// Entradas[3] = Saida_Right
		// Entradas[2] = Saida_Left
		// Entradas[1] = Saida_Down
		// Entradas[0] = Saida_Up 

		if(Entradas[11]) begin
			flag_mode <= !flag_mode;
		end
		
		if (Entradas[9]) begin
			ColunaLixo3 <= ColunaCursor;
			LinhaLixo3 <= LinhaCursor;

			set_column_bits(LinhaLixo3, ColunaLixo3, LIXO3);
		end

		if (Entradas[8]) begin
			ColunaLixo2 <= ColunaCursor;
			LinhaLixo2 <= LinhaCursor;

			set_column_bits(LinhaLixo2, ColunaLixo2, LIXO2);
		end
		
		if (Entradas[7]) begin
			ColunaLixo1 <= ColunaCursor;
			LinhaLixo1 <= LinhaCursor;

			set_column_bits(LinhaLixo1, ColunaLixo1, LIXO1);
		end

		if (Entradas[5]) begin
			ColunaCelulaPreta <= ColunaCursor;
			LinhaCelulaPreta <= LinhaCursor;

			set_column_bits(LinhaCelulaPreta, ColunaCelulaPreta, BLACK);
		end

		if (Entradas[4]) begin
			ColunaRobo <= ColunaCursor;
			LinhaRobo <= LinhaCursor;
		end

		if (Entradas[0]) begin
			if (LinhaCursor == 0)
				LinhaCursor <= 9;
			else
				LinhaCursor <= LinhaCursor - 1;
		end
		
		if (Entradas[1]) begin
			if (LinhaCursor == 9)
				LinhaCursor <= 0;
			else
				LinhaCursor <= LinhaCursor + 1;
		end
		
		if (Entradas[2]) begin
			if (ColunaCursor == 0)
				ColunaCursor <= 19;
			else
				ColunaCursor <= ColunaCursor - 1;
		end
		
		if (Entradas[3]) begin
			if (ColunaCursor == 10)
				ColunaCursor <= 1;
			else
				ColunaCursor <= ColunaCursor + 1;
		end		
	end

	if (Flag) begin
		if (ContadorFrames == 4)
		begin
			HabilitaNovaLeitura <= 1;
			ContadorFrames <= 0;
		end
		else
		begin
			ContadorFrames <= ContadorFrames + 1;	
		end	
	end
end

always @(negedge Clock50) begin
		ColunasSprites <= {ColunaCelulaPreta, ColunaLixo1, ColunaLixo2, ColunaLixo3, ColunaRobo, ColunaCursor};
		LinhasSprites <= {LinhaCelulaPreta, LinhaLixo1, LinhaLixo2, LinhaLixo3, LinhaRobo, LinhaCursor};
end

// Logica combinacional das saidas
always @(*) begin
    case (OrientacaoRobo)
        NORTH: begin
            // Lógica do head_out
            if (LinhaRobo == 0 || get_map_value(LinhaRobo - 4'b0001, ColunaRobo) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (ColunaRobo == 0 || get_map_value(LinhaRobo,ColunaRobo - 4'b0001) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(LinhaRobo,ColunaRobo) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (LinhaRobo != 0 && 
                (get_map_value(LinhaRobo - 4'b0001, ColunaRobo) == LIXO1 || 
                get_map_value(LinhaRobo - 4'b0001, ColunaRobo) == LIXO2 || 
                get_map_value(LinhaRobo - 4'b0001, ColunaRobo) == LIXO3)) begin
                barrier_out = 1;
	            end
        end
        WEST: begin
            // Lógica do head_out
            if (ColunaRobo == 0 || get_map_value(LinhaRobo,ColunaRobo - 4'b0001) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (LinhaRobo == 9 || get_map_value(LinhaRobo + 4'b0001,ColunaRobo) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(LinhaRobo,ColunaRobo) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (ColunaRobo != 0 && 
                (get_map_value(LinhaRobo,ColunaRobo - 4'b0001) == LIXO1 || 
                get_map_value(LinhaRobo,ColunaRobo - 4'b0001) == LIXO2 || 
                get_map_value(LinhaRobo,ColunaRobo - 4'b0001) == LIXO3)) begin
                barrier_out = 1;
            end
        end
        SOUTH: begin
            // Lógica do head_out
            if (LinhaRobo == 9 || get_map_value(LinhaRobo + 4'b0001,ColunaRobo) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (ColunaRobo == 19 || get_map_value(LinhaRobo,ColunaRobo + 4'b0001) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(LinhaRobo,ColunaRobo) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (LinhaRobo != 9 && 
                (get_map_value(LinhaRobo + 4'b0001,ColunaRobo) == LIXO1 || 
                get_map_value(LinhaRobo + 4'b0001,ColunaRobo) == LIXO2 || 
                get_map_value(LinhaRobo + 4'b0001,ColunaRobo) == LIXO3)) begin
                barrier_out = 1;
            end
        end
        EAST: begin
            // Lógica do head_out
            if (ColunaRobo == 19 || get_map_value(LinhaRobo,ColunaRobo + 4'b0001) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (LinhaRobo == 0 || get_map_value(LinhaRobo - 4'b0001,ColunaRobo) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(LinhaRobo,ColunaRobo) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (ColunaRobo != 19 && 
                (get_map_value(LinhaRobo,ColunaRobo + 4'b0001) == LIXO1 || 
                get_map_value(LinhaRobo,ColunaRobo + 4'b0001) == LIXO2 || 
                get_map_value(LinhaRobo,ColunaRobo + 4'b0001) == LIXO3)) begin
                barrier_out = 1;
            end
        end
        default: begin
            head_out = 0;
            left_out = 0;
        end
    endcase
end

always @(LinhaRobo, ColunaRobo) begin
	// Os leds representam a linha e coluna do robô
	LEDG <= {LinhaRobo, ColunaRobo};
end
endmodule 