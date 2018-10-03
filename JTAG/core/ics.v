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
wire iTCK;
wire UPDATEIR;
wire CLOCKIR;
wire SHIFTIR;
wire UPDATEDR;
wire CLOCKDR;
wire SHIFTDR;
wire [3:0] JTAG_IR;
wire [3:0] state;

tar_controller test_access_port
( 
  .TMS(TMS)
, .TCK(TCK)
, .TRST(TRST)
, .TAP_rst(TAP_rst)
, .SELECT(SELECT)
, .ENABLE(ENABLE)
, .iTCK(iTCK)
, .UPDATEIR(UPDATEIR)
, .CLOCKIR(CLOCKIR)
, .SHIFTIR(SHIFTIR)
, .UPDATEDR(UPDATEDR)
, .CLOCKDR(CLOCKDR)
, .SHIFTDR(SHIFTDR)
, .state(state)
);

ir instruction_register
(
  .TDI(TDI)
, .UPDATEIR(UPDATEIR)
, .CLOCKIR(CLOCKIR)
, .SHIFTIR(SHIFTIR)
, .JTAG_IR(JTAG_IR)
, .state(state)
);

dr test_data_register
(
  .rst(TAP_rst)
, .UPDATEDR(UPDATEDR)
, .CLOCKDR(CLOCKDR)
, .SHIFTDR(SHIFTDR)
);

endmodule