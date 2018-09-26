module pc
#(
    parameter WORD_SIZE = 32
)
(
    input                      clk
,   input      [WORD_SIZE-1:0] pc_next
,   output reg [WORD_SIZE-1:0] pc    
);

always @(posedge clk) begin
    pc <= pc_next;
end

endmodule