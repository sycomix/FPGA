`timescale 1 ns / 1 ns
module mips_tb
#(
   parameter WORD_SIZE = 32
);

reg clk, rst;

mips #(
   .WORD_SIZE( WORD_SIZE ) 
) mips_sample
( .clk(clk)
, .rst(rst)
);

always begin
   #5  clk <= ~clk; // 200MHz
end

initial begin
   clk <= 0; @(posedge clk);
   rst <= 1; @(posedge clk);
   rst <= 0; @(posedge clk);
end

initial begin
  @(negedge rst);

  
  
  $finish;
end

initial begin
  $dumpfile("mips_tb.vcd");
   $dumpvars(-1, mips_tb);
end

endmodule