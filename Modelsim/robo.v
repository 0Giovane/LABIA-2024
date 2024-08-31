module Robo (
    input wire clock,
    input wire reset,
    input wire head,
    input wire left,
    input wire under,
    input wire barrier,
    output reg avancar,
    output reg girar,
    output reg remover
);
    parameter WIDTH = 3,
              Procurando_Muro = 0,
              Rotacionando = 1,
              Acompanhando_Muro = 2,
              Iniciando = 3,
              Removendo = 4,
              Standby = 5;

    reg [WIDTH-1:0] Estado_Atual, Proximo_Estado;

    // Sequential logic for state transitions
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            Estado_Atual <= Iniciando;
        end else begin
            Estado_Atual <= Proximo_Estado;
        end
    end

    // Combinational logic for state transitions
    always @(*) begin
        case (Estado_Atual)
            Procurando_Muro: begin
                casez ({head, left, under, barrier})
                    4'b0100: Proximo_Estado = Acompanhando_Muro;
                    4'b??1?: Proximo_Estado = Standby;
                    4'b??01: Proximo_Estado = Removendo;
                    4'b1?00: Proximo_Estado = Rotacionando;
                    default: Proximo_Estado = Procurando_Muro;
                endcase
            end
            Rotacionando: begin
                casez ({head, left, under, barrier})
                    4'b0100: Proximo_Estado = Acompanhando_Muro;
                    4'b??1?: Proximo_Estado = Standby;
                    4'b??01: Proximo_Estado = Removendo;
                    default: Proximo_Estado = Rotacionando;
                endcase
            end
            Acompanhando_Muro: begin
                casez ({head, left, under, barrier})
                    4'b1000, 4'b0000: Proximo_Estado = Procurando_Muro;
                    4'b1100: Proximo_Estado = Rotacionando;
                    4'b??1?: Proximo_Estado = Standby;
                    4'b??01: Proximo_Estado = Removendo;
                    default: Proximo_Estado = Acompanhando_Muro;
                endcase
            end
            Iniciando: begin
                casez ({head, left, under, barrier})
                    4'b??10: Proximo_Estado = Iniciando;
                    4'b0100: Proximo_Estado = Acompanhando_Muro;
                    4'b0000, 4'b1000: Proximo_Estado = Procurando_Muro;
                    4'b1100: Proximo_Estado = Rotacionando;
                    4'b???1: Proximo_Estado = Removendo;
                    default: Proximo_Estado = Iniciando;
                endcase
            end
            Standby: begin
                Proximo_Estado = Standby;
            end
            Removendo: begin
                casez ({head, left, under, barrier})
                    4'b0??1: Proximo_Estado = Removendo;
                    4'b?1?0: Proximo_Estado = Acompanhando_Muro;
                    4'b?0?0: Proximo_Estado = Procurando_Muro;
                    default: Proximo_Estado = Standby;
                endcase
            end
            default: Proximo_Estado = Standby; // Default case for safety
        endcase
    end

    // Combinational logic for outputs
    always @(*) begin
        case (Estado_Atual)
            Procurando_Muro: begin
                casez ({head, left, under, barrier})
                    4'b0?00: begin
                        avancar = 1'b1;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                    4'b??1?: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                    4'b0?01: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b1;
                    end
                    4'b1?00: begin
                        avancar = 1'b0;
                        girar = 1'b1;
                        remover = 1'b0;
                    end
                    default: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                endcase
            end
            Rotacionando: begin
                casez ({head, left, under, barrier})
                    4'b0100: begin
                        avancar = 1'b1;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                    4'b??1?: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                    4'b0?01: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b1;
                    end
                    default: begin
                        avancar = 1'b0;
                        girar = 1'b1;
                        remover = 1'b0;
                    end
                endcase
            end
            Acompanhando_Muro: begin
                casez ({head, left, under, barrier})
                    4'b1000, 4'b0000, 4'b1100: begin
                        avancar = 1'b0;
                        girar = 1'b1;
                        remover = 1'b0;
                    end
                    4'b??1?: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                    4'b0?01: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b1;
                    end
                    default: begin
                        avancar = 1'b1;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                endcase
            end
            Iniciando: begin
                casez ({head, left, under, barrier})
                    4'b10?0, 4'b11?0: begin
                        avancar = 1'b0;
                        girar = 1'b1;
                        remover = 1'b0;
                    end
                    4'b0??0: begin
                        avancar = 1'b1;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                    4'b0??1: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b1;
                    end
                    default: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                endcase
            end
            Removendo: begin
                casez ({head, left, under, barrier})
                    4'b0??1: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b1;
                    end
                    4'b0??0: begin
                        avancar = 1'b1;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                    default: begin
                        avancar = 1'b0;
                        girar = 1'b0;
                        remover = 1'b0;
                    end
                endcase
            end
            default: begin
                avancar = 1'b0;
                girar = 1'b0;
                remover = 1'b0;
            end
        endcase
    end
endmodule
