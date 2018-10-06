module ics
(
    input      TMS
,   input      TCK
,   input      TRST
,   input      TDI
,   output reg TDO
,   input      SWITCH1
,   output     LED_BOARD1
    // LED
,   output     LED1
,   output     LED2
,   output     LED3
,   output     LED4
,   output     LED5
,   output     LED6
,   output     LED7
,   output     LED8
);


assign { LED1,LED2,LED3,LED4,LED5,LED6,LED7,LED8 } = !SWITCH1 ? 8'b10011001 : 8'b01010101;
assign LED_BOARD1 = SWITCH1;

endmodule