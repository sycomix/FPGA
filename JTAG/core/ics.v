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

assign { LED1
        ,LED2
        ,LED3
        ,LED4
        ,LED5
        ,LED6
        ,LED7
        ,LED8 
        } = SWITCH1 ? CORE_LOGIC_DATA[7:0] : BSR[7:0];

wire [7:0] BSR;
wire [7:0] CORE_LOGIC_DATA;

wire       SELECT;
wire       ENABLE;
wire       TAP_RST;

wire       CAPTUREIR;
wire       SHIFTIR;
wire       UPDATEIR;

wire       CAPTUREDR;
wire       SHIFTDR;
wire       UPDATEDR;
wire [3:0] JTAG_IR;

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
wire       ID_REG_TDO;
wire       USER_REG_TDO;
wire       INSTR_TDO;     // Вывод инструкции на TDO
wire       BSR_TDO;       // Вывод на TDO Boundary Scan Chain
wire       BYPASS_TDO;

tar_controller test_access_port
( 
  .TMS(TMS)
, .TCK(TCK)
, .TRST(TRST)
, .TAP_RST(TAP_RST)
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
, .TRST(TRST)
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
  .TRST(TRST)
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
, .ID_REG_TDO(ID_REG_TDO)
, .USER_REG_TDO(USER_REG_TDO)
);

core_logic core_logic_fib
(
  .TCK(TCK)
, .TRST(TRST)
, .CORE_LOGIC_DATA(CORE_LOGIC_DATA)
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

always @(ID_REG_TDO or USER_REG_TDO or BSR_TDO or BYPASS_TDO or INSTR_TDO) begin
    if ( SHIFTIR ) begin
    // При загрузке новой команды, выводим на TDO команду, 
    // которая лежала до этого в регистре JTAG_IR
        TDO <= INSTR_TDO; 
    end else begin
        case(JTAG_IR)
            IDCODE:   begin TDO <= ID_REG_TDO;   end
            USERCODE: begin TDO <= USER_REG_TDO; end
            EXTEST:   begin TDO <= BSR_TDO;      end
            BYPASS:   begin TDO <= BYPASS_TDO;   end
            default:  begin TDO <= BYPASS_TDO;   end
        endcase 
    end
end

endmodule