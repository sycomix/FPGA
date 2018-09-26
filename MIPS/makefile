all: comp vvp #gtk

comp:
	iverilog -o mips datapath_and_controller.v pc.v instrmem.v regfile.v testbench.v
vvp:
	vvp mips 
gtk:
	gtkwave testbench.vcd