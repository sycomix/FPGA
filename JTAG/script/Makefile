FILE_tar_controller = ../core/tar_controller.v ../testbench/tar_controller_tb.v
FILE_state_decoder = ../core/state_decoder.v ../testbench/state_decoder_tb.v
FILE_core_logic = ../core/tar_controller.v ../core/state_decoder.v ../core/core_logic.v ../core/top_module.v ../core/debugging.v ../testbench/core_logic_tb.v
FILE_ics = ../core/ics.v ../core/tar_controller.v ../core/ir.v ../core/state_decoder.v ../core/dr.v ../core/core_logic.v ../core/bypass.v  ../testbench/ics_tb.v
FILE_debugging = ../core/debugging.v ../testbench/debugging_tb.v

tar_controller_compile:
	iverilog -o tar_controller $(FILE_tar_controller)

tar_controller_vvp:
	vvp tar_controller

tar_controller_gtk:
	gtkwave tar_controller_tb.vcd

state_decoder_compile:
	iverilog -o state_decoder $(FILE_state_decoder)

state_decoder_vvp:
	vvp state_decoder

state_decoder_gtk:
	gtkwave state_decoder_tb.vcd

core_logic_compile:
	iverilog -o core_logic $(FILE_core_logic)

core_logic_vvp:
	vvp core_logic

core_logic_gtk:
	gtkwave core_logic_tb.vcd

debugging_compile:
	iverilog -o debugging $(FILE_debugging)

debugging_vvp:
	vvp debugging

debugging_gtk:
	gtkwave debugging_tb.vcd

ics_compile:
	iverilog -o ics $(FILE_ics)

ics_vvp:
	vvp ics

ics_gtk:
	gtkwave ics_tb.vcd