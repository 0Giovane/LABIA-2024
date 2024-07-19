module Robo

  (
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
  parameter WIDTH = 3, // Lista de parÃ¢metros para os estados
            Procurando_Muro = 0,
            Rotacionando = 1,
            Acompanhando_Muro = 2,
            Inicial = 3,
            Remocao = 4,
            Standby = 5;

  reg [WIDTH-1:0] Estado_Atual, Proximo_Estado;  // Registradores de estado


  always @(posedge clock, posedge reset)
  begin
    if (reset == 1'b1)
    begin
      Estado_Atual <= Inicial;
    end
    else
    begin
      Estado_Atual <= Proximo_Estado;
    end
  end

  always @(Estado_Atual,head,left,under,barrier)
  begin
    case(Estado_Atual)
      Procurando_Muro:
      begin
        casez({head,left,under,barrier})

          4'b0100:
          begin
            Proximo_Estado = Acompanhando_Muro;
          end
          4'b??1?:
          begin
            Proximo_Estado = Standby;
          end
          4'b??01:
          begin
            Proximo_Estado = Remocao;
          end
          default:
          begin
            Proximo_Estado = Procurando_Muro;
          end
        endcase
      end
      Rotacionando:
      begin
        casez({head,left,under,barrier})
          4'b0100:
          begin
            Proximo_Estado = Acompanhando_Muro;
          end
          4'b??1?:
          begin
            Proximo_Estado = Standby;
          end
          4'b??01:
          begin
            Proximo_Estado = Remocao;
          end
          default:
          begin
            Proximo_Estado = Rotacionando;
          end
        endcase
      end
      Acompanhando_Muro:
      begin
        casez({head,left,under,barrier})
          4'b1000 , 4'b0000:
          begin
            Proximo_Estado = Procurando_Muro;
          end
          4'b1100:
          begin
            Proximo_Estado = Rotacionando;
          end
          4'b??1?:
          begin
            Proximo_Estado = Standby;
          end
          4'b??01:
          begin
            Proximo_Estado = Remocao;
          end
          default:
          begin
            Proximo_Estado = Acompanhando_Muro;
          end
        endcase
      end
      Inicial:
      begin
        casez({head,left,under,barrier})
          4'b1010 , 4'b1110:
          begin
            Proximo_Estado = Inicial;
          end
          4'b01?0:
          begin
            Proximo_Estado = Acompanhando_Muro;
          end
          4'b00?0:
          begin
            Proximo_Estado = Procurando_Muro;
          end
          4'b1100:
          begin
            Proximo_Estado = Rotacionando;
          end
          4'b1000:
          begin
            Proximo_Estado = Procurando_Muro;
          end
          4'b0??1:
          begin
            Proximo_Estado = Remocao;
          end
        endcase
      end
      Standby:
      begin
        Proximo_Estado = Standby;
      end
      Remocao:
      begin
        casez ({head,left,under,barrier})
          4'b???1:
            Proximo_Estado = Remocao ;
          4'b?1?0:
            Proximo_Estado = Acompanhando_Muro ;
          4'b?0?0:
            Proximo_Estado = Procurando_Muro ;
        endcase
      end
    endcase

    case(Estado_Atual)

      Procurando_Muro:
      begin
        casez({head,left,under,barrier})
          4'b0100:
          begin
            avancar = 1'b1;
            girar = 1'b0;
            remover = 1'b0;
          end
          4'b??1?:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b0;
          end
          4'b0000:
          begin
            avancar = 1'b1;
            girar = 1'b0;
            remover = 1'b0;
          end
          4'b??01:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b1;
          end
        endcase
      end
      Rotacionando:
      begin
        casez({head,left,under,barrier})
          4'b0100:
          begin
            avancar = 1'b1;
            girar = 1'b0;
            remover = 1'b0;
          end
          4'b??1?:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b0;
          end
          4'b??01:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b1;
          end
          default:
          begin
            avancar = 1'b0;
            girar = 1'b1;
            remover = 1'b0;
          end
        endcase
      end
      Acompanhando_Muro:
      begin
        casez({head,left,under,barrier})
          4'b1000 , 4'b0000 , 4'b1100:
          begin
            avancar = 1'b0;
            girar = 1'b1;
            remover = 1'b0;
          end
          4'b??1?:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b0;
          end
          4'b??01:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b1;
          end
          default:
          begin
            avancar = 1'b1;
            girar = 1'b0;
            remover = 1'b0;
          end
        endcase
      end
      Inicial:
      begin
        casez({head,left,under,barrier})
          4'b10?0 , 4'b11?0:
          begin
            avancar = 1'b0;
            girar = 1'b1;
            remover = 1'b0;
          end
          4'b0??0:
          begin
            avancar = 1'b1;
            girar = 1'b0;
            remover = 1'b0;
          end
          4'b00?1 , 4'b01?1:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b1;
          end
        endcase
      end
      Remocao:
      begin
        casez ({head,left,under,barrier})
          4'b???1:
          begin
            avancar = 1'b0;
            girar = 1'b0;
            remover = 1'b1;
          end
          4'b?1?0 , 4'b?0?0:
          begin
            avancar = 1'b1;
            girar = 1'b0;
            remover = 1'b0;
          end
        endcase
      end
      default:
      begin
        avancar = 1'b0;
        girar = 1'b0;
        remover = 1'b0;
      end
    endcase
  end

endmodule
