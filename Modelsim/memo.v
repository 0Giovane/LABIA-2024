module Memo (
    input clock, 
    input reset,
    input avancar,
    input girar,
    input remover,
    input manual_clock,
    input [11:0] gamepad_input,  
    output reg head_out,
    output reg left_out,
    output reg under_out,
    output reg barrier_out,
    output wire clock_out // Clock para o robô
);

// Par?metros para as celulas
parameter WALL = 3'h0,
            PATH = 3'h1,
            BARRIER3 = 3'h2,
            BARRIER6 = 3'h3,
            BARRIER9 = 3'h4,
            BLACK = 3'h7;

// Par?metros para a orienta??o do rob?
parameter NORTH = 2'b00, 
          WEST = 2'b01, 
          SOUTH  = 2'b10, 
          EAST  = 2'b11;

// Matrix dimensions: 10x20
reg [3:0] map [0:199]; // Array de tamanho 200 (10x20)
reg [3:0] robo_row;    // Coluna da posi��o do rob� (4 bits para 0-9)
reg [4:0] robo_col;    // Coluna da posi��o do rob� (5 bits para 0-19)
reg [1:0] robo_orientacao;  // Orienta��o do rob�

reg [1:0] barrier_counter; // Contador de clock para BARRIER

reg flag_start; // Flag para ativação do START no gamepad
reg flag_mode; // Flag para ativação do MODE no gamepad

wire selected_clock; // Assume "manual_clock" ou "clock" dependendo da "flag_mode"

initial begin
    // Inicializa o mapa na matriz
    $readmemh("map.hex", map); // L? dados bin?rios de um arquivo

    robo_row = 4'b1001; // Posi��o de linha inicial (9)
    robo_col = 5'b00000; // Posi��o de coluna inicial (0)
    robo_orientacao = NORTH; // Orienta��o inicial (North)
    barrier_counter = 2'b00; // Contador de BARRIER zerado
    flag_start = 0;
    flag_mode = 0;
end

 // Função para converter valor de row e col no vetor unidimensional
 function [7:0] get_map_index;
	  input [3:0] row; // 4 bits para linhas (0-9)
	  input [4:0] col; // 5 bits para colunas (0-19)
	  reg [7:0] index;
 begin
	  index = row * 8'd20 + col; // Calcular o index no vetor unidimensional
	  get_map_index = index; 
 end
 endfunction

// Lógica para FLAG start
always @(posedge gamepad_input[10]) begin
    flag_start <= !flag_start;  // Varia a Flag 
end

// Lógica para FLAG mode
always @(posedge gamepad_input[11] or posedge reset) begin
    if (reset) flag_mode <= 0;
    else flag_mode <= !flag_mode;  // Varia a Flag 
end

// Logic to select the appropriate clock based on flag_mode
assign selected_clock = (flag_mode) ? manual_clock : clock;
assign clock_out = selected_clock; // Saída de clock para o robô

// Lógica da orientação	e movimentação
always @(posedge selected_clock or posedge reset) begin 
    if (reset) begin
        // Reset the robot's position and orientation
        robo_row <= 4'b1001;
        robo_col <= 5'b00000;
        robo_orientacao <= NORTH;
        barrier_counter <= 2'b00;
        flag_start = 0;
    end 
    else if (flag_start) begin // Modo de edição
        //
    end
    else begin
        // Lógica para girar
        if (girar) begin
            if (robo_orientacao == EAST) // Retorna para o NORTH
                robo_orientacao <= NORTH; 
            else
                robo_orientacao <= robo_orientacao + 2'b01; // Rotaciona no sentido anti-hor?rio
        end
        // Lógica para avançar
        else if (avancar) begin
            case (robo_orientacao)
                NORTH:
                    robo_row <= robo_row - 4'b0001;
                WEST:
                    robo_col <= robo_col - 4'b0001;
                SOUTH:
                    robo_row <= robo_row + 4'b0001;
                EAST:
                    robo_col <= robo_col + 4'b0001;
            endcase
        end
        // Lógica para remover
        else if (remover) begin
            barrier_counter <= barrier_counter + 2'b01;

            if (barrier_counter == 2'b10) begin // Conta até 2
                case (robo_orientacao)
                    NORTH:
                        case(map[get_map_index(robo_row - 4'b0001,robo_col)])
                            BARRIER9: 
                                map[get_map_index(robo_row - 4'b0001,robo_col)] <= BARRIER6;
                            BARRIER6: 
                                map[get_map_index(robo_row - 4'b0001,robo_col)] <= BARRIER3;
                            BARRIER3: 
                                map[get_map_index(robo_row - 4'b0001,robo_col)] <= PATH;
                        endcase
                    WEST:
                        case(map[get_map_index(robo_row,robo_col - 4'b0001)])
                            BARRIER9: 
                                map[get_map_index(robo_row,robo_col - 4'b0001)] <= BARRIER6;
                            BARRIER6: 
                                map[get_map_index(robo_row,robo_col - 4'b0001)] <= BARRIER3;
                            BARRIER3: 
                                map[get_map_index(robo_row,robo_col - 4'b0001)] <= PATH;
                        endcase
                    SOUTH:
                        case(map[get_map_index(robo_row + 4'b0001,robo_col)])
                            BARRIER9: 
                                map[get_map_index(robo_row + 4'b0001,robo_col)] <= BARRIER6;
                            BARRIER6: 
                                map[get_map_index(robo_row + 4'b0001,robo_col)] <= BARRIER3;
                            BARRIER3: 
                                map[get_map_index(robo_row + 4'b0001,robo_col)] <= PATH;
                        endcase
                    EAST:
                        case(map[get_map_index(robo_row,robo_col + 1)])
                            BARRIER9: 
                                map[get_map_index(robo_row,robo_col + 4'b0001)] <= BARRIER6;
                            BARRIER6: 
                                map[get_map_index(robo_row,robo_col + 4'b0001)] <= BARRIER3;
                            BARRIER3: 
                                map[get_map_index(robo_row,robo_col + 4'b0001)] <= PATH;
                        endcase
                endcase
                barrier_counter <= 2'b00; // Reseta o contador
            end
        end
    end
end

// Logica combinacional das saidas
always @(*) begin
    case (robo_orientacao)
        NORTH: begin
            // L?gica do head_out
            if (robo_row == 0 || map[get_map_index(robo_row - 4'b0001,robo_col)] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_col == 0 || map[get_map_index(robo_row,robo_col - 4'b0001)] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[get_map_index(robo_row,robo_col)] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_row != 0 && 
                (map[get_map_index(robo_row - 4'b0001,robo_col)] == BARRIER3 || 
                map[get_map_index(robo_row - 4'b0001,robo_col)] == BARRIER6 || 
                map[get_map_index(robo_row - 4'b0001,robo_col)] == BARRIER9)) begin
                barrier_out = 1;
	    end
            else
                barrier_out = 0;
        end
        WEST: begin
            // L?gica do head_out
            if (robo_col == 0 || map[get_map_index(robo_row,robo_col - 4'b0001)] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_row == 9 || map[get_map_index(robo_row + 4'b0001,robo_col)] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[get_map_index(robo_row,robo_col)] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_col != 0 && 
                (map[get_map_index(robo_row,robo_col - 4'b0001)] == BARRIER3 || 
                map[get_map_index(robo_row,robo_col - 4'b0001)] == BARRIER6 || 
                map[get_map_index(robo_row,robo_col - 4'b0001)] == BARRIER9)) begin
                barrier_out = 1;
	    end
            else
                barrier_out = 0;
        end
        SOUTH: begin
            // L?gica do head_out
            if (robo_row == 9 || map[get_map_index(robo_row + 1,robo_col)] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_col == 19 || map[get_map_index(robo_row,robo_col + 1)] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[get_map_index(robo_row,robo_col)] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_row != 9 && 
                (map[get_map_index(robo_row + 1,robo_col)] == BARRIER3 || 
                map[get_map_index(robo_row + 1,robo_col)] == BARRIER6 || 
                map[get_map_index(robo_row + 1,robo_col)] == BARRIER9)) begin
                barrier_out = 1;
	    end
            else
                barrier_out = 0;
        end
        EAST: begin
            // L?gica do head_out
            if (robo_col == 19 || map[get_map_index(robo_row,robo_col + 1)] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_row == 0 || map[get_map_index(robo_row - 1,robo_col)] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[get_map_index(robo_row,robo_col)] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_col != 19 && 
                (map[get_map_index(robo_row,robo_col + 1)] == BARRIER3 || 
                map[get_map_index(robo_row,robo_col + 1)] == BARRIER6 || 
                map[get_map_index(robo_row,robo_col + 1)] == BARRIER9)) begin
                barrier_out = 1;
	    end
            else
                barrier_out = 0;
        end
        default: begin
            head_out = 0;
            left_out = 0;
        end
    endcase
end

endmodule




