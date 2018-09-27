module alu
#(
    parameter WORD_SIZE = 32
,   parameter ADDRES    = $clog2(WORD_SIZE)
)
(
    input [5:0]                opcode
    // For instruction R-type
,   input [4:0]                rtype_rs
,   input [4:0]                rtype_rt
,   input [4:0]                rtype_rd
,   input [4:0]                rtype_shamt
,   input [5:0]                rtype_funct
    // For instruction I-type
,   input [4:0]                itype_rs
,   input [4:0]                itype_rt
,   input [15:0]               itype_immediate
    // For instruction J-type
,   input [25:0]               jtype_addres
,   output reg [WORD_SIZE-1:0] pc_next
,   output reg                 signal_we_register
,   output reg                 signal_we_memory
,   output reg [ADDRES-1:0]    addres_reg_1
,   output reg [ADDRES-1:0]    addres_reg_2
,   output reg [ADDRES-1:0]    addres_write_register
,   output reg [WORD_SIZE-1:0] data_write_register

,   output reg [WORD_SIZE-1:0] addres_write_memory
,   output reg [WORD_SIZE-1:0] data_write_memory
);

localparam INSTRUCTION_OPCODE_RTYPE = 6'b000_000;
localparam INSTRUCTION_SUB          = 6'b000_001;
localparam INSTRUCTION_OPCODE_JTYPE = 6'b000_010;
localparam INSTRUCTION_JAL_JTYPE    = 6'b000_011;
localparam INSTRUCTION_BEQ_ITYPE    = 6'b000_100;
localparam INSTRUCTION_BNE_ITYPE    = 6'b000_101;
localparam INSTRUCTION_BLEZ         = 6'b000_110;
localparam INSTRUCTION_BGTZ         = 6'b000_111;
localparam INSTRUCTION_ADDI_ITYPE   = 6'b001_000;
localparam INSTRUCTION_ADDIU_ITYPE  = 6'b001_001;
localparam INSTRUCTION_SLTI_ITYPE   = 6'b001_010;
localparam INSTRUCTION_SLTIU_ITYPE  = 6'b001_011;
localparam INSTRUCTION_ANDI_ITYPE   = 6'b001_100;
localparam INSTRUCTION_ORI_ITYPE    = 6'b001_101;
localparam INSTRUCTION_XORI         = 6'b001_110;
localparam INSTRUCTION_LUI_ITYPE    = 6'b001_111;
localparam INSTRUCTION_MFHI         = 6'b010_000;
localparam INSTRUCTION_MTHI         = 6'b010_001;
localparam INSTRUCTION_MFLO         = 6'b010_010;
localparam INSTRUCTION_MTLO         = 6'b010_011;
localparam INSTRUCTION_MULT         = 6'b011_000;
localparam INSTRUCTION_MULTU        = 6'b011_001;
localparam INSTRUCTION_DIV          = 6'b011_010;
localparam INSTRUCTION_DIVU         = 6'b011_011;
localparam INSTRUCTION_LB           = 6'b100_000;
localparam INSTRUCTION_LH           = 6'b100_001;
localparam INSTRUCTION_LWL          = 6'b100_010;
localparam INSTRUCTION_LW_ITYPE     = 6'b100_011;
localparam INSTRUCTION_LBU_ITYPE    = 6'b100_100;
localparam INSTRUCTION_LHU_ITYPE    = 6'b100_101;
localparam INSTRUCTION_LWR          = 6'b100_110;
localparam INSTRUCTION_NOR          = 6'b100_111;
localparam INSTRUCTION_SB_ITYPE     = 6'b101_000;
localparam INSTRUCTION_SH_ITYPE     = 6'b101_001;
localparam INSTRUCTION_SWL          = 6'b101_010;
localparam INSTRUCTION_SW_ITYPE     = 6'b101_011;
//localparam INSTRUCTION_           = 6'b101_100;
//localparam INSTRUCTION_           = 6'b101_101;
localparam INSTRUCTION_SWR          = 6'b101_110;
localparam INSTRUCTION_CACHE        = 6'b101_111;
localparam INSTRUCTION_LL           = 6'b110_000;
localparam INSTRUCTION_LWC1_ITYPE   = 6'b110_001;
localparam INSTRUCTION_LWC2         = 6'b110_010;
localparam INSTRUCTION_PREF         = 6'b110_011;
localparam INSTRUCTION_TEQ          = 6'b110_100;
localparam INSTRUCTION_LDE1_ITYPE   = 6'b110_001;
localparam INSTRUCTION_LDE2         = 6'b110_010;
//localparam INSTRUCTION_           = 6'b110_111;
localparam INSTRUCTION_SC_ITYPE     = 6'b111_000;
localparam INSTRUCTION_SWC1_ITYPE   = 6'b111_001;
localparam INSTRUCTION_SWC2         = 6'b111_010;
//localparam INSTRUCTION_           = 6'b111_111;
//localparam INSTRUCTION_           = 6'b111_100;
localparam INSTRUCTION_SDC1_ITYPE   = 6'b111_101;
localparam INSTRUCTION_SDC1         = 6'b111_110;
//localparam INSTRUCTION_           = 6'b111_111;

always @* begin
    pc_next <= pc_next + 4;
    signal_we_register <= 0;
    signal_we_memory <= 0;

    addres_reg_1          <= 5'b00000;
    addres_reg_2          <= 5'b00000;
    addres_write_register <= 5'b00000;
    data_write_register   <= 32'h00000000;
    addres_write_memory   <= 32'h00000000;
    data_write_memory     <= 32'h00000000;



end
endmodule