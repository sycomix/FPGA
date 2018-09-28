module ir
(
	input            rst
,   input            TDI
,	input	         UPDATEIR
,	input	         CLOCKIR
,	input	         SHIFTIR
,	output reg [3:0] JTAG_IR
);

// localparam BYPASS   = 4'h0000;
// localparam SAMPLE   = 4'h0001;
// localparam PRELOAD  = 4'h0010;
// localparam EXTEST   = 4'h0011;
// localparam INTEST   = 4'h0100;
// localparam RUNBIST  = 4'h0101;
// localparam CLAMP    = 4'h0110;
// localparam IDCODE   = 4'h0111;
// localparam USERCODE = 4'h1000;
// localparam HIGHZ    = 4'h1001;

endmodule