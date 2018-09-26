module datapath_and_controller
#(
    parameter WORD_SIZE = 32
)
(
    input                  clk
,   input                  rst
,   output [WORD_SIZE-1:0] pc
    // Working with data memory
,   input [WORD_SIZE-1:0] dmem_rd 
,   output reg dmem_we
,   output reg [WORD_SIZE-1:0] dmem_addr
,   output reg [WORD_SIZE-1:0] dmem_wd
);

`include "parameters.vh"

 // Register file
reg  [4:0]  rf_ra1;
reg  [4:0]  rf_ra2;
wire [31:0] rf_rd1;
wire [31:0] rf_rd2;

reg rf_we;
reg [4:0] rf_wa;
reg [31:0] rf_wd;

// [ Start : !] R-type -- [ op (6 бит) ][ rs (5 бит) ][ rt (5 бит) ][ rd (5 бит) ][ shamt (5 бит) ][ funct (6 бит) ]

wire [5:0] instr_op;
wire [4:0] instr_rtype_rs;
wire [4:0] instr_rtype_rt;
wire [4:0] instr_rtype_rd;
wire [4:0] instr_rtype_shamt;
wire [5:0] instr_rtype_funct;

assign instr_op          = instruction[31:26];
assign instr_rtype_rs    = instruction[25:21];
assign instr_rtype_rt    = instruction[20:16];
assign instr_rtype_rd    = instruction[15:11];
assign instr_rtype_shamt = instruction[10:6];
assign instr_rtype_funct = instruction[5:0];

// [ End : !] R-type

// [ Start : !] I-type -- [ op (6 бит) ][ rs (5 бит) ][ rt (5 бит) ][ imm (16 бит) ]    

wire [5:0]  instr_itype_op;
wire [4:0]  instr_itype_rs;
wire [4:0]  instr_itype_rt;
wire [15:0] instr_itype_imm;

assign instr_itype_op  = instruction[31:26];
assign instr_itype_rs  = instruction[25:21];
assign instr_itype_rt  = instruction[20:16];
assign instr_itype_imm = instruction[15:0];

// [ End : !] I-type

// [ Start : !] J-type -- [ op (6 бит) ][ addr (26 бит) ]

wire [25:0] instr_jtype_addr;

assign instr_jtype_addr = instruction[25:0];

// [ End : !] J-type

// Instruction memory
wire [WORD_SIZE-1:0] instruction;

// Programm counter
reg [31:0] pc_next;

// Экземпляры
instrmem ist( pc, instruction );
pc pcount( clk, pc_next, pc );
regfile regfil(clk, rf_ra1, rf_ra2, rf_rd1, rf_rd2, rf_we, rf_wa, rf_wd);
datamem_plain datamem(clk, dmem_we, dmem_addr, dmem_wd, dmem_rd);

always @(*) begin
    if ( rst ) begin
        pc_next <= 0;
    end else begin
        rf_we = 0;
        dmem_we = 0;
        rf_ra1 = 0;
        rf_ra2 = 0;
        rf_wa = 0;
        rf_wd = 0;
        dmem_addr = 0;
        dmem_wd = 0;
        pc_next = pc + 4;
        case(instr_op)
            INSTR_OP_RTYPE: begin
                case(instr_rtype_funct)
                    INSTR_RTYPE_FUNCT_ADD: begin
                        rf_ra1 = instr_rtype_rs; // Передаем адрес первого значения в регистре
				        rf_ra2 = instr_rtype_rt; // Передаем адрес второго значения в регистре
                        rf_wa  = instr_rtype_rd; // Передаем адрес назначения, куда будут записывать значения
                        rf_wd  = rf_rd1 + rf_rd2;// Вычисляем 
                        rf_we  = 1;              // Записываем
                    end
                    INSTR_RTYPE_FUNCT_SUB: begin
                        rf_ra1 = instr_rtype_rs; 
                        rf_ra2 = instr_rtype_rt; 
                        rf_wa  = instr_rtype_rd; 
                        rf_wd  = rf_rd1 - rf_rd2;
                        rf_we  = 1; 
                    end
                endcase
            end
            INSTR_OP_LW: begin
                rf_ra1 = instr_itype_rs;
                dmem_addr = rf_rd1 + instr_itype_imm;
                rf_wa = instr_itype_rt;
                rf_wd = dmem_rd;
                rf_we = 1;
            end
            INSTR_OP_SW: begin
                rf_ra1 = instr_itype_rs;
                rf_ra2 = instr_itype_rt;
                dmem_addr = rf_rd1 + instr_itype_imm;
                dmem_wd = rf_rd2;
                dmem_we = 1;
            end
            INSTR_OP_ADDI: begin
                rf_ra1 = instr_itype_rs;
                rf_wa = instr_itype_rt;
                rf_wd = rf_rd1 + instr_itype_imm;
                rf_we = 1;
            end
            INSTR_OP_BEQ: begin
                rf_ra1 = instr_itype_rs;
                rf_ra2 = instr_itype_rt;
                if(rf_rd1 == rf_rd2) begin
                    pc_next = instr_itype_imm;
                end
            end
            INSTR_OP_J: begin
                pc_next = instr_jtype_addr;
            end
        endcase
    end
end

endmodule
