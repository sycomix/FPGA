module mips
#(
    parameter WORD_SIZE = 32
)
(
    input                   clk
, 	input					rst
);

// Proccess counter
reg   [WORD_SIZE-1:0] pc_next;
wire  [WORD_SIZE-1:0] pc;
pc #(.WORD_SIZE( WORD_SIZE )) pc_sample
( 
  .clk(clk)
, .rst(rst)
, .pc_next(pc_next)
, .pc(pc)
);

// Instruction memory
wire [WORD_SIZE-1:0]   instruction;
instruction_memor #(.WORD_SIZE( WORD_SIZE )) instruction_memor_sample
( .clk(clk)
, .addres(pc)
, .instruction(instruction)
);

// Register file
localparam ADDRES = $clog2(WORD_SIZE);
reg  [ADDRES-1:0]       addres_reg_1;
reg  [ADDRES-1:0]       addres_reg_2;
wire [WORD_SIZE-1:0]    data_reg_1;
wire [WORD_SIZE-1:0]    data_reg_2;
reg                     signal_we;
reg  [ADDRES-1:0]       addres_write;
reg  [WORD_SIZE-1:0]    data_write;
register_file #(.WORD_SIZE( WORD_SIZE )) register_file_sample
( .clk(clk)
, .addres_reg_1(addres_reg_1)
, .addres_reg_2(addres_reg_2)
, .data_reg_1(data_reg_1)
, .data_reg_2(data_reg_2)
, .signal_we(signal_we)
, .addres_write(addres_write)
, .data_write(data_write)
);

// Instruction Decode
wire [5:0]             opcode;
wire [4:0]             rtype_rs;
wire [4:0]             rtype_rt;
wire [4:0]             rtype_rd;
wire [4:0]             rtype_shamt;
wire [5:0]             rtype_funct;
wire [4:0]             itype_rs;
wire [4:0]             itype_rt;
wire [15:0]            itype_immediate;
wire [25:0]            jtype_addres;
instruction_decode #(.WORD_SIZE( WORD_SIZE )) instruction_decode_sample
( 
  .instruction(instruction)
, .opcode(opcode)
, .rtype_rs(rtype_rs)
, .rtype_rt(rtype_rt)
, .rtype_rd(rtype_rd)
, .rtype_shamt(rtype_shamt)
, .rtype_funct(rtype_funct)
, .itype_rs(itype_rs)
, .itype_rt(itype_rt)
, .itype_immediate(itype_immediate)
, .jtype_addres(jtype_addres)
);

// ALU


endmodule