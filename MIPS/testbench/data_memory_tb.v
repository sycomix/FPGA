`timescale 1 ns / 1 ns
module data_memory_tb
#(
   parameter WORD_SIZE = 32
,  parameter ADDRES    = $clog2(WORD_SIZE)
);

reg clk;
wire [WORD_SIZE-1:0]   data_ram;
reg                    signal_we;
reg  [WORD_SIZE-1:0]   addres_write;
reg  [WORD_SIZE-1:0]   data_write;

data_memory #(
   .WORD_SIZE( WORD_SIZE ) 
) data_memory_sample
( .clk(clk)
, .data_ram(data_ram)
, .signal_we(signal_we)
, .addres_write(addres_write)
, .data_write(data_write)
);

task display_buffers;
  integer i;
  begin
    $display("--------------------------------------------");
    for ( i = 0; i < WORD_SIZE; i = i + 1 ) begin
      $display("RAM[%d] = %h", i, data_memory_sample.RAM[i]);
    end
  end 
endtask

always begin
   #5  clk <= ~clk; // 200MHz
end

initial begin
   clk <= 0; @(posedge clk);
end

initial begin

  @(posedge clk);
  signal_we    <= 1;
  addres_write <= 32'h00000000;
  data_write   <= 32'h00000001;

  @(posedge clk); 
  signal_we    <= 1;
  addres_write <= 32'h00000004;
  data_write   <= 32'h00000010;

  @(posedge clk); 
  signal_we    <= 1;
  addres_write <= 32'h00000008;
  data_write   <= 32'h00000100;

  @(posedge clk); 
  signal_we    <= 1;
  addres_write <= 32'h0000000C;
  data_write   <= 32'h00001000;

  repeat(2) @(posedge clk); display_buffers(); $finish;
end

initial begin
  $dumpfile("data_memory_tb.vcd");
   $dumpvars(-1, data_memory_tb);
end

endmodule