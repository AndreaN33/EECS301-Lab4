onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TF_BCD_Binary_Encoder/CLK
add wave -noupdate /TF_BCD_Binary_Encoder/RESET
add wave -noupdate -divider {Test Signals}
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/BIN_DATA
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/bcd_out_0
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/bcd_out_1
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/bcd_out_2
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/bcd_out_3
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/bcd_out_4
add wave -noupdate /TF_BCD_Binary_Encoder/bcd_overflow
add wave -noupdate -divider {Test Verification Signals}
add wave -noupdate /TF_BCD_Binary_Encoder/expected_overflow
add wave -noupdate /TF_BCD_Binary_Encoder/expected_value
add wave -noupdate /TF_BCD_Binary_Encoder/result_value
add wave -noupdate /TF_BCD_Binary_Encoder/bcd_out_0_valid
add wave -noupdate /TF_BCD_Binary_Encoder/bcd_out_1_valid
add wave -noupdate /TF_BCD_Binary_Encoder/bcd_out_2_valid
add wave -noupdate /TF_BCD_Binary_Encoder/bcd_out_3_valid
add wave -noupdate /TF_BCD_Binary_Encoder/bcd_out_4_valid
add wave -noupdate /TF_BCD_Binary_Encoder/total_errors
add wave -noupdate /TF_BCD_Binary_Encoder/error_status
add wave -noupdate -divider {BCD_Binary_Encoder Signals}
add wave -noupdate /TF_BCD_Binary_Encoder/uut/State
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/uut/bin_shift_reg
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/uut/bcd_shift_reg
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/uut/bcd_adder_sum
add wave -noupdate -radix hexadecimal /TF_BCD_Binary_Encoder/uut/shift_counter_reg
add wave -noupdate /TF_BCD_Binary_Encoder/uut/shift_counter_done
add wave -noupdate /TF_BCD_Binary_Encoder/uut/overflow_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
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
WaveRestoreZoom {0 ps} {11550 us}
run 11 ms