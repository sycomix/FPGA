`timescale 1 ns / 1 ns
module register_file_tb
#(
   parameter WORD_SIZE = 32
,  parameter ADDRES    = $clog2(WORD_SIZE)
);

reg                     clk;
reg  [ADDRES-1:0]       addres_reg_1;
reg  [ADDRES-1:0]       addres_reg_2;
wire [WORD_SIZE-1:0]    data_reg_1;
wire [WORD_SIZE-1:0]    data_reg_2;
reg                     signal_we;
reg  [ADDRES-1:0]       addres_write;
reg  [WORD_SIZE-1:0]    data_write;

register_file #(
   .WORD_SIZE( WORD_SIZE ) 
) register_file_sample
( .clk(clk)
, .addres_reg_1(addres_reg_1)
, .addres_reg_2(addres_reg_2)
, .data_reg_1(data_reg_1)
, .data_reg_2(data_reg_2)
, .signal_we(signal_we)
, .addres_write(addres_write)
, .data_write(data_write)
);

task display_buffers;
  integer i;
  begin
    $display("--------------------------------------------");
    for ( i = 0; i < WORD_SIZE; i = i + 1 ) begin
      $display("Reg[%d] = %h", i, register_file_sample.registers[i]);
    end
  end 
endtask

task write;
  input [WORD_SIZE-1:0] data;
  input [ADDRES-1:0] addres;
  begin
    signal_we    <= 1;
    addres_write <= addres;
    data_write   <= data;
  end 
endtask

task read_reg_1;
  input [ADDRES-1:0] addres;
  begin
    addres_reg_1 <= addres;
  end 
endtask

task read_reg_2;
  input [ADDRES-1:0] addres;
  begin
    addres_reg_2 <= addres;
  end 
endtask

always begin
   #5  clk <= ~clk; // 200MHz
end

initial begin
   clk <= 0; signal_we <= 0; @(posedge clk);
end

initial begin

    @(posedge clk); write(32'hA1B1C1D1, 1);
    @(posedge clk); write(32'hA2B2C2D2, 2);
    @(posedge clk); write(32'hA3B3C3D3, 3);
    @(posedge clk); write(32'hA4B4C4D4, 4);
    @(posedge clk); write(32'hA5B5C5D5, 5);

    @(posedge clk); signal_we <= 0;

    @(posedge clk); signal_we <= 0; read_reg_1(5'b00001); read_reg_2(5'b00010);

    // Test on write and read at one addres

    @(posedge clk); 
        write(32'hA3B3C3D3, 6);
        read_reg_1(6);

    @(posedge clk); signal_we <= 0;
    repeat(2) @(posedge clk); display_buffers(); $finish;
end

initial begin
  $dumpfile("register_file_tb.vcd");
  $dumpvars(-1, register_file_tb);
end

endmodule