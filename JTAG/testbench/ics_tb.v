`timescale 1 ns / 1 ns
module ics_tb();

reg  TMS;
reg  TCK;
reg  TRST;
reg  TDI;
wire TDO;

localparam BYPASS   = 4'hF;
localparam SAMPLE   = 4'h1;
localparam EXTEST   = 4'h2;
localparam INTEST   = 4'h3; 
localparam RUNBIST  = 4'h4;
localparam CLAMP    = 4'h5;
localparam IDCODE   = 4'h7;
localparam USERCODE = 4'h8;
localparam HIGHZ    = 4'h9;

ics ics_sample
( 
  .TMS(TMS)
, .TCK(TCK)
//, .TRST(TRST)
, .TDI(TDI)
, .TDO(TDO)
);

reg        clk;
reg  [3:0] X;
wire [3:0] Yin;

functional_unit fu
(
  .clk(clk)
, .TLR(TRST)
, .X(X)
, .Yin(Yin)
);

always begin
   #10  TCK <= ~TCK; // 20MHz
end

always begin
   #5  clk <= ~clk; // 200MHz
end

initial begin
   TCK = 0; clk = 0; TMS = 1; TRST = 0; TDI = 0; @(posedge TCK);
   TRST = 1;                                     @(posedge TCK);
   TRST = 0;                                     @(posedge TCK);
end  

task command;
  input [3:0] cmd;
  begin
    TMS = 0; repeat(1) @(negedge TCK); // Run Test IDLE <- C
    TMS = 1; @(negedge TCK); // Select DR_Scan <- 7
    TMS = 1; @(negedge TCK); // Select IR_Scan <- 4
    TMS = 0; @(negedge TCK); // Capture_IR <- E
    TMS = 0; @(negedge TCK); // SHIFT_IR <- A 

      TDI = cmd[0]; TMS = 0; @(negedge TCK); // SHIFT_IR <- A
      TDI = cmd[1]; TMS = 0; @(negedge TCK); // SHIFT_IR <- A
      TDI = cmd[2]; TMS = 0; @(negedge TCK); // SHIFT_IR <- A
      TDI = cmd[3]; TMS = 1; @(negedge TCK); // EXIT1_IR <- 9

    TDI = 0; TMS = 1; @(negedge TCK); // UPDATE_IR <- D
    TMS = 0; @(negedge TCK); // Run Test IDLE <- C
    TMS = 0; @(negedge TCK); // Run Test IDLE <- C
    TMS = 0; @(negedge TCK); // Run Test IDLE <- C
  end 
endtask

task data;
  input [7:0] data;
  begin
    TMS = 1; @(negedge TCK); // Select_DR_Scan <- 7
    TMS = 0; @(negedge TCK); // Capture_DR <- 7
    TMS = 0; @(negedge TCK); // Shidt_DR <- 2

      // For LBS
      TDI = 0; TMS = 0; @(negedge TCK); // Shidt_DR <- 2
      TDI = 0; TMS = 0; @(negedge TCK); // Shidt_DR <- 2

      TDI = data[0]; TMS = 0; @(negedge TCK); // Shidt_DR <- 2
      TDI = data[1]; TMS = 0; @(negedge TCK); // Shidt_DR <- 2
      TDI = data[2]; TMS = 0; @(negedge TCK); // Shidt_DR <- 2
      TDI = data[3]; TMS = 0; @(negedge TCK); // Shidt_DR <- 2

      TDI = data[4]; TMS = 0; @(negedge TCK); // Shidt_DR <- 2
      TDI = data[5]; TMS = 0; @(negedge TCK); // Shidt_DR <- 2
      TDI = data[6]; TMS = 0; @(negedge TCK); // Shidt_DR <- 2
      TDI = data[7]; TMS = 1; @(negedge TCK); // EXIT1_DR <- 2

      TDI = 0; TMS = 0; @(negedge TCK); // PAUSE_DR <- 3
      TDI = 0; TMS = 0; @(negedge TCK); // PAUSE_DR <- 3
      TDI = 0; TMS = 0; @(negedge TCK); // PAUSE_DR <- 3
      TDI = 0; TMS = 0; @(negedge TCK); // PAUSE_DR <- 3

    TMS = 1; @(negedge TCK); // EXIT2_DR  <- 0
    TMS = 1; @(negedge TCK); // UPDATE_DR <- 5
    TMS = 0; @(negedge TCK); // RUN_TEST_IDLE <- C
    TMS = 0; @(negedge TCK); // RUN_TEST_IDLE <- C
    TMS = 0; @(negedge TCK); // RUN_TEST_IDLE <- C
  end 
endtask

task assert;
  input [3:0] a;
  input [3:0] b;
  begin
    if ( !(a === b) ) begin
      $display("ASSERT FAIL: %h === %h", a, b);
      $finish(2);
    end
  end
endtask

localparam STATE_0 = 4'b0000; 
localparam STATE_1 = 4'b0001; 
localparam STATE_2 = 4'b0010; 
localparam STATE_3 = 4'b0011;
localparam STATE_4 = 4'b0100;
localparam STATE_5 = 4'b0101;
localparam STATE_6 = 4'b0110;
localparam STATE_7 = 4'b0111;
localparam STATE_8 = 4'b1000;
localparam STATE_9 = 4'b1001;
localparam STATE_A = 4'b1010;
localparam STATE_B = 4'b1011;
localparam STATE_C = 4'b1100;
localparam STATE_D = 4'b1101;
localparam STATE_E = 4'b1110;
localparam STATE_F = 4'b1111;

initial begin

  @(negedge TRST); @(posedge clk); 

  X <= 4'b0010; @(posedge clk); assert(Yin, STATE_1);
  X <= 4'b0010; @(posedge clk); assert(Yin, STATE_B);
  X <= 4'b1100; @(posedge clk); assert(Yin, STATE_8);
  X <= 4'b1111; @(posedge clk); assert(Yin, STATE_B);
  X <= 4'b1110; @(posedge clk); assert(Yin, STATE_C);
  X <= 4'b1110; @(posedge clk); assert(Yin, STATE_2);
  X <= 4'b0000; @(posedge clk); assert(Yin, STATE_9);
  X <= 4'b0000; @(posedge clk); assert(Yin, STATE_4);
  X <= 4'b0111; @(posedge clk); assert(Yin, STATE_C);
  X <= 4'b0010; @(posedge clk); assert(Yin, STATE_E);

end

initial begin

  repeat(5) @(negedge TCK); // Test Logic Reset <- F

  command(IDCODE); data(8'hAD);
  
  repeat(100) @(posedge TCK); $finish;
end

initial begin
  $dumpfile("ics_tb.vcd");
  $dumpvars(-1, ics_tb);
end

endmodule