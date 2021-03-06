module dr
(
    input            TRST
,   input            TCK
,   input            TDI
,   input            ENABLE

,   output           CLOCKDR
,   input            CAPTUREDR
,   input            UPDATEDR
,   input            SHIFTDR

    // ------IO ICs -> BSR----------
,   input      [3:0] IO_REGISTER
,   output     [3:0] IO_REGISTER_OUT
    // --IO CoreLogic -> BSR--------
,   input      [3:0] IO_CORE
,   input      [3:0] IO_CORE_LOGIC
,   output     [3:0] IO_CORE_OUT
    // ---------------------------- 
,   output reg [9:0] BSR
    // -----------TDO--------------
,   output reg       BSR_TDO
,   output reg       ID_REG_TDO
,   output reg       USER_REG_TDO

,   input            BYPASS_SELECT
,   input            SAMPLE_SELECT
,   input            EXTEST_SELECT
,   input            INTEST_SELECT
,   input            RUNBIST_SELECT
,   input            CLAMP_SELECT
,   input            IDCODE_SELECT
,   input            USERCODE_SELECT
,   input            HIGHZ_SELECT
);

reg [7:0] ID_REG   = 8'hA1;
reg [7:0] ID_REG_COPY;
reg [7:0] USER_REG = 8'h99;
reg [7:0] USER_REG_COPY;

localparam LSB = 2'b01;

always @ (posedge CLOCKDR) begin
    if ( IDCODE_SELECT ) begin
        ID_REG_COPY   <= SHIFTDR ? { TDI, ID_REG_COPY[7:1] }   : ID_REG;
    end else 
    if ( USERCODE_SELECT ) begin
        USER_REG_COPY <= SHIFTDR ? { TDI, USER_REG_COPY[7:1] } : USER_REG;
    end
end

always @ (posedge CLOCKDR) begin
    if ( SAMPLE_SELECT & !SHIFTDR & CAPTUREDR) begin
        BSR <= { IO_REGISTER[3:0], IO_CORE[3:0], LSB };
    end else
    if ( EXTEST_SELECT & !SHIFTDR & CAPTUREDR) begin
        BSR <= { IO_REGISTER[3:0], BSR[3:0], LSB };
    end else
    if ( INTEST_SELECT & !SHIFTDR & CAPTUREDR) begin
        BSR <= { IO_CORE_LOGIC[3:0], IO_CORE[3:0], LSB };
    end else
    if ( SHIFTDR & (SAMPLE_SELECT | EXTEST_SELECT | INTEST_SELECT)) begin
        BSR <= { TDI,BSR[9:1] };
    end
end

always @ (negedge TCK) BSR_TDO      <= BSR[0];
always @ (negedge TCK) ID_REG_TDO   <= ID_REG_COPY[0];
always @ (negedge TCK) USER_REG_TDO <= USER_REG_COPY[0];

assign CLOCKDR = CAPTUREDR | SHIFTDR ? TCK : 1'b1;
assign IO_REGISTER_OUT = BSR[9:6];
assign IO_CORE_OUT     = BSR[5:2];

endmodule