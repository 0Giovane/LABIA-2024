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
reg [59:0] FileiraMapa [0:9]; // Matriz 10x20 x 3 bits
reg [3:0] barrier_counter; // Contador de clock para BARRIER
integer row, col;
reg [3:0] current_barrier;

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

reg [3:0] temp_LinhaLixo1;
reg [3:0] temp_LinhaLixo2;
reg [3:0] temp_LinhaLixo3;

reg [4:0] temp_ColunaLixo1;
reg [4:0] temp_ColunaLixo2;
reg [4:0] temp_ColunaLixo3;

// Parâmetros para o mapa
parameter WALL = 3'h0,
            PATH = 3'h1,
            LIXO1 = 3'h2,
            LIXO2 = 3'h3,
            LIXO3 = 3'h4,
						NULL = 3'h5,
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
always @(negedge Clock50) begin
	v_sync_Primeiro_FlipFLop <= v_sync;
	v_sync_Segundo_FlipFLop <= v_sync_Primeiro_FlipFLop;
end

assign Flag = v_sync_Primeiro_FlipFLop && !v_sync_Segundo_FlipFLop;

// Lógica para selecionar o clock com base no flag_mode
assign selected_clock = (!flag_mode) ? manual_clock : Clock50;
assign ClockRobo = selected_clock; // Saída de clock para o robô

// Função para buscar valor da célula no mapa
function [2:0] get_map_value(input [3:0] row, input [4:0] col);
    integer start_bit;
begin
    start_bit = 60'd59 - (col * 3);
    get_map_value = FileiraMapa[row][start_bit -: 3];
end
endfunction

always @(posedge ClockRobo or posedge Reset) begin
	if (Reset) begin		
		flag_mode <= 0;

		ColunaCelulaPreta <= 0;
		ColunaLixo1 <= 2;
		ColunaLixo2 <= 3;
		ColunaLixo3 <= 4;
		ColunaRobo <= 0;
		ColunaCursor <= 0;
		
		LinhaCelulaPreta <= 9;		
		LinhaLixo1 <= 6;		
		LinhaLixo2 <= 6;		
		LinhaLixo3 <= 6;		
		LinhaRobo <= 9;		
		LinhaCursor <= 9;

		temp_LinhaLixo1 <= 6;
		temp_LinhaLixo2 <= 6;
		temp_LinhaLixo3 <= 6;

		temp_ColunaLixo1<= 2;
		temp_ColunaLixo2<= 3;
		temp_ColunaLixo3<= 4;
		
		HabilitaNovaLeitura <= 1;

		OrientacaoRobo <= NORTH;
		barrier_counter <= 2'b00;

		// Inicialização da matriz no reset
		FileiraMapa[0] <= 60'b000_000_000_000_000_000_000_000_000_001_001_001_001_001_001_000_000_000_000_000;
		FileiraMapa[1] <= 60'b000_000_000_000_000_000_000_000_000_001_000_000_000_000_001_000_000_000_000_000;
		FileiraMapa[2] <= 60'b000_000_000_000_000_001_000_000_000_001_000_000_000_000_001_001_001_001_001_001;
		FileiraMapa[3] <= 60'b000_000_000_000_000_001_001_001_001_001_000_000_000_000_000_000_000_000_000_000;
		FileiraMapa[4] <= 60'b000_000_000_000_000_001_000_000_000_001_000_000_000_000_000_000_001_001_001_001;
		FileiraMapa[5] <= 60'b000_000_000_000_000_001_000_000_000_001_000_000_000_001_001_001_001_000_000_000;
		FileiraMapa[6] <= 60'b001_001_001_001_001_001_000_000_000_001_001_001_001_001_000_000_000_000_000_000;
		FileiraMapa[7] <= 60'b001_000_000_000_000_001_001_001_000_000_000_000_000_001_000_001_001_001_001_001;
		FileiraMapa[8] <= 60'b001_000_000_000_000_000_000_001_000_000_000_000_000_001_000_000_000_001_000_000;
		FileiraMapa[9] <= 60'b111_000_000_000_000_001_001_001_001_001_001_001_000_001_001_001_001_001_000_000;
	end

	else begin

			LinhaLixo1 <= temp_LinhaLixo1;
			LinhaLixo2 <= temp_LinhaLixo2;
			LinhaLixo3 <= temp_LinhaLixo3;

			ColunaLixo1 <= temp_ColunaLixo1;
			ColunaLixo2 <= temp_ColunaLixo2;
			ColunaLixo3 <= temp_ColunaLixo3;

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
					barrier_counter <= barrier_counter + 4'b01;

					// Realiza o processo de remoção baseado no tipo de barreira
					case (current_barrier)
							LIXO3: 
									if (barrier_counter == 4'h8) begin // 9 clock cycles
											LinhaLixo3 <= 4'b1111; // Fora do mapa
											barrier_counter <= 4'h0; // Reseta o contador
									end
							LIXO2: 
									if (barrier_counter == 4'h5) begin // 6 clock cycles
											LinhaLixo2 <= 4'b1111; // Fora do mapa
											barrier_counter <= 4'h0; // Reseta o contador
									end
							LIXO1: 
									if (barrier_counter == 4'h2) begin
											LinhaLixo1 <= 4'b1111; // Fora do mapa
											barrier_counter <= 4'h0; // Reseta o contador
									end
					endcase
			end
	end
end

always @(posedge Clock50) begin
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
			// Entrada2[1] = Saida_Dow2
			// Entrad3s[0] = Saida_Up3
			// Entradas[2] = Saida_Left
			// Entrada2[1] = Saida_Dow2
			// Entrad3s[0] = Saida_Up3

			if(Entradas[11]) begin
				flag_mode <= !flag_mode;
			end
			
			if (Entradas[9]) begin
				temp_ColunaLixo3 <= ColunaCursor;
				temp_LinhaLixo3 <= LinhaCursor;
			end

			if (Entradas[8]) begin
				temp_ColunaLixo2 <= ColunaCursor;
				temp_LinhaLixo2 <= LinhaCursor;
			end
			
			if (Entradas[7]) begin
				temp_ColunaLixo1 <= ColunaCursor;
				temp_LinhaLixo1 <= LinhaCursor;
			end

			if (Entradas[5]) begin
				ColunaCelulaPreta <= ColunaCursor;
				LinhaCelulaPreta <= LinhaCursor;
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
				if (ColunaCursor == 19)
					ColunaCursor <= 0;
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

		// Lógica do under_out
		if (LinhaCelulaPreta == LinhaRobo && ColunaCelulaPreta == ColunaRobo)
				under_out = 1;
		else
				under_out = 0;

    case (OrientacaoRobo)
        NORTH: begin

						if (LinhaLixo1 == LinhaRobo - 1 && ColunaLixo1 == ColunaRobo) current_barrier = LIXO1;
						else if (LinhaLixo2 == LinhaRobo - 1 && ColunaLixo2 == ColunaRobo) current_barrier = LIXO2;
						else if (LinhaLixo3 == LinhaRobo - 1 && ColunaLixo3 == ColunaRobo) current_barrier = LIXO3;
						else current_barrier = NULL;

            // Lógica do head_out
            if (LinhaRobo == 0 || get_map_value(LinhaRobo - 4'h1, ColunaRobo) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (ColunaRobo == 0 || get_map_value(LinhaRobo,ColunaRobo - 5'h1) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica para setar o barrier_out
            if (LinhaRobo != 0 && current_barrier != NULL) 
								barrier_out = 1;
						else 
								barrier_out = 0;
        end
        WEST: begin

						if (LinhaLixo1 == LinhaRobo && ColunaLixo1 == ColunaRobo - 1) current_barrier = LIXO1;
						else if (LinhaLixo2 == LinhaRobo && ColunaLixo2 == ColunaRobo - 1) current_barrier = LIXO2;
						else if (LinhaLixo3 == LinhaRobo && ColunaLixo3 == ColunaRobo - 1) current_barrier = LIXO3;
						else current_barrier = NULL;

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

            // Lógica para setar o barrier_out
            if (ColunaRobo != 0 && current_barrier != NULL)
        				barrier_out = 1;
						else 
								barrier_out = 0;
        end
        SOUTH: begin

						if (LinhaLixo1 == LinhaRobo + 1 && ColunaLixo1 == ColunaRobo) current_barrier = LIXO1;
						else if (LinhaLixo2 == LinhaRobo + 1 && ColunaLixo2 == ColunaRobo) current_barrier = LIXO2;
						else if (LinhaLixo3 == LinhaRobo + 1 && ColunaLixo3 == ColunaRobo) current_barrier = LIXO3;
						else current_barrier = NULL;

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

            // Lógica para setar o barrier_out
            if (LinhaRobo != 9 && current_barrier != NULL)
        				barrier_out = 1;
						else 
								barrier_out = 0;
        end
        EAST: begin

						if (LinhaLixo1 == LinhaRobo && ColunaLixo1 == ColunaRobo + 1) current_barrier = LIXO1;
						else if (LinhaLixo2 == LinhaRobo && ColunaLixo2 == ColunaRobo + 1) current_barrier = LIXO2;
						else if (LinhaLixo3 == LinhaRobo && ColunaLixo3 == ColunaRobo + 1) current_barrier = LIXO3;
						else current_barrier = NULL;

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

            // Lógica para setar o barrier_out
            if (ColunaRobo != 19 && current_barrier != NULL)
        				barrier_out = 1;
						else 
								barrier_out = 0;
        end
        default: begin
            head_out = 0;
            left_out = 0;
						current_barrier = NULL;
        end
    endcase
end

// Os leds representam a linha e coluna do robô
always @(LinhaRobo, ColunaRobo) begin
	LEDG <= {LinhaRobo, ColunaRobo};
end
endmodule 