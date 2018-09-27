module data_memory
#(
    parameter WORD_SIZE = 32
,   parameter RAM_SIZE  = 32
)
(
    // Default interface
     input                     clk
    // Read data
,    output  [WORD_SIZE-1:0]   data_ram
    // Write data
,    input                     signal_we
,    input   [WORD_SIZE-1:0]   addres_write
,    input   [WORD_SIZE-1:0]   data_write
); 

reg [WORD_SIZE-1:0] RAM [RAM_SIZE - 1:0];

always @(posedge clk) begin
   if ( signal_we ) begin
       RAM[addres_write[WORD_SIZE-1:2]] <= data_write;
   end 
end

assign data_ram = RAM[addres_write[WORD_SIZE-1:2]];

endmodule