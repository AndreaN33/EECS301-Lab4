onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TF_BCD_Segment_Decoder/CLK
add wave -noupdate -divider {BCD Inputs}
add wave -noupdate /TF_BCD_Segment_Decoder/bcd_reg_0
add wave -noupdate /TF_BCD_Segment_Decoder/bcd_reg_1
add wave -noupdate /TF_BCD_Segment_Decoder/bcd_reg_2
add wave -noupdate /TF_BCD_Segment_Decoder/bcd_reg_3
add wave -noupdate /TF_BCD_Segment_Decoder/bcd_reg_4
add wave -noupdate -divider {Segment Outputs}
add wave -noupdate /TF_BCD_Segment_Decoder/seg_out_0
add wave -noupdate /TF_BCD_Segment_Decoder/seg_out_1
add wave -noupdate /TF_BCD_Segment_Decoder/seg_out_2
add wave -noupdate /TF_BCD_Segment_Decoder/seg_out_3
add wave -noupdate /TF_BCD_Segment_Decoder/seg_out_4
add wave -noupdate -divider {Test Digits}
add wave -noupdate /TF_BCD_Segment_Decoder/test_digit_0
add wave -noupdate /TF_BCD_Segment_Decoder/test_digit_1
add wave -noupdate /TF_BCD_Segment_Decoder/test_digit_2
add wave -noupdate /TF_BCD_Segment_Decoder/test_digit_3
add wave -noupdate /TF_BCD_Segment_Decoder/test_digit_4
add wave -noupdate -divider {Test Errors}
add wave -noupdate /TF_BCD_Segment_Decoder/test_output_errors
add wave -noupdate /TF_BCD_Segment_Decoder/total_errors
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {7550 us}
run 7 ms
