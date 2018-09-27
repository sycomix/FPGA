module pc
#(
    parameter WORD_SIZE = 32
)
(
    input                      clk
,	input                      rst
,   input      [WORD_SIZE-1:0] pc_next
,   output reg [WORD_SIZE-1:0] pc    
);

always @(posedge clk) begin
	if (rst) begin
		pc <= 0;
	end else begin
		pc <= pc_next;
	end
end

endmodule