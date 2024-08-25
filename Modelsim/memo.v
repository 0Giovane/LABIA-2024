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

reg [59:0] fileira_mapa [0:9]; // Matriz 10x20 x 3 bits
reg [3:0] robo_row;    // Coluna da posição do robô (4 bits para 0-9)
reg [4:0] robo_col;    // Coluna da posição do robô (5 bits para 0-19)
reg [1:0] robo_orientacao;  // Orientação do robô

reg [1:0] barrier_counter; // Contador de clock para BARRIER

reg flag_start; // Flag para ativação do START no gamepad
reg flag_mode; // Flag para ativação do MODE no gamepad

wire selected_clock; // Assume "manual_clock" ou "clock" dependendo da "flag_mode"

integer row, col;
reg [2:0] current_barrier;

// Lógica para FLAG start
always @(posedge gamepad_input[10] or posedge reset) begin
    if (reset) flag_start <= 0;
    else flag_start <= !flag_start;  // Varia a Flag 
end

// Lógica para FLAG mode
always @(posedge gamepad_input[11] or posedge reset) begin
    if (reset) flag_mode <= 0;
    else flag_mode <= !flag_mode;  // Varia a Flag 
end

// Lógica para selecionar o clock com base no flag_mode
assign selected_clock = (flag_mode) ? manual_clock : clock;
assign clock_out = selected_clock; // Saída de clock para o robô

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

// Lógica da orientação	e movimentação
always @(posedge selected_clock or posedge reset) begin 

    if (reset) begin
        // Reset the robot's position and orientation
        robo_row <= 4'b1001;
        robo_col <= 5'b00000;
        robo_orientacao <= NORTH;
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
    else if (flag_start) begin // Modo de edição
        // TODO: Add mode of edition logic here.
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
                    NORTH: begin
                        row = robo_row - 4'b0001;
                        col = robo_col;
                    end
                    WEST: begin
                        row = robo_row;
                        col = robo_col - 4'b0001;
                    end
                    SOUTH: begin
                        row = robo_row + 4'b0001;
                        col = robo_col;
                    end
                    EAST: begin
                        row = robo_row;
                        col = robo_col + 4'b0001;
                    end
                endcase

                current_barrier = get_map_value(row, col);

                // Realiza o downgrade da barreira
                case (current_barrier)
                    BARRIER9: 
                        set_column_bits(row, col, BARRIER6);
                    BARRIER6: 
                        set_column_bits(row, col, BARRIER3);
                    BARRIER3: 
                    begin
                        set_column_bits(row, col, PATH);
                        barrier_out <= 0;
                    end
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
            // Lógica do head_out
            if (robo_row == 0 || get_map_value(robo_row - 4'b0001, robo_col) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (robo_col == 0 || get_map_value(robo_row,robo_col - 4'b0001) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(robo_row,robo_col) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (robo_row != 0 && 
                (get_map_value(robo_row - 4'b0001,robo_col) == BARRIER3 || 
                get_map_value(robo_row - 4'b0001,robo_col) == BARRIER6 || 
                get_map_value(robo_row - 4'b0001,robo_col) == BARRIER9)) begin
                barrier_out = 1;
	            end
        end
        WEST: begin
            // Lógica do head_out
            if (robo_col == 0 || get_map_value(robo_row,robo_col - 4'b0001) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (robo_row == 9 || get_map_value(robo_row + 4'b0001,robo_col) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(robo_row,robo_col) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (robo_col != 0 && 
                (get_map_value(robo_row,robo_col - 4'b0001) == BARRIER3 || 
                get_map_value(robo_row,robo_col - 4'b0001) == BARRIER6 || 
                get_map_value(robo_row,robo_col - 4'b0001) == BARRIER9)) begin
                barrier_out = 1;
            end
        end
        SOUTH: begin
            // Lógica do head_out
            if (robo_row == 9 || get_map_value(robo_row + 4'b0001,robo_col) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (robo_col == 19 || get_map_value(robo_row,robo_col + 4'b0001) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(robo_row,robo_col) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (robo_row != 9 && 
                (get_map_value(robo_row + 4'b0001,robo_col) == BARRIER3 || 
                get_map_value(robo_row + 4'b0001,robo_col) == BARRIER6 || 
                get_map_value(robo_row + 4'b0001,robo_col) == BARRIER9)) begin
                barrier_out = 1;
            end
        end
        EAST: begin
            // Lógica do head_out
            if (robo_col == 19 || get_map_value(robo_row,robo_col + 4'b0001) == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // Lógica do left_out
            if (robo_row == 0 || get_map_value(robo_row - 4'b0001,robo_col) == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // Lógica do under_out
            if (get_map_value(robo_row,robo_col) == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // Lógica para setar o barrier_out
            if (robo_col != 19 && 
                (get_map_value(robo_row,robo_col + 4'b0001) == BARRIER3 || 
                get_map_value(robo_row,robo_col + 4'b0001) == BARRIER6 || 
                get_map_value(robo_row,robo_col + 4'b0001) == BARRIER9)) begin
                barrier_out = 1;
            end
        end
        default: begin
            head_out = 0;
            left_out = 0;
        end
    endcase
end
endmodule




