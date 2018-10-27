module ir
(
    input            TRST
,   input            TDI
,   input            TCK
,   input            UPDATEIR
,   input            SHIFTIR
,   input            CAPTUREIR
,   output reg [3:0] LATCH_JTAG_IR
,   output reg       INSTR_TDO
,   output           CLOCKIR
);

localparam BYPASS   = 4'hF;
reg [3:0] JTAG_IR;

assign CLOCKIR = CAPTUREIR | SHIFTIR ? TCK : 1'b1;

always @(posedge CLOCKIR) begin
    if( SHIFTIR ) JTAG_IR <= {TDI,JTAG_IR[3:1]};
end

always @(negedge CLOCKIR) begin
    INSTR_TDO <= JTAG_IR[0];
end

always @(posedge TCK or posedge TRST) begin
    if ( TRST ) begin
        LATCH_JTAG_IR <= BYPASS;
    end else 
    if ( UPDATEIR ) begin
        LATCH_JTAG_IR <= JTAG_IR;
    end
end

endmodule