module mips
#(
    parameter WORD_SIZE = 32
)
(
    input                   clk
,   input                   rst
);

// Proccess counter
wire  [WORD_SIZE-1:0] pc_next;
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
wire [ADDRES-1:0]       addres_reg_1;
wire [ADDRES-1:0]       addres_reg_2;
wire [WORD_SIZE-1:0]    data_reg_1;
wire [WORD_SIZE-1:0]    data_reg_2;
wire                    signal_we_register;
wire [ADDRES-1:0]       addres_write_register;
wire [WORD_SIZE-1:0]    data_write_register;
register_file #(.WORD_SIZE( WORD_SIZE )) register_file_sample
( .clk(clk)
, .addres_reg_1(addres_reg_1)
, .addres_reg_2(addres_reg_2)
, .data_reg_1(data_reg_1)
, .data_reg_2(data_reg_2)
, .signal_we(signal_we_register)
, .addres_write(addres_write_register)
, .data_write(data_write_register)
);

// Data memory
wire [WORD_SIZE-1:0]    data_ram;
wire                    signal_we_memory;
wire  [WORD_SIZE-1:0]   addres_write_memory;
wire  [WORD_SIZE-1:0]   data_write_memory;

data_memory #(.WORD_SIZE( WORD_SIZE )) data_memory_sample
( .clk(clk)
, .data_ram(data_ram)
, .signal_we(signal_we_memory)
, .addres_write(addres_write_memory)
, .data_write(data_write_memory)
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
alu #(.WORD_SIZE( WORD_SIZE )) alu_sample
( 
  .opcode(opcode)
, .rtype_rs(rtype_rs)
, .rtype_rt(rtype_rt)
, .rtype_rd(rtype_rd)
, .rtype_shamt(rtype_shamt)
, .rtype_funct(rtype_funct)
, .itype_rs(itype_rs)
, .itype_rt(itype_rt)
, .itype_immediate(itype_immediate)
, .jtype_addres(jtype_addres)
, .data_reg_1(data_reg_1)
, .data_reg_2(data_reg_2)
, .pc(pc)
, .pc_next(pc_next)
, .signal_we_register(signal_we_register)
, .signal_we_memory(signal_we_memory)
, .addres_reg_1(addres_reg_1)
, .addres_reg_2(addres_reg_2)
, .addres_write_register(addres_write_register)
, .data_write_register(data_write_register)
, .addres_write_memory(addres_write_memory)
, .data_write_memory(data_write_memory)
);


endmodule