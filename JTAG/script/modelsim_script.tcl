vlib work

vlog ../../core/ics.v
vlog ../../core/tar_controller.v
vlog ../../core/ir.v
vlog ../../core/dr.v
vlog ../../testbench/ics_tb.v

vsim -novopt work.ics_tb

add wave -radix bin sim:/ics_tb/TCK
add wave -radix bin sim:/ics_tb/TMS
add wave -radix bin sim:/ics_tb/TRST
add wave -radix bin sim:/ics_tb/TDI
add wave -radix bin sim:/ics_tb/TDO

run -all

wave zoom full