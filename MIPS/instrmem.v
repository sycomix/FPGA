module instrmem (    
    input [31:0] addr
,   output reg [31:0] instr
);

    always @ (addr)
        case (addr)
            32'h00000000: instr <= 32'b001000_10000_00000_0000000000000100;   // -> addi $s0, $0, 4
            32'h00000004: instr <= 32'b001000_10001_00000_0000000000000110;   // -> addi $s1, $0, 6
            32'h00000008: instr <= 32'b000000_10000_10001_10011_00000_100000; // -> add $s0, $s1, $s2
            32'h0000000C: instr <= 32'b000010_00000000000000000000000000;     // -> j 0
            default: instr <= 0;
        endcase

endmodule