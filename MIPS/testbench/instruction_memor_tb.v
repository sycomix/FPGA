`timescale 1 ns / 1 ns
module instruction_memor_tb
#(
   parameter WORD_SIZE = 32
);

reg                    clk;
reg  [WORD_SIZE-1:0]   addres;
wire [WORD_SIZE-1:0]   instruction;

instruction_memor #(
   .WORD_SIZE( WORD_SIZE ) 
) instruction_memor_sample
( .clk(clk)
, .addres(addres)
, .instruction(instruction)
);

always begin
   #5  clk <= ~clk; // 200MHz
end

initial begin
   clk <= 0; @(posedge clk);
end

initial begin
    @(posedge clk);

      

    $finish;
end

initial begin
  $dumpfile("instruction_memor_tb.vcd");
   $dumpvars(-1, instruction_memor_tb);
end

endmodule