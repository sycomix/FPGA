`timescale 1 ps/ 1 ps
module testbench
(); 

reg clk;
reg rst;

datapath_and_controller MIPS(
  .clk(clk)
, .rst(rst)
);

always
  #5 clk = ~clk;

initial 
  begin

    $display("Start programm");
    clk = 0; @(posedge clk);
    rst = 1; @(posedge clk);
    rst = 0; @(posedge clk);

    repeat(35) @(posedge clk); $finish;   

  end

initial
begin
    $dumpfile("testbench.vcd");
    $dumpvars(0,testbench);
    $display("finish");
end 

endmodule