FILE_mips = ../core/mips.v ../core/instruction_memor.v ../core/data_memory.v ../core/register_file.v ../core/pc.v ../core/alu.v ../core/instruction_decode.v ../testbench/mips_tb.v
FILE_instruction_memor = ../core/instruction_memor.v ../testbench/instruction_memor_tb.v
FILE_alu = ../core/alu.v ../testbench/alu_tb.v
FILE_instruction_decode = ../core/instruction_decode.v ../testbench/instruction_decode_tb.v
FILE_data_memory = ../core/data_memory.v ../testbench/data_memory_tb.v
FILE_register_file = ../core/register_file.v ../testbench/register_file_tb.v
FILE_pc = ../core/pc.v ../testbench/pc_tb.v

mips_compile:
	iverilog -o mips $(FILE_mips)

mips_vvp:
	vvp mips

mips_gtk:
	gtkwave mips_tb.vcd

instruction_memor_compile:
	iverilog -o instruction_memor $(FILE_instruction_memor)

instruction_memor_vvp:
	vvp instruction_memor

instruction_memor_gtk:
	gtkwave instruction_memor_tb.vcd

data_memory_compile:
	iverilog -o data_memory $(FILE_data_memory)

data_memory_vvp:
	vvp data_memory

data_memory_gtk:
	gtkwave data_memory_tb.vcd

register_file_compile:
	iverilog -o register_file $(FILE_register_file)

register_file_vvp:
	vvp register_file

register_file_gtk:
	gtkwave register_file_tb.vcd

pc_compile:
	iverilog -o pc $(FILE_pc)

pc_vvp:
	vvp pc

pc_gtk:
	gtkwave pc_tb.vcd

instruction_decode_compile:
	iverilog -o instruction_decode $(FILE_instruction_decode)

instruction_decode_vvp:
	vvp instruction_decode

instruction_decode_gtk:
	gtkwave instruction_decode_tb.vcd

alu_compile:
	iverilog -o alu $(FILE_alu)

alu_vvp:
	vvp alu

alu_gtk:
	gtkwave alu_tb.vcd

