`timescale 1 ns / 1 ns
module top_module_tb
#(
   parameter DEFAULT = 32
);

reg clk, rst;

top_module #(
   .DEFAULT( DEFAULT ) 
) top_module_sample
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
  // code... 
    @(negedge rst);
    $finish;
end

initial begin
  $dumpfile("top_module_tb.vcd");
   $dumpvars(-1, top_module_tb);
end

endmodule