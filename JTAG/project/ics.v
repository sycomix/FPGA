module ics
(
    input      TMS
,   input      TCK
,   input      TRST
,   input      TDI
,   output reg TDO
);

// --STR: TAP CONTROLLER -----
wire       TAP_RST;
wire       SELECT;
wire       ENABLE;
wire       CAPTUREIR;
wire       SHIFTIR;
wire       UPDATEIR;
wire       CAPTUREDR;
wire       SHIFTDR;
wire       UPDATEDR;
wire       EXIT1DR;
// --END: TAP CONTROLLER -----

tar_controller test_access_port
( 

  .TMS(TMS)
, .TCK(TCK)
, .TRST(TRST)
, .TAP_RST(TAP_RST)
, .SELECT(SELECT)
, .ENABLE(ENABLE)
, .CAPTUREIR(CAPTUREIR)
, .SHIFTIR(SHIFTIR)
, .UPDATEIR(UPDATEIR)
, .CAPTUREDR(CAPTUREDR)
, .SHIFTDR(SHIFTDR)
, .UPDATEDR(UPDATEDR)
, .EXIT1DR(EXIT1DR)

);


endmodule