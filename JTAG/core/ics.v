module ics
(
    input            TMS       // J18: AB19
,   input            TCK       // J18: AA21
,   input            TDI       // J18: AB21
,   output reg       TDO       // J18: AA19

,   output     [3:0] IO        // IO[0] - V19 - LD4
                               // IO[1] - V20 - LD5
                               // IO[2] - Y22 - LD6
                               // IO[3] - W21 - LD7

,   output           TMS_LA    // J19: W17
,   output           TCK_LA    // J19: V17
,   output           TDI_LA    // J19: W18
,   output           TDO_LA    // J19: Y18

);

assign TMS_LA = TMS;
assign TCK_LA = TCK;
assign TDI_LA = TDI;
assign TDO_LA = TDO;

reg  [3:0] IO_REGISTER;
reg  [3:0] IO_CORE;

wire [3:0] IO_REGISTER_OUT;
wire [3:0] IO_CORE_OUT;
wire [3:0] IO_CORE_LOGIC;
wire [9:0] BSR;

wire       SELECT;
wire       ENABLE;
wire       TAP_RST;

wire       CAPTUREIR;
wire       SHIFTIR;
wire       UPDATEIR;

wire       EXIT1DR;

wire       CAPTUREDR;
wire       SHIFTDR;
wire       UPDATEDR;
wire [3:0] JTAG_IR;

wire       BYPASS_SELECT;
wire       SAMPLE_SELECT;
wire       EXTEST_SELECT;
wire       INTEST_SELECT;
wire       RUNBIST_SELECT;
wire       CLAMP_SELECT;
wire       IDCODE_SELECT;
wire       USERCODE_SELECT;
wire       HIGHZ_SELECT;
wire       CLOCKDR;
wire       CLOCKIR;

wire       ID_REG_TDO;
wire       USER_REG_TDO;
wire       INSTR_TDO;     
wire       BSR_TDO;       
wire       BYPASS_TDO;

tar_controller test_access_port
( 
  .TMS(TMS)
, .TCK(TCK)
//, .TRST(TRST)
, .TAP_RST(TAP_RST)
, .SELECT(SELECT)
, .ENABLE(ENABLE)
, .UPDATEIR(UPDATEIR)
, .SHIFTIR(SHIFTIR)
, .UPDATEDR(UPDATEDR)
, .SHIFTDR(SHIFTDR)
, .CAPTUREIR(CAPTUREIR)
, .CAPTUREDR(CAPTUREDR)
, .EXIT1DR(EXIT1DR)
);

ir instruction_register
(
  .TDI(TDI)
, .TCK(TCK)
, .TAP_RST(TAP_RST)
, .UPDATEIR(UPDATEIR)
, .SHIFTIR(SHIFTIR)
, .CAPTUREIR(CAPTUREIR)
, .LATCH_JTAG_IR(JTAG_IR)
, .CLOCKIR(CLOCKIR)
, .INSTR_TDO(INSTR_TDO)
);

dr test_data_register
(
//  .TRST(TRST)
  .TCK(TCK)
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
, .IO_REGISTER(IO_REGISTER)
, .IO_REGISTER_OUT(IO_REGISTER_OUT)
, .IO_CORE(IO_CORE)
, .IO_CORE_OUT(IO_CORE_OUT)
, .IO_CORE_LOGIC(IO_CORE_LOGIC)
);

state_decoder state_decoder_sample
(
  .LATCH_JTAG_IR(JTAG_IR)
, .BYPASS_SELECT(BYPASS_SELECT)
, .SAMPLE_SELECT(SAMPLE_SELECT)
, .EXTEST_SELECT(EXTEST_SELECT)
, .INTEST_SELECT(INTEST_SELECT)
, .RUNBIST_SELECT(RUNBIST_SELECT)
, .CLAMP_SELECT(CLAMP_SELECT)
, .IDCODE_SELECT(IDCODE_SELECT)
, .USERCODE_SELECT(USERCODE_SELECT)
, .HIGHZ_SELECT(HIGHZ_SELECT)
);

core_logic core_logic_01
(
  .TCK(TCK)
, .IO_CORE(IO_CORE)
, .IO_CORE_LOGIC(IO_CORE_LOGIC)
);

bypass bypass_tar
(
  .TCK(TCK)
, .TAP_RST(TAP_RST)
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

always @ (posedge TCK) begin
    if( UPDATEDR & (EXTEST_SELECT | SAMPLE_SELECT)) IO_REGISTER <= IO_REGISTER_OUT;
end

always @ (posedge TCK) begin
    if( UPDATEDR & (INTEST_SELECT | SAMPLE_SELECT)) IO_CORE     <= IO_CORE_OUT;
end

always @(ID_REG_TDO or USER_REG_TDO or BSR_TDO or BYPASS_TDO or INSTR_TDO or SHIFTDR or SHIFTIR or EXIT1DR or JTAG_IR) begin
    if ( SHIFTDR | EXIT1DR ) begin
        case(JTAG_IR)
            IDCODE:   begin TDO <= ID_REG_TDO;   end
            USERCODE: begin TDO <= USER_REG_TDO; end
            EXTEST:   begin TDO <= BSR_TDO;      end
            INTEST:   begin TDO <= BSR_TDO;      end
            SAMPLE:   begin TDO <= BSR_TDO;      end
            BYPASS:   begin TDO <= BYPASS_TDO;   end
            default:  begin TDO <= BYPASS_TDO;   end
        endcase 
    end else 
    if ( SHIFTIR ) begin
        TDO <= INSTR_TDO; 
    end 
    else begin
        TDO <= 1'bz;
    end
end

assign IO = !SAMPLE_SELECT ? IO_REGISTER : IO_CORE_LOGIC;

endmodule