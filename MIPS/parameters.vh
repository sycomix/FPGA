// R-type -- [ op (6 бит) ][ rs (5 бит) ][ rt (5 бит) ][ rd (5 бит) ][ shamt (5 бит) ][ funct (6 бит) ]
// op + funct = операция
// op (opcode) = 0 для всех операций R-type
parameter INSTR_OP_RTYPE        = 6'b000000;
parameter INSTR_RTYPE_FUNCT_ADD = 6'b100000;
parameter INSTR_RTYPE_FUNCT_SUB = 6'b100010;

// I-type -- [ op (6 бит) ][ rs (5 бит) ][ rt (5 бит) ][ imm (16 бит) ] 
// op - код операции
parameter INSTR_OP_LW    = 6'b100011;
parameter INSTR_OP_SW    = 6'b101011;
parameter INSTR_OP_ADDI  = 6'b001000;
parameter INSTR_OP_BEQ   = 6'b000100;

// J-type -- [ op (6 бит) ][ addr (26 бит) ]
// op - код операции
parameter INSTR_OP_J     = 6'b000010;	 

