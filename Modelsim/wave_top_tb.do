onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /Top_tb/clk
add wave -noupdate -radix binary /Top_tb/reset
add wave -noupdate -expand -group Robo -radix unsigned /Top_tb/robo_row
add wave -noupdate -expand -group Robo -radix unsigned /Top_tb/robo_col
add wave -noupdate -expand -group Robo -radix unsigned /Top_tb/robo_orientacao
add wave -noupdate -expand -group Output -radix binary /Top_tb/head
add wave -noupdate -expand -group Output -radix binary /Top_tb/left
add wave -noupdate -expand -group Output -radix binary /Top_tb/under
add wave -noupdate -expand -group Output -radix binary /Top_tb/barrier
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {54 ns}
