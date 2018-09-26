// Registers
module regfile
#(
    parameter WORD_SIZE = 32
)
(
    input                  clk
    // [+] Read data
,   input  [4:0]           ra1 
,   input  [4:0]           ra2
,   output [WORD_SIZE-1:0] rd1
,   output [WORD_SIZE-1:0] rd2
    // [+] Write data
,   input                  we
,   input  [4:0]           rd
,   input  [WORD_SIZE-1:0] wd
);

reg [WORD_SIZE-1:0] rf [WORD_SIZE-1:0];

always @( posedge clk ) begin
    if( we ) rf[ rd ] <= wd;
end

assign rd1 = ra1 ? rf[ ra1 ] : 0;
assign rd2 = ra2 ? rf[ ra2 ] : 0;  

endmodule
// RAM
module datamem_plain
#(
    parameter WORD_SIZE = 32
)
(   input                  clk
,   input                  we
,   input  [WORD_SIZE-1:0] addr
,   input  [WORD_SIZE-1:0] wd
,   output [WORD_SIZE-1:0] rd
);
  
reg [WORD_SIZE-1:0] RAM [63:0];

always @(posedge clk)
    if(we) RAM[addr[31:2]] <= wd;

assign rd = RAM[addr[31:2]];
endmodule