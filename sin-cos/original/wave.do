onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider testbench
add wave -noupdate /cordic_test/start
add wave -noupdate /cordic_test/sin_cos/clock
add wave -noupdate /cordic_test/sin_cos/angle
add wave -noupdate /cordic_test/sin_cos/Xin
add wave -noupdate /cordic_test/sin_cos/Yin
add wave -noupdate -max 31994.0 -min -31998.0 /cordic_test/sin_cos/Xout
add wave -noupdate -max 31998.999999999996 -min -31995.0 /cordic_test/sin_cos/Yout
add wave -noupdate /cordic_test/sin_cos/atan_table
add wave -noupdate /cordic_test/sin_cos/X
add wave -noupdate /cordic_test/sin_cos/Y
add wave -noupdate /cordic_test/sin_cos/Z
add wave -noupdate /cordic_test/sin_cos/quadrant
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1109962 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 170
configure wave -valuecolwidth 46
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5357100 ps}
