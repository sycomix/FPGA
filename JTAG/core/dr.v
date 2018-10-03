module dr
(
    input            rst
,	input	         UPDATEDR
,	input	         CLOCKDR
,	input	         SHIFTDR
);

reg [31:0] device_ID_register = 32'hA1B1C1D1;
reg bypass;

endmodule