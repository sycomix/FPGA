module instruction_decode
#(
    parameter WORD_SIZE = 32
)
(
	input  [WORD_SIZE-1:0]   instruction
,	output [5:0]             opcode
	// For instruction R-type
,	output [4:0]             rtype_rs
,	output [4:0]             rtype_rt
,	output [4:0]             rtype_rd
,	output [4:0]             rtype_shamt
,	output [5:0]             rtype_funct
	// For instruction I-type
,	output [4:0]             itype_rs
,	output [4:0]             itype_rt
,	output [15:0]            itype_immediate
	// For instruction J-type
,	output [25:0]            jtype_addres
);

assign opcode = instruction[31:26];

// For instruction R-type
assign rtype_rs    = instruction[25:21];
assign rtype_rt    = instruction[20:16];
assign rtype_rd    = instruction[15:11];
assign rtype_shamt = instruction[10:6];
assign rtype_funct = instruction[5:0];

// For instruction I-type
assign itype_rs        = instruction[25:11];
assign itype_rt        = instruction[20:16];
assign itype_immediate = instruction[15:0];

// For instruction J-type
assign jtype_addres    = instruction[25:0];

endmodule