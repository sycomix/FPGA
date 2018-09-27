`timescale 1 ns / 1 ns
module pc_tb
#(
   parameter WORD_SIZE = 32
);

reg clk, rst;
reg  [WORD_SIZE-1:0] pc_next;
wire [WORD_SIZE-1:0] pc;

pc #(
   .WORD_SIZE( WORD_SIZE ) 
) pc_sample
( .clk(clk)
, .rst(rst)
, .pc_next(pc_next)
, .pc(pc)
);

always begin
   #5  clk <= ~clk; // 200MHz
end

initial begin
   clk <= 0; pc_next <= 0; @(posedge clk);
   rst <= 1;               @(posedge clk);
   rst <= 0;               @(posedge clk);
end

initial begin
    @(negedge rst);
    
    @(posedge clk); pc_next <= 32'h00000000;
    @(posedge clk); pc_next <= 32'h00000004;
    @(posedge clk); pc_next <= 32'h00000008;
    @(posedge clk); pc_next <= 32'h0000000C;
    @(posedge clk); pc_next <= 32'h00000010;
    @(posedge clk); pc_next <= 32'h00000014;
    @(posedge clk); pc_next <= 32'h00000018;

    $finish;
end

initial begin
  $dumpfile("pc_tb.vcd");
   $dumpvars(-1, pc_tb);
end

endmodule