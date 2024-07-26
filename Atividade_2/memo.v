module memo
  (
    inout wire [2:1] data, // Valor da célula para escrita e leitura
    input wire [7:0] endereco,
    input wire w,
    input wire r
  );

  reg [1:40] data_endereco [1:10];

  assign data = r ? ((endereco == 0) ? data_endereco[1][1:2]:
                     (endereco == 1 )? data_endereco[1][3:4]:
                     (endereco == 2 )? data_endereco[1][5:6]:
                     (endereco == 3 )? data_endereco[1][7:8]:
                     (endereco == 4 )? data_endereco[1][9:10]:
                     (endereco == 5 )? data_endereco[1][11:12]:
                     (endereco == 6 )? data_endereco[1][13:14]:
                     (endereco == 7 )? data_endereco[1][15:16]:
                     (endereco == 8 )? data_endereco[1][17:18]:
                     (endereco == 9 )? data_endereco[1][19:20]:
                     (endereco == 10 )? data_endereco[1][21:22]:
                     (endereco == 11 )? data_endereco[1][23:24]:
                     (endereco == 12 )? data_endereco[1][25:26]:
                     (endereco == 13 )? data_endereco[1][27:28]:
                     (endereco == 14 )? data_endereco[1][29:30]:
                     (endereco == 15 )? data_endereco[1][31:32]:
                     (endereco == 16 )? data_endereco[1][33:34]:
                     (endereco == 17 )? data_endereco[1][35:36]:
                     (endereco == 18 )? data_endereco[1][37:38]:
                     (endereco == 19 )? data_endereco[1][39:40]:
                     (endereco == 20) ? data_endereco[1][1:2]:
                     (endereco == 21 )? data_endereco[2][3:4]:
                     (endereco == 22 )? data_endereco[2][5:6]:
                     (endereco == 23 )? data_endereco[2][7:8]:
                     (endereco == 24 )? data_endereco[2][9:10]:
                     (endereco == 25 )? data_endereco[2][11:12]:
                     (endereco == 26 )? data_endereco[2][13:14]:
                     (endereco == 27 )? data_endereco[2][15:16]:
                     (endereco == 28 )? data_endereco[2][17:18]:
                     (endereco == 29 )? data_endereco[2][19:20]:
                     (endereco == 30 )? data_endereco[2][21:22]:
                     (endereco == 31 )? data_endereco[2][23:24]:
                     (endereco == 32 )? data_endereco[2][25:26]:
                     (endereco == 33 )? data_endereco[2][27:28]:
                     (endereco == 34 )? data_endereco[2][29:30]:
                     (endereco == 35 )? data_endereco[2][31:32]:
                     (endereco == 36 )? data_endereco[2][33:34]:
                     (endereco == 37 )? data_endereco[2][35:36]:
                     (endereco == 38 )? data_endereco[2][37:38]:
                     (endereco == 39 )? data_endereco[2][39:40]:
                     (endereco == 40) ? data_endereco[3][1:2]:
                     (endereco == 41 )? data_endereco[3][3:4]:
                     (endereco == 42 )? data_endereco[3][5:6]:
                     (endereco == 43 )? data_endereco[3][7:8]:
                     (endereco == 44 )? data_endereco[3][9:10]:
                     (endereco == 45 )? data_endereco[3][11:12]:
                     (endereco == 46 )? data_endereco[3][13:14]:
                     (endereco == 47 )? data_endereco[3][15:16]:
                     (endereco == 48 )? data_endereco[3][17:18]:
                     (endereco == 49 )? data_endereco[3][19:20]:
                     (endereco == 50 )? data_endereco[3][21:22]:
                     (endereco == 51 )? data_endereco[3][23:24]:
                     (endereco == 52 )? data_endereco[3][25:26]:
                     (endereco == 53 )? data_endereco[3][27:28]:
                     (endereco == 54 )? data_endereco[3][29:30]:
                     (endereco == 55 )? data_endereco[3][31:32]:
                     (endereco == 56 )? data_endereco[3][33:34]:
                     (endereco == 57 )? data_endereco[3][35:36]:
                     (endereco == 58 )? data_endereco[3][37:38]:
                     (endereco == 59 )? data_endereco[3][39:40]:
                     (endereco == 60) ? data_endereco[4][1:2]:
                     (endereco == 61 )? data_endereco[4][3:4]:
                     (endereco == 62 )? data_endereco[4][5:6]:
                     (endereco == 63 )? data_endereco[4][7:8]:
                     (endereco == 64 )? data_endereco[4][9:10]:
                     (endereco == 65 )? data_endereco[4][11:12]:
                     (endereco == 66 )? data_endereco[4][13:14]:
                     (endereco == 67 )? data_endereco[4][15:16]:
                     (endereco == 68 )? data_endereco[4][17:18]:
                     (endereco == 69 )? data_endereco[4][19:20]:
                     (endereco == 70 )? data_endereco[4][21:22]:
                     (endereco == 71 )? data_endereco[4][23:24]:
                     (endereco == 72 )? data_endereco[4][25:26]:
                     (endereco == 73 )? data_endereco[4][27:28]:
                     (endereco == 74 )? data_endereco[4][29:30]:
                     (endereco == 75 )? data_endereco[4][31:32]:
                     (endereco == 76 )? data_endereco[4][33:34]:
                     (endereco == 77 )? data_endereco[4][35:36]:
                     (endereco == 78 )? data_endereco[4][37:38]:
                     (endereco == 79 )? data_endereco[4][39:40]:
                     (endereco == 80) ? data_endereco[5][1:2]:
                     (endereco == 81)? data_endereco[5][3:4]:
                     (endereco == 82 )? data_endereco[5][5:6]:
                     (endereco == 83 )? data_endereco[5][7:8]:
                     (endereco == 84 )? data_endereco[5][9:10]:
                     (endereco == 85 )? data_endereco[5][11:12]:
                     (endereco == 86 )? data_endereco[5][13:14]:
                     (endereco == 87 )? data_endereco[5][15:16]:
                     (endereco == 88 )? data_endereco[5][17:18]:
                     (endereco == 89 )? data_endereco[5][19:20]:
                     (endereco == 90 )? data_endereco[5][21:22]:
                     (endereco == 91 )? data_endereco[5][23:24]:
                     (endereco == 92 )? data_endereco[5][25:26]:
                     (endereco == 93 )? data_endereco[5][27:28]:
                     (endereco == 94 )? data_endereco[5][29:30]:
                     (endereco == 95 )? data_endereco[5][31:32]:
                     (endereco == 96 )? data_endereco[5][33:34]:
                     (endereco == 97 )? data_endereco[5][35:36]:
                     (endereco == 98 )? data_endereco[5][37:38]:
                     (endereco == 99 )? data_endereco[5][39:40]:
                     (endereco == 100) ? data_endereco[6][1:2]:
                     (endereco == 101 )? data_endereco[6][3:4]:
                     (endereco == 102)? data_endereco[6][5:6]:
                     (endereco == 103 )? data_endereco[6][7:8]:
                     (endereco == 104 )? data_endereco[6][9:10]:
                     (endereco == 105 )? data_endereco[6][11:12]:
                     (endereco == 106 )? data_endereco[6][13:14]:
                     (endereco == 107 )? data_endereco[6][15:16]:
                     (endereco == 108 )? data_endereco[6][17:18]:
                     (endereco == 109 )? data_endereco[6][19:20]:
                     (endereco == 110 )? data_endereco[6][21:22]:
                     (endereco == 111 )? data_endereco[6][23:24]:
                     (endereco == 112 )? data_endereco[6][25:26]:
                     (endereco == 113 )? data_endereco[6][27:28]:
                     (endereco == 114 )? data_endereco[6][29:30]:
                     (endereco == 115 )? data_endereco[6][31:32]:
                     (endereco == 116 )? data_endereco[6][33:34]:
                     (endereco == 117 )? data_endereco[6][35:36]:
                     (endereco == 118 )? data_endereco[6][37:38]:
                     (endereco == 119 )? data_endereco[6][39:40]:
                     (endereco == 120) ? data_endereco[7][1:2]:
                     (endereco == 121 )? data_endereco[7][3:4]:
                     (endereco == 122 )? data_endereco[7][5:6]:
                     (endereco == 123 )? data_endereco[7][7:8]:
                     (endereco == 124 )? data_endereco[7][9:10]:
                     (endereco == 125 )? data_endereco[7][11:12]:
                     (endereco == 126 )? data_endereco[7][13:14]:
                     (endereco == 127 )? data_endereco[7][15:16]:
                     (endereco == 128 )? data_endereco[7][17:18]:
                     (endereco == 129 )? data_endereco[7][19:20]:
                     (endereco == 130 )? data_endereco[7][21:22]:
                     (endereco == 131 )? data_endereco[7][23:24]:
                     (endereco == 132 )? data_endereco[7][25:26]:
                     (endereco == 133 )? data_endereco[7][27:28]:
                     (endereco == 134 )? data_endereco[7][29:30]:
                     (endereco == 135 )? data_endereco[7][31:32]:
                     (endereco == 136 )? data_endereco[7][33:34]:
                     (endereco == 137 )? data_endereco[7][35:36]:
                     (endereco == 138 )? data_endereco[7][37:38]:
                     (endereco == 139 )? data_endereco[7][39:40]:
                     (endereco == 140) ? data_endereco[8][1:2]:
                     (endereco == 141)? data_endereco[8][3:4]:
                     (endereco == 142 )? data_endereco[8][5:6]:
                     (endereco == 143 )? data_endereco[8][7:8]:
                     (endereco == 144 )? data_endereco[8][9:10]:
                     (endereco == 145 )? data_endereco[8][11:12]:
                     (endereco == 146 )? data_endereco[8][13:14]:
                     (endereco == 147 )? data_endereco[8][15:16]:
                     (endereco == 148 )? data_endereco[8][17:18]:
                     (endereco == 149 )? data_endereco[8][19:20]:
                     (endereco == 150 )? data_endereco[8][21:22]:
                     (endereco == 151 )? data_endereco[8][23:24]:
                     (endereco == 152 )? data_endereco[8][25:26]:
                     (endereco == 153 )? data_endereco[8][27:28]:
                     (endereco == 154 )? data_endereco[8][29:30]:
                     (endereco == 155 )? data_endereco[8][31:32]:
                     (endereco == 156 )? data_endereco[8][33:34]:
                     (endereco == 157 )? data_endereco[8][35:36]:
                     (endereco == 158 )? data_endereco[8][37:38]:
                     (endereco == 159 )? data_endereco[8][39:40]:
                     (endereco == 160) ? data_endereco[9][1:2]:
                     (endereco == 161 )? data_endereco[9][3:4]:
                     (endereco == 162 )? data_endereco[9][5:6]:
                     (endereco == 163 )? data_endereco[9][7:8]:
                     (endereco == 164 )? data_endereco[9][9:10]:
                     (endereco == 165 )? data_endereco[9][11:12]:
                     (endereco == 166 )? data_endereco[9][13:14]:
                     (endereco == 167 )? data_endereco[9][15:16]:
                     (endereco == 168 )? data_endereco[9][17:18]:
                     (endereco == 169 )? data_endereco[9][19:20]:
                     (endereco == 170 )? data_endereco[9][21:22]:
                     (endereco == 171 )? data_endereco[9][23:24]:
                     (endereco == 172 )? data_endereco[9][25:26]:
                     (endereco == 173 )? data_endereco[9][27:28]:
                     (endereco == 174 )? data_endereco[9][29:30]:
                     (endereco == 175 )? data_endereco[9][31:32]:
                     (endereco == 176 )? data_endereco[9][33:34]:
                     (endereco == 177 )? data_endereco[9][35:36]:
                     (endereco == 178 )? data_endereco[9][37:38]:
                     (endereco == 179 )? data_endereco[9][39:40]:
                    (endereco == 180) ? data_endereco[10][1:2]:
                     (endereco == 181 )? data_endereco[10][3:4]:
                     (endereco == 182 )? data_endereco[10][5:6]:
                     (endereco == 183 )? data_endereco[10][7:8]:
                     (endereco == 184 )? data_endereco[10][9:10]:
                     (endereco == 185 )? data_endereco[10][11:12]:
                     (endereco == 186 )? data_endereco[10][13:14]:
                     (endereco == 187 )? data_endereco[10][15:16]:
                     (endereco == 188 )? data_endereco[10][17:18]:
                     (endereco == 189 )? data_endereco[10][19:20]:
                     (endereco == 190 )? data_endereco[10][21:22]:
                     (endereco == 191 )? data_endereco[10][23:24]:
                     (endereco == 192 )? data_endereco[10][25:26]:
                     (endereco == 193 )? data_endereco[10][27:28]:
                     (endereco == 194 )? data_endereco[10][29:30]:
                     (endereco == 195 )? data_endereco[10][31:32]:
                     (endereco == 196 )? data_endereco[10][33:34]:
                     (endereco == 197 )? data_endereco[10][35:36]:
                     (endereco == 198 )? data_endereco[10][37:38]:
                     (endereco == 199 )? data_endereco[10][39:40]:
                     'bx): 'bz;
                     

  always @(*)
  begin
    if (w == 1)
    begin
      if(endereco == 0) 
      begin
      data_endereco[1][1:2] = data;
      end
      else if(endereco == 1 )
        begin
        data_endereco[1][3:4] = data;
        end
      else if(endereco == 2 )
        begin
         data_endereco[1][5:6] = data;
        end
      else if(endereco == 3 )
        begin
          data_endereco[1][7:8] = data;
        end
      else if(endereco == 4 )
      begin
        data_endereco[1][9:10] = data;
      end
      else if(endereco == 5 )
      begin 
        data_endereco[1][11:12] = data;
      end
      else if(endereco == 6 )
        begin 
          data_endereco[1][13:14] = data;
        end
      else if(endereco == 7 )
        begin 
        data_endereco[1][15:16] = data;
      end
      else if(endereco == 8 )
        begin 
          data_endereco[1][17:18] = data;
        end
        else if(endereco == 9 )
        begin 
          data_endereco[1][19:20] = data;
        end
        else if(endereco == 10 )
          begin 
            data_endereco[1][21:22] = data;
          end
        else if(endereco == 11 ) 
          begin 
            data_endereco[1][23:24] = data;
          end
        else if(endereco == 12 )
          begin 
            data_endereco[1][25:26] = data;
          end
        else if(endereco == 13 )
            begin
              data_endereco[1][27:28] = data;
          end
        else if(endereco == 14 )
          begin 
            data_endereco[1][29:30] = data;
          end
      else if(endereco == 15 ) 
        begin 
          data_endereco[1][31:32] = data;
        end
      else if(endereco == 16 ) 
        begin
            data_endereco[1][33:34] = data;
        end
    else if(endereco == 17 )
        begin
           data_endereco[1][35:36] = data;
      end
    else if(endereco == 18 ) 
      begin
         data_endereco[1][37:38] = data;
      end
      else if(endereco == 19 ) 
        begin 
          data_endereco[1][39:40] = data;
        end
      else if(endereco == 20) 
          begin 
        data_endereco[1][1:2] = data;
        end
      else if(endereco == 21 )
          begin
          data_endereco[2][3:4] = data;
      end
      else if(endereco == 22 ) 
        begin 
        data_endereco[2][5:6] = data;
      end
      else if(endereco == 23 )
          begin 
        data_endereco[2][7:8] = data;
      end
      else if(endereco == 24 ) 
        begin 
        data_endereco[2][9:10] = data;
      end
      else if(endereco == 25 ) 
        begin 
        data_endereco[2][11:12] = data;
      end
        else if(endereco == 26 ) 
          begin 
          data_endereco[2][13:14] = data;
        end
      else if(endereco == 27 )
          begin 
        data_endereco[2][15:16] = data;
      end
      else if(endereco == 28 )
          begin 
        data_endereco[2][17:18] = data;
      end
      else if(endereco == 29 ) 
        begin 
        data_endereco[2][19:20] = data;
      end
      else if(endereco == 30 ) 
        begin
          data_endereco[2][21:22] = data;
      end
      else if(endereco == 31 )
          begin 
        data_endereco[2][23:24] = data;
      end
      else if(endereco == 32 ) 
        begin
          data_endereco[2][25:26] = data;
      end
      else if(endereco == 33 )
          begin
          data_endereco[2][27:28] = data;
      end
        else if(endereco == 34 ) begin
            data_endereco[2][29:30] = data;
        end
          else if(endereco == 35 ) begin
              data_endereco[2][31:32] = data;
          end
            else if(endereco == 36 ) begin 
              data_endereco[2][33:34] = data;
            end
              else if(endereco == 37 ) begin 
                data_endereco[2][35:36] = data;
              end
                else if(endereco == 38 ) begin 
                  data_endereco[2][37:38] = data;
                end
                  else if(endereco == 39 ) begin 
                    data_endereco[2][39:40] = data;
                  end
                    else if(endereco == 40) begin 
                      data_endereco[3][1:2] = data;
                    end
                      else if(endereco == 41 ) begin 
                        data_endereco[3][3:4] = data;
                      end
                        else if(endereco == 42 ) begin
                            data_endereco[3][5:6] = data;
                        end
                          else if(endereco == 43 ) begin
                              data_endereco[3][7:8] = data;
                          end
                            else if(endereco == 44 ) begin
                                data_endereco[3][9:10] = data;
                            end
                              else if(endereco == 45 ) begin
                                  data_endereco[3][11:12] = data;
                              end
                                else if(endereco == 46 ) begin
                                    data_endereco[3][13:14] = data;
                                end
                                  else if(endereco == 47 ) begin
                                      data_endereco[3][15:16] = data;
                                  end
                                    else if(endereco == 48 ) begin
                                        data_endereco[3][17:18] = data;
                                    end
                                      else if(endereco == 49 ) begin 
                                        data_endereco[3][19:20] = data;
                                      end
                                        else if(endereco == 50 ) begin
                                            data_endereco[3][21:22] = data;
                                        end
                                          else if(endereco == 51 ) begin 
                                            data_endereco[3][23:24] = data;
                                          end
                                            else if(endereco == 52 ) begin
                                                data_endereco[3][25:26] = data;
                                            end
                                              else if(endereco == 53 ) begin 
                                                data_endereco[3][27:28] = data;
                                              end
                                                else if(endereco == 54 ) begin 
                                                  data_endereco[3][29:30] = data;
                                                end
                                                  else if(endereco == 55 ) begin
                                                      data_endereco[3][31:32] = data;
                                                  end
                                                    else if(endereco == 56 ) begin
                                                        data_endereco[3][33:34] = data;
                                                    end
                                                      else if(endereco == 57 ) begin 
                                                        data_endereco[3][35:36] = data;
                                                      end
                                                        else if(endereco == 58 ) begin 
                                                          data_endereco[3][37:38] = data;
                                                        end
                                                          else if(endereco == 59 ) begin 
                                                            data_endereco[3][39:40] = data;
                                                          end
                                                            else if(endereco == 60) begin 
                                                                data_endereco[4][1:2] = data;
                                                            end
                                                              else if(endereco == 61 ) begin 
                                                                data_endereco[4][3:4] = data;
                                                              end
                                                                else if(endereco == 62 ) begin 
                                                                  data_endereco[4][5:6] = data;
                                                                end
                                                                  else if(endereco == 63 ) begin 
                                                                    data_endereco[4][7:8] = data;
                                                                  end
                                                                    else if(endereco == 64 ) begin
                                                                        data_endereco[4][9:10] = data;
                                                                    end
                                                                      else if(endereco == 65 ) begin 
                                                                        data_endereco[4][11:12] = data;
                                                                      end
                                                                        else if(endereco == 66 ) begin
                                                                            data_endereco[4][13:14] = data;
                                                                        end
                                                                          else if(endereco == 67 ) begin 
                                                                            data_endereco[4][15:16] = data
                                                                            ;end
                                                                            else if(endereco == 68 ) begin 
                                                                              data_endereco[4][17:18] = data;
                                                                            end
                                                                              else if(endereco == 69 ) begin 
                                                                                data_endereco[4][19:20] = data;
                                                                              end
      else if(endereco == 70 ) begin data_endereco[4][21:22] = data;
    end
      else if(endereco == 71 ) begin data_endereco[4][23:24] = data;
      end
        else if(endereco == 72 ) begin data_endereco[4][25:26] = data;
        end
          else if(endereco == 73 ) begin data_endereco[4][27:28] = data;
          end
            else if(endereco == 74 ) begin data_endereco[4][29:30] = data;
            end
              else if(endereco == 75 ) begin data_endereco[4][31:32] = data;
              end
                else if(endereco == 76 ) begin data_endereco[4][33:34] = data;
                end
                  else if(endereco == 77 ) begin data_endereco[4][35:36] = data;
                  end
                    else if(endereco == 78 ) begin data_endereco[4][37:38] = data;
                    end
                      else if(endereco == 79 ) begin data_endereco[4][39:40] = data;
                      end
                        else if(endereco == 80) begin data_endereco[5][1:2] = data;
                        end
                          else if(endereco == 81) begin data_endereco[5][3:4] = data;
                          end
                            else if(endereco == 82) begin data_endereco[5][5:6] = data;
                            end
                              else if(endereco == 83 ) begin data_endereco[5][7:8] = data;
                              end
                                else if(endereco == 84 ) begin data_endereco[5][9:10] = data;
                                end
                                  else if(endereco == 85 ) begin data_endereco[5][11:12] = data;
                                  end
      else if(endereco == 86 ) begin data_endereco[5][13:14] = data;
      end
        else if(endereco == 87 ) begin data_endereco[5][15:16] = data;
        end
          else if(endereco == 88 ) begin data_endereco[5][17:18] = data;
          end
            else if(endereco == 89 ) begin data_endereco[5][19:20] = data;
            end
              else if(endereco == 90 ) begin data_endereco[5][21:22] = data;
              end
                else if(endereco == 91 ) begin data_endereco[5][23:24] = data;
                end
                  else if(endereco == 92 ) begin data_endereco[5][25:26] = data;
                  end
                    else if(endereco == 93 ) begin data_endereco[5][27:28] = data;
                    end
                      else if(endereco == 94 ) begin data_endereco[5][29:30] = data;
                      end
                        else if(endereco == 95 ) begin data_endereco[5][31:32] = data;
                        end
                          else if(endereco == 96 ) begin data_endereco[5][33:34] = data;
                          end
                            else if(endereco == 97 ) begin data_endereco[5][35:36] = data;
                            end
                              else if(endereco == 98 ) begin data_endereco[5][37:38] = data;
                              end
                                else if(endereco == 99 ) begin data_endereco[5][39:40] = data;
                                end
                                  else if(endereco == 100) begin data_endereco[6][1:2] = data;
                                  end
                                    else if(endereco == 101) begin  data_endereco[6][3:4] = data;
                                    end
                                      else if(endereco == 102) begin data_endereco[6][5:6] = data;
                                      end
                                        else if(endereco == 103 ) begin data_endereco[6][7:8] = data;
                                        end
                                          else if(endereco == 104 ) begin data_endereco[6][9:10] = data;
                                          end
                                            else if(endereco == 105 ) begin data_endereco[6][11:12] = data;
                                            end
                                              else if(endereco == 106 ) begin data_endereco[6][13:14] = data;
                                              end
                                                else if(endereco == 107 ) begin data_endereco[6][15:16] = data;
                                                end
                                                  else if(endereco == 108 ) begin data_endereco[6][17:18] = data;
                                                  end
                                                    else if(endereco == 109 ) begin data_endereco[6][19:20] = data;
                                                    end
                                                      else if(endereco == 110 ) begin data_endereco[6][21:22] = data;
                                                      end
                                                        else if(endereco == 111 ) begin data_endereco[6][23:24] = data;
                                                        end
                                                          else if(endereco == 112 ) begin data_endereco[6][25:26] = data
                                                            ;end
      else if(endereco == 113 ) begin data_endereco[6][27:28] = data;
      end
        else if(endereco == 114 ) begin data_endereco[6][29:30] = data;
        end
          else if(endereco == 115 ) begin data_endereco[6][31:32] = data;
          end
            else if(endereco == 116 ) begin data_endereco[6][33:34] = data;
            end
              else if(endereco == 117 ) begin data_endereco[6][35:36] = data
                ;end
                else if(endereco == 118 ) begin data_endereco[6][37:38] = data;
                end
                  else if(endereco == 119 ) begin data_endereco[6][39:40] = data;
                  end
                    else if(endereco == 120) begin  data_endereco[7][1:2] = data;
                    end
                      else if(endereco == 121 ) begin data_endereco[7][3:4] = data;
                      end
                        else if(endereco == 122 ) begin data_endereco[7][5:6] = data;
                        end
                          else if(endereco == 123 ) begin data_endereco[7][7:8] = data;
                          end
                            else if(endereco == 124 ) begin data_endereco[7][9:10] = data;
                            end
                              else if(endereco == 125 ) begin data_endereco[7][11:12] = data;
                              end
                                else if(endereco == 126 ) begin data_endereco[7][13:14] = data;
                                end
                                  else if(endereco == 127 ) begin data_endereco[7][15:16] = data;
                                  end
                                    else if(endereco == 128 ) begin data_endereco[7][17:18] = data;
                                    end
                                      else if(endereco == 129 ) begin data_endereco[7][19:20] = data;
                                      end
                                        else if(endereco == 130 ) begin data_endereco[7][21:22] = data;
                                        end
                                          else if(endereco == 131 ) begin data_endereco[7][23:24] = data;
                                          end
                                            else if(endereco == 132 ) begin data_endereco[7][25:26] = data;
                                            end
                                              else if(endereco == 133 ) begin data_endereco[7][27:28] = data;
                                              end
                                                else if(endereco == 134 ) begin data_endereco[7][29:30] = data;
                                                end
                                                  else if(endereco == 135 ) begin data_endereco[7][31:32] = data;
                                                  end
                                                    else if(endereco == 136 ) begin data_endereco[7][33:34] = data;
                                                    end
      else if(endereco == 137 ) begin data_endereco[7][35:36] = data;
      end
        else if(endereco == 138 ) begin data_endereco[7][37:38] = data;
        end
          else if(endereco == 139 ) begin data_endereco[7][39:40] = data;
          end
            else if(endereco == 140) begin  data_endereco[8][1:2] = data;
            end
              else if(endereco == 141) begin data_endereco[8][3:4] = data;
              end
                else if(endereco == 142 ) begin data_endereco[8][5:6] = data;
                end
                  else if(endereco == 143 ) begin data_endereco[8][7:8] = data;
                  end
                    else if(endereco == 144 ) begin data_endereco[8][9:10] = data;
                    end
                      else if(endereco == 145 ) begin data_endereco[8][11:12] = data;
                      end
                        else if(endereco == 146 ) begin data_endereco[8][13:14] = data;
                      end
      else if(endereco == 147 ) begin data_endereco[8][15:16] = data;
      end
        else if(endereco == 148 ) begin data_endereco[8][17:18] = data;
        end
          else if(endereco == 149 ) begin data_endereco[8][19:20] = data;
          end
            else if(endereco == 150 ) begin data_endereco[8][21:22] = data;
            end
              else if(endereco == 151 ) begin data_endereco[8][23:24] = data;
              end
                else if(endereco == 152 ) begin data_endereco[8][25:26] = data;
                end
                  else if(endereco == 153 ) begin data_endereco[8][27:28] = data;
                  end
                    else if(endereco == 154 ) begin data_endereco[8][29:30] = data;
                    end
                      else if(endereco == 155 ) begin data_endereco[8][31:32] = data;
                      end
                        else if(endereco == 156 ) begin data_endereco[8][33:34] = data;
                        end
                          else if(endereco == 157 ) begin data_endereco[8][35:36] = data;
                          end
                            else if(endereco == 158 ) begin data_endereco[8][37:38] = data;
                            end
                              else if(endereco == 159 ) begin data_endereco[8][39:40] = data;
                              end
                                else if(endereco == 160) begin data_endereco[9][1:2] = data;
                                end
                                  else if(endereco == 161 ) begin data_endereco[9][3:4] = data;
                                  end
      else if(endereco == 162 ) begin data_endereco[9][5:6] = data;
      end
        else if(endereco == 163 ) begin data_endereco[9][7:8] = data;
        end
          else if(endereco == 164 ) begin data_endereco[9][9:10] = data;
          end
            else if(endereco == 165 ) begin data_endereco[9][11:12] = data;
            end
              else if(endereco == 166 ) begin data_endereco[9][13:14] = data;
              end
                else if(endereco == 167 ) begin data_endereco[9][15:16] = data;
                end
                  else if(endereco == 168 ) begin data_endereco[9][17:18] = data;
                  end
                    else if(endereco == 169 ) begin data_endereco[9][19:20] = data;
                    end
                      else if(endereco == 170 ) begin data_endereco[9][21:22] = data;
                      end
                        else if(endereco == 171 ) begin data_endereco[9][23:24] = data;
                        end
                          else if(endereco == 172 ) begin data_endereco[9][25:26] = data;
                          end
                            else if(endereco == 173 ) begin data_endereco[9][27:28] = data;
                            end
                              else if(endereco == 174 ) begin data_endereco[9][29:30] = data;
                              end
                                else if(endereco == 175 ) begin data_endereco[9][31:32] = data;
                                end
                                  else if(endereco == 176 ) begin data_endereco[9][33:34] = data;
                                  end
                                    else if(endereco == 177 ) begin data_endereco[9][35:36] = data;
                                    end
                                      else if(endereco == 178 ) begin data_endereco[9][37:38] = data;
                                      end
                                        else if(endereco == 179 ) begin data_endereco[9][39:40] = data;
                                        end
      else if(endereco == 180) begin data_endereco[10][1:2] = data;
      end
        else if(endereco == 181 ) begin data_endereco[10][3:4] = data;
        end
          else if(endereco == 182 ) begin data_endereco[10][5:6] = data;
          end
            else if(endereco == 183 ) begin data_endereco[10][7:8] = data;
            end
              else if(endereco == 184 ) begin data_endereco[10][9:10] = data;
              end
                else if(endereco == 185 ) begin data_endereco[10][11:12] = data;
                end
                  else if(endereco == 186 ) begin data_endereco[10][13:14] = data;
                  end
                    else if(endereco == 187 ) begin data_endereco[10][15:16] = data;
                    end
                      else if(endereco == 188 ) begin data_endereco[10][17:18] = data;
                      end
                        else if(endereco == 189 ) begin data_endereco[10][19:20] = data;
                        end
                          else if(endereco == 190 ) begin data_endereco[10][21:22] = data;
                          end
                            else if(endereco == 191 ) begin data_endereco[10][23:24] = data;
                            end
                              else if(endereco == 192 ) begin data_endereco[10][25:26] = data;
                              end
                                else if(endereco == 193 ) begin data_endereco[10][27:28] = data;
                                end
                                  else if(endereco == 194 ) begin data_endereco[10][29:30] = data;
                                  end
                                    else if(endereco == 195 ) begin data_endereco[10][31:32] = data;
                                    end
                                      else if(endereco == 196 ) begin data_endereco[10][33:34] = data;
                                      end
                                        else if(endereco == 197 ) begin data_endereco[10][35:36] = data;
                                        end
      else if(endereco == 198 ) 
      begin 
          data_endereco[10][37:38] = data;
      end
      else if(endereco == 199 ) 
      begin
      data_endereco[10][39:40] = data;
      end
  end
end
endmodule
