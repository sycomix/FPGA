vlib work

vlog ../../core/tar_controller.v
vlog ../../testbench/tar_controller_tb.v

vsim -novopt work.tar_controller_tb

add wave -radix bin sim:/tar_controller_tb/TCK
add wave -radix bin sim:/tar_controller_tb/TDO
add wave -radix bin sim:/tar_controller_tb/TDI
add wave -radix bin sim:/tar_controller_tb/TMS
add wave -radix bin sim:/tar_controller_tb/TRST

run -all

wave zoom full