`timescale 1 ns / 1 ns
module tar_controller_tb();

reg TDI;
reg TDO;
reg TMS;
reg TCK;
reg TRST;

tar_controller tar_controller_sample
( .TDI(TDI)
, .TDO(TDO)
, .TMS(TMS)
, .TCK(TCK)
, .TRST(TRST)
);

always begin
   #5  TCK <= ~TCK; // 200MHz
end

initial begin
   TCK <= 0; TMS = 0; @(posedge TCK);
   TRST <= 1;          @(posedge TCK);
   TRST <= 0;          @(posedge TCK);
end

initial begin

  @(negedge TRST)  TMS = 1; // <- STATE_TEST_LOGIC_RESET
  @(posedge TCK);  TMS = 0; // <- STATE_RUN_TEST_IDLE
  repeat(2) @(posedge TCK); // <- STATE_RUN_TEST_IDLE
  @(posedge TCK);  TMS = 1;

  repeat(10) @(posedge TCK); $finish;
end

initial begin
  $dumpfile("tar_controller_tb.vcd");
  $dumpvars(-1, tar_controller_tb);
end

endmodule