onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TF_EECS301_Lab4_TopLevel/CLOCK_50
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/sys_reset
add wave -noupdate /TF_EECS301_Lab4_TopLevel/LEDR
add wave -noupdate /TF_EECS301_Lab4_TopLevel/HEX0
add wave -noupdate /TF_EECS301_Lab4_TopLevel/HEX1
add wave -noupdate /TF_EECS301_Lab4_TopLevel/HEX2
add wave -noupdate /TF_EECS301_Lab4_TopLevel/HEX3
add wave -noupdate /TF_EECS301_Lab4_TopLevel/HEX4
add wave -noupdate /TF_EECS301_Lab4_TopLevel/HEX5
add wave -noupdate /TF_EECS301_Lab4_TopLevel/KEY
add wave -noupdate /TF_EECS301_Lab4_TopLevel/SW
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/calc_operand
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_add
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_sub
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_clr
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/cmd_clear
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/cmd_compute
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/cmd_operation
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/cmd_done
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/calc_result_ready
add wave -noupdate -radix hexadecimal /TF_EECS301_Lab4_TopLevel/uut/calc_result_data
add wave -noupdate -radix hexadecimal /TF_EECS301_Lab4_TopLevel/uut/bcd_result
add wave -noupdate -radix hexadecimal /TF_EECS301_Lab4_TopLevel/uut/seg_out
add wave -noupdate -divider Key_Commander
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/KEY_CLEAR
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/KEY_ADD
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/KEY_SUB
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/CMD_DONE
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/CMD_CLEAR
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/CMD_COMPUTE
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/CMD_OPERATION
add wave -noupdate /TF_EECS301_Lab4_TopLevel/uut/key_commander/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {106443299 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1050 us}
