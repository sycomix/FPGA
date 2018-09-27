module instruction_memor
#(
    parameter WORD_SIZE = 32
)
(
    input                        clk
,	input      [WORD_SIZE-1:0]   addres
,   output reg [WORD_SIZE-1:0]   instruction
);

always @( posedge clk ) begin
	case ( addres )
        32'h00000000: instruction <= 32'b001000_10000_00000_0000000000000100;   // -> addi $s0, $0, 4
        32'h00000004: instruction <= 32'b001000_10001_00000_0000000000000110;   // -> addi $s1, $0, 6
        32'h00000008: instruction <= 32'b000000_10000_10001_10011_00000_100000; // -> add $s0, $s1, $s2
        32'h0000000C: instruction <= 32'b000010_00000000000000000000000000;     // -> j 0
		default:      instruction <= 32'b00000000000000000000000000000000;
	endcase
end

endmodule