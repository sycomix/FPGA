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

,   input      [3:0] IO_IN
,   output     [3:0] IO_OUT
,   output reg [7:0] BSR
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

always @ (posedge TCK) begin
    if ( IDCODE_SELECT ) begin
        ID_REG_COPY   <= SHIFTDR ? {TDI,ID_REG_COPY[7:1]}   : ID_REG;
    end else 
    if ( USERCODE_SELECT ) begin
        USER_REG_COPY <= SHIFTDR ? {TDI,USER_REG_COPY[7:1]} : USER_REG;
    end else
    if ( SAMPLE_SELECT ) begin
        if ( CAPTUREDR ) begin
            BSR <= {IO_IN[3:0], BSR[3:0]};
        end else 
        if( SHIFTDR ) begin
            BSR <= {TDI,BSR[7:1]};  
        end
    end
end

always @ (negedge TCK) BSR_TDO      <= BSR[0];
always @ (negedge TCK) ID_REG_TDO   <= ID_REG_COPY[0];
always @ (negedge TCK) USER_REG_TDO <= USER_REG_COPY[0];

assign CLOCKDR = CAPTUREDR | SHIFTDR ? TCK : 1'b1;
assign IO_OUT = BSR[7:4];

endmodule