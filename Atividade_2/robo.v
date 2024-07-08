module Robo

  #(
     parameter integer WIDTH = 2, // Lista de parâmetros para os estados
     Procurando_Muro = 0,
     Rotacionando = 1,
     Acompanhando_Muro = 2,
     Standby = 3
   )

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

  reg [WIDTH-1:0] Estado_Atual, Proximo_Estado;  // Registradores de estado



  initial
  begin
    Proximo_Estado = Procurando_Muro;
    Estado_Atual = Proximo_Estado;
  end

  always @(posedge clock, posedge reset)
  begin
    if (reset == 1'b1)
    begin
      Proximo_Estado <= Procurando_Muro;
    end
    else
    begin
      Estado_Atual <= Proximo_Estado;
      casez(Estado_Atual)
        Procurando_Muro:
        begin
          if ({head,left,under,barrier} == 4'b0100)
          begin
            Proximo_Estado <= Acompanhando_Muro;
          end
          else if ({head,left,under,barrier} == 4'b??1?)
          begin
            Proximo_Estado <= Standby;
          end
          else
          begin
            Proximo_Estado <= Procurando_Muro;
          end
        end
        Rotacionando:
        begin
          if ({head,left,under,barrier} == 4'b0100)
          begin
            Proximo_Estado <= Acompanhando_Muro;
          end
          else if ({head,left,under,barrier} == 4'b??1?)
          begin
            Proximo_Estado <= Standby;
          end
          else
          begin
            Proximo_Estado <= Rotacionando;
          end
        end
        Acompanhando_Muro:
        begin
          if ({head,left,under,barrier} == 4'b1000 || {head,left,under,barrier} == 4'b0000)
          begin
            Proximo_Estado <= Procurando_Muro;
          end
          else if ({head,left,under,barrier} == 4'b1100)
          begin
            Proximo_Estado <= Rotacionando;
          end
          else if ({head,left,under,barrier} == 4'b??1?)
          begin
            Proximo_Estado <= Standby;
          end
          else
          begin
            Proximo_Estado <= Acompanhando_Muro;
          end
        end
        Standby:
        begin
          Proximo_Estado <= Standby;
        end
        default:
        begin
          Proximo_Estado <= Procurando_Muro;
        end
      endcase
    end
  end

  always @(*)
  begin
    casez(Estado_Atual)
      Procurando_Muro:
      begin
        if ({head,left,under,barrier} == 4'b0100)
        begin
          avancar = 1'b1;
          girar = 1'b0;
          remover = 1'b0;
        end
        else if ({head,left,under,barrier} == 4'b??1?)
        begin
          avancar = 1'b0;
          girar = 1'b0;
          remover = 1'b0;
        end
        else if ({head,left,under,barrier} == 4'b0000)
        begin
          avancar = 1'b1;
          girar = 1'b0;
          remover = 1'b0;
        end
        else if ({head,left,under,barrier} == 4'b??01)
        begin
          avancar = 1'b0;
          girar = 1'b0;
          remover = 1'b1;
        end
      end
      Rotacionando:
      begin
        if ({head,left,under,barrier} == 4'b0100)
        begin
          avancar = 1'b1;
          girar = 1'b0;
          remover = 1'b0;
        end
        else if ({head,left,under,barrier} == 4'b??1?)
        begin
          avancar = 1'b0;
          girar = 1'b0;
          remover = 1'b0;
        end
        else if ({head,left,under,barrier} == 4'b??01)
        begin
          avancar = 1'b0;
          girar = 1'b0;
          remover = 1'b1;
        end
        else
        begin
          avancar = 1'b0;
          girar = 1'b1;
          remover = 1'b0;
        end
      end
      Acompanhando_Muro:
      begin
        if ({head,left,under,barrier} == 4'b1000 || {head,left,under,barrier} == 4'b0000 ||
            {head,left,under,barrier} == 4'b1100)
        begin
          avancar = 1'b0;
          girar = 1'b1;
          remover = 1'b0;
        end
        else if ({head,left,under,barrier} == 4'b??1?)
        begin
          avancar = 1'b0;
          girar = 1'b0;
          remover = 1'b0;
        end
        else if ({head,left,under,barrier} == 4'b??01)
        begin
          avancar = 1'b0;
          girar = 1'b0;
          remover = 1'b1;
        end
        else
        begin
          avancar = 1'b1;
          girar = 1'b0;
          remover = 1'b0;
        end
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
