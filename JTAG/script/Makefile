FILE_tar_controller = ../core/tar_controller.v ../testbench/tar_controller_tb.v
FILE_state_decoder = ../core/state_decoder.v ../testbench/state_decoder_tb.v
FILE_core_logic = ../core/tar_controller.v ../core/state_decoder.v ../core/core_logic.v ../core/top_module.v ../core/debugging.v ../testbench/core_logic_tb.v
FILE_top_module = ../core/top_module.v ../testbench/top_module_tb.v
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

top_module_compile:
	iverilog -o top_module $(FILE_top_module)

top_module_vvp:
	vvp top_module

top_module_gtk:
	gtkwave top_module_tb.vcd

debugging_compile:
	iverilog -o debugging $(FILE_debugging)

debugging_vvp:
	vvp debugging

debugging_gtk:
	gtkwave debugging_tb.vcd

