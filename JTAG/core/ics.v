module ics
(
    input      TMS
,   input      TCK
,   input      TRST
,   input      TDI
,   output     TDO
);

wire TAP_rst;
wire SELECT;
wire ENABLE;
wire invTCK;
wire UPDATEIR;
wire CLOCKIR;
wire SHIFTIR;
wire UPDATEDR;
wire CLOCKDR;
wire SHIFTDR;
wire [3:0] JTAG_IR;

tar_controller test_access_port
( 
  .TMS(TMS)
, .TCK(TCK)
, .TRST(TRST)
, .TAP_rst(TAP_rst)
, .SELECT(SELECT)
, .ENABLE(ENABLE)
, .invTCK(invTCK)
, .UPDATEIR(UPDATEIR)
, .CLOCKIR(CLOCKIR)
, .SHIFTIR(SHIFTIR)
, .UPDATEDR(UPDATEDR)
, .CLOCKDR(CLOCKDR)
, .SHIFTDR(SHIFTDR)
);

ir instruction_register
(
  .TDI(TDI)
, .UPDATEIR(UPDATEIR)
, .CLOCKIR(CLOCKIR)
, .SHIFTIR(SHIFTIR)
, .JTAG_IR(JTAG_IR)
);

dr test_data_register
(
  .rst(TAP_rst)
, .UPDATEDR(UPDATEDR)
, .CLOCKDR(CLOCKDR)
, .SHIFTDR(SHIFTDR)
);

endmodule