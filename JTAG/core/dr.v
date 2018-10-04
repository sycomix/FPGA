module dr
(
    input            rst
,	input			 TCK
,	input			 TDI
,	input	         UPDATEDR
,	input	         SHIFTDR
,	input			 CAPTUREDR
,   output reg [7:0] BSR
,	output reg       BSR_TDO
,	input            BYPASS_SELECT
,	input            SAMPLE_SELECT
,	input            EXTEST_SELECT
,	input            INTEST_SELECT
,	input            RUNBIST_SELECT
,	input            CLAMP_SELECT
,	input            IDCODE_SELECT
,	input            USERCODE_SELECT
,	input            HIGHZ_SELECT
);

reg [7:0] device_ID_register = 8'hA1;

always @ (posedge TCK) begin
	if (IDCODE_SELECT && SHIFTDR) begin
		BSR <= {TDI,BSR[7:1]};
	end else begin
		BSR <= device_ID_register;
	end
end

always @ (negedge TCK) begin
    BSR_TDO <= BSR[0];
end

endmodule