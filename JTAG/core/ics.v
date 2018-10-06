module ics
(
    input      TMS
,   input      TCK
,   input      TRST
,   input      TDI
,   output reg TDO
    //  Switsh
,   input      SWITCH1    
,   input      SWITCH2
,   input      SWITCH3
,   input      SWITCH4
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

assign LED1 = SWITCH1 ? CORE_LOGIC_BSR[7] : BSR[7];
assign LED2 = SWITCH1 ? CORE_LOGIC_BSR[6] : BSR[6];
assign LED3 = SWITCH1 ? CORE_LOGIC_BSR[5] : BSR[5];
assign LED4 = SWITCH1 ? CORE_LOGIC_BSR[4] : BSR[4];
assign LED5 = SWITCH1 ? CORE_LOGIC_BSR[3] : BSR[3];
assign LED6 = SWITCH1 ? CORE_LOGIC_BSR[2] : BSR[2];
assign LED7 = SWITCH1 ? CORE_LOGIC_BSR[1] : BSR[1];
assign LED8 = SWITCH1 ? CORE_LOGIC_BSR[0] : BSR[0];

wire       TAP_rst;
wire       SELECT;
wire       ENABLE;
wire       UPDATEIR;
wire       SHIFTIR;
wire       UPDATEDR;
wire       SHIFTDR;
wire       CAPTUREIR;
wire       CAPTUREDR;
wire [3:0] JTAG_IR;
wire [7:0] INTEST_BSR = { LED1,LED2,LED3,LED4,LED5,LED6,LED7,LED8 };

wire BYPASS_SELECT;
wire SAMPLE_SELECT;
wire EXTEST_SELECT;
wire INTEST_SELECT;
wire RUNBIST_SELECT;
wire CLAMP_SELECT;
wire IDCODE_SELECT;
wire USERCODE_SELECT;
wire HIGHZ_SELECT;
wire CLOCKDR;
wire CLOCKIR;

// TDO
wire       INSTR_TDO;
wire [7:0] BSR;
wire       BSR_TDO;
wire       BYPASS_TDO;
wire       CORE_LOGIC_TDO;
wire [7:0] CORE_LOGIC_BSR;

tar_controller test_access_port
( 
  .TMS(TMS)
, .TCK(TCK)
, .TRST(TRST)
, .TAP_RST(TAP_rst)
, .SELECT(SELECT)
, .ENABLE(ENABLE)
, .UPDATEIR(UPDATEIR)
, .SHIFTIR(SHIFTIR)
, .UPDATEDR(UPDATEDR)
, .SHIFTDR(SHIFTDR)
, .CAPTUREIR(CAPTUREIR)
, .CAPTUREDR(CAPTUREDR)
);

ir instruction_register
(
  .TDI(TDI)
, .TCK(TCK)
, .rst(TRST)
, .UPDATEIR(UPDATEIR)
, .SHIFTIR(SHIFTIR)
, .CAPTUREIR(CAPTUREIR)
, .LATCH_JTAG_IR(JTAG_IR)
, .BYPASS_SELECT(BYPASS_SELECT)
, .SAMPLE_SELECT(SAMPLE_SELECT)
, .EXTEST_SELECT(EXTEST_SELECT)
, .INTEST_SELECT(INTEST_SELECT)
, .RUNBIST_SELECT(RUNBIST_SELECT)
, .CLAMP_SELECT(CLAMP_SELECT)
, .IDCODE_SELECT(IDCODE_SELECT)
, .USERCODE_SELECT(USERCODE_SELECT)
, .HIGHZ_SELECT(HIGHZ_SELECT)
, .CLOCKIR(CLOCKIR)
, .INSTR_TDO(INSTR_TDO)
);

dr test_data_register
(
  .rst(TAP_rst)
, .TCK(TCK)
, .TDI(TDI)
, .BSR(BSR)
, .UPDATEDR(UPDATEDR)
, .SHIFTDR(SHIFTDR)
, .CAPTUREDR(CAPTUREDR)
, .ENABLE(ENABLE)
, .BYPASS_SELECT(BYPASS_SELECT)
, .SAMPLE_SELECT(SAMPLE_SELECT)
, .EXTEST_SELECT(EXTEST_SELECT)
, .INTEST_SELECT(INTEST_SELECT)
, .RUNBIST_SELECT(RUNBIST_SELECT)
, .CLAMP_SELECT(CLAMP_SELECT)
, .IDCODE_SELECT(IDCODE_SELECT)
, .USERCODE_SELECT(USERCODE_SELECT)
, .HIGHZ_SELECT(HIGHZ_SELECT)
, .CLOCKDR(CLOCKDR)
, .BSR_TDO(BSR_TDO)
);

core_logic core_logic_fib
(
  .TCK(TCK)
, .rst(TRST)
, .CORE_LOGIC_BSR(CORE_LOGIC_BSR)
, .CORE_LOGIC_TDO(CORE_LOGIC_TDO)
, .SHIFTDR(SHIFTDR)
);

bypass bypass_tar
(
  .TCK(TCK)
, .TRST(TRST)
, .TDI(TDI)
, .SHIFTDR(SHIFTDR)
, .BYPASS_TDO(BYPASS_TDO)
);

localparam BYPASS   = 4'hF;
localparam SAMPLE   = 4'h1; 
localparam EXTEST   = 4'h2; 
localparam INTEST   = 4'h3; 
localparam RUNBIST  = 4'h4; 
localparam CLAMP    = 4'h5; 
localparam IDCODE   = 4'h7; 
localparam USERCODE = 4'h8; 
localparam HIGHZ    = 4'h9; 

always @(BSR_TDO or BYPASS_TDO) begin
    if (SHIFTIR) begin
        TDO <= INSTR_TDO;
    end else begin
        case(JTAG_IR)
            IDCODE:   begin TDO <= BSR_TDO;    end
            EXTEST:   begin TDO <= BSR_TDO;    end
            BYPASS:   begin TDO <= BYPASS_TDO; end
            default:  begin TDO <= BYPASS_TDO; end
        endcase 
    end
end

endmodule