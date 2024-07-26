onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Entradas
add wave -noupdate -radix binary /Robo_TB/head
add wave -noupdate -radix binary /Robo_TB/left
add wave -noupdate -radix binary /Robo_TB/under
add wave -noupdate -radix binary /Robo_TB/barrier
add wave -noupdate -divider Controle
add wave -noupdate -radix binary /Robo_TB/clock
add wave -noupdate -radix binary /Robo_TB/reset
add wave -noupdate -divider Saidas
add wave -noupdate -radix binary /Robo_TB/avancar
add wave -noupdate -radix binary /Robo_TB/girar
add wave -noupdate -radix binary /Robo_TB/remover
add wave -noupdate -divider Posicao
add wave -noupdate -radix unsigned /Robo_TB/Linha_Robo
add wave -noupdate -radix unsigned /Robo_TB/Coluna_Robo
add wave -noupdate -radix unsigned /Robo_TB/Orientacao_Robo
add wave -noupdate -divider Estados
add wave -noupdate -radix unsigned /Robo_TB/DUV/Estado_Atual
add wave -noupdate -radix unsigned /Robo_TB/DUV/Proximo_Estado
add wave -noupdate -radix decimal /Robo_TB/Peso_Entulho
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {111 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1125 ns}
