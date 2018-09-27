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
		32'h00000000 : instruction <= 32'b00000000000000000000000000000000;
		32'h00000004 : instruction <= 32'b00000000000000000000000000000000;
		32'h00000008 : instruction <= 32'b00000000000000000000000000000000;
		32'h0000000C : instruction <= 32'b00000000000000000000000000000000;
		32'h00000010 : instruction <= 32'b00000000000000000000000000000000;
		default:       instruction <= 32'b00000000000000000000000000000000;
	endcase
end

endmodule