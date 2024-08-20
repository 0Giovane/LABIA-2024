module Memo (
    input clock, 
    input reset,
    input avancar,
    input girar,
    input remover,
    output reg head_out,
    output reg left_out,
    output reg under_out,
    output reg barrier_out
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
reg [2:0] map [0:9][0:19];  // 0-based indexing para 10x20
reg [3:0] robo_row;    // Coluna da posi��o do rob� (4 bits para 0-9)
reg [4:0] robo_col;    // Coluna da posi��o do rob� (5 bits para 0-19)
reg [1:0] robo_orientacao;  // Orienta��o do rob�

reg [1:0] barrier_counter; // Contador de clock para BARRIER

initial begin
    // Inicializa o mapa na matriz
    $readmemh("map.hex", map); // L? dados bin?rios de um arquivo

    robo_row = 4'b1001; // Posi��o de linha inicial (9)
    robo_col = 5'b00000; // Posi��o de coluna inicial (0)
    robo_orientacao = NORTH; // Orienta��o inicial (North)
    barrier_counter = 4'b0000; // Contador de BARRIER zerado
end

// L?gica da orienta??o	e movimenta??o
always @(posedge clock or posedge reset) begin 
    if (reset) begin
        // Reset the robot's position and orientation
        robo_row <= 4'b1001;
        robo_col <= 5'b00000;
        robo_orientacao <= NORTH;
        barrier_counter <= 4'b0000;
    end 
    else begin
        // L�gica para girar
        if (girar) begin
            if (robo_orientacao == EAST) // Retorna para o NORTH
                robo_orientacao <= NORTH; 
            else
                robo_orientacao <= robo_orientacao + 2'b01; // Rotaciona no sentido anti-hor?rio
        end
        // L�gica para avan�ar
        else if (avancar) begin
            case (robo_orientacao)
                NORTH:
                    robo_row <= robo_row - 1;
                WEST:
                    robo_col <= robo_col - 1;
                SOUTH:
                    robo_row <= robo_row + 1;
                EAST:
                    robo_col <= robo_col + 1;
            endcase
        end
        // L�gica para remover
        else if (remover) begin
            barrier_counter <= barrier_counter + 1;

            if (barrier_counter == 2'b10) begin // Conta at� 2
                case (robo_orientacao)
                    NORTH:
                        case(map[robo_row - 1][robo_col])
                            BARRIER9: 
                                map[robo_row - 1][robo_col] <= BARRIER6;
                            BARRIER6: 
                                map[robo_row - 1][robo_col] <= BARRIER3;
                            BARRIER3: 
                                map[robo_row - 1][robo_col] <= PATH;
                        endcase
                    WEST:
                        case(map[robo_row][robo_col - 1])
                            BARRIER9: 
                                map[robo_row][robo_col - 1] <= BARRIER6;
                            BARRIER6: 
                                map[robo_row][robo_col - 1] <= BARRIER3;
                            BARRIER3: 
                                map[robo_row][robo_col - 1] <= PATH;
                        endcase
                    SOUTH:
                        case(map[robo_row + 1][robo_col])
                            BARRIER9: 
                                map[robo_row + 1][robo_col] <= BARRIER6;
                            BARRIER6: 
                                map[robo_row + 1][robo_col] <= BARRIER3;
                            BARRIER3: 
                                map[robo_row + 1][robo_col] <= PATH;
                        endcase
                    EAST:
                        case(map[robo_row][robo_col + 1])
                            BARRIER9: 
                                map[robo_row][robo_col + 1] <= BARRIER6;
                            BARRIER6: 
                                map[robo_row][robo_col + 1] <= BARRIER3;
                            BARRIER3: 
                                map[robo_row][robo_col + 1] <= PATH;
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
            if (robo_row == 0 || map[robo_row - 1][robo_col] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_col == 0 || map[robo_row][robo_col - 1] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[robo_row][robo_col] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_row != 0 && 
                (map[robo_row - 1][robo_col] == BARRIER3 || 
                map[robo_row - 1][robo_col] == BARRIER6 || 
                map[robo_row - 1][robo_col] == BARRIER9)) begin
                barrier_out = 1;
	    end
            else
                barrier_out = 0;
        end
        WEST: begin
            // L?gica do head_out
            if (robo_col == 0 || map[robo_row][robo_col - 1] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_row == 9 || map[robo_row + 1][robo_col] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[robo_row][robo_col] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_col != 0 && 
                (map[robo_row][robo_col - 1] == BARRIER3 || 
                map[robo_row][robo_col - 1] == BARRIER6 || 
                map[robo_row][robo_col - 1] == BARRIER9)) begin
                barrier_out = 1;
	    end
            else
                barrier_out = 0;
        end
        SOUTH: begin
            // L?gica do head_out
            if (robo_row == 9 || map[robo_row + 1][robo_col] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_col == 19 || map[robo_row][robo_col + 1] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[robo_row][robo_col] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_row != 9 && 
                (map[robo_row + 1][robo_col] == BARRIER3 || 
                map[robo_row + 1][robo_col] == BARRIER6 || 
                map[robo_row + 1][robo_col] == BARRIER9)) begin
                barrier_out = 1;
	    end
            else
                barrier_out = 0;
        end
        EAST: begin
            // L?gica do head_out
            if (robo_col == 19 || map[robo_row][robo_col + 1] == WALL) 
                head_out = 1;
            else 
                head_out = 0;

            // L?gica do left_out
            if (robo_row == 0 || map[robo_row - 1][robo_col] == WALL) 
                left_out = 1;
            else 
                left_out = 0;

            // L?gica do under_out
            if (map[robo_row][robo_col] == BLACK)
                under_out = 1;
            else
                under_out = 0;

            // L?gica do barrier_out
            if (robo_col != 19 && 
                (map[robo_row][robo_col + 1] == BARRIER3 || 
                map[robo_row][robo_col + 1] == BARRIER6 || 
                map[robo_row][robo_col + 1] == BARRIER9)) begin
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


