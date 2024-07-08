module robo

#(
    parameter integer WIDTH = 2,
                      INICIO = 0,
                      PROCURAR = 1,
                      ROTACIONAR = 2,
                      SEGUIR = 3,
                      V = 1'b1,
                      F = 1'b0,
                      caso_0 = 0,
                      caso_1 = 1,
                      caso_2 = 2,
                      caso_3 = 3,
                      caso_4 = 4,
                      caso_5 = 5,
                      caso_6 = 6,
                      caso_7 = 7,
                      caso_8 = 8,
                      caso_9 = 10,                      
                      caso_10 = 12,                      
                      caso_11 = 14                                                         
)

(
    output reg Front,
    output reg Turn,
    output reg Remove,
    input wire clock,
    input wire reset,
    input wire H,
    input wire L,
    input wire U,
    input wire B
);

reg [WIDTH-1:0] estado;

always @(posedge clock)
begin
    case (estado) 
        INICIO:
            case ({H,L,U,B})
                caso_0:
                    Front <=0;
                caso_1:
            endcase

    endcase
        
   
end



endmodule
