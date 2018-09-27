module register_file
#(
    parameter WORD_SIZE = 32
,   parameter ADDRES    = $clog2(WORD_SIZE)
)
(
    // Default interface
     input                     clk
    // Read data
,    input  [ADDRES-1:0]       addres_reg_1                   
,    input  [ADDRES-1:0]       addres_reg_2
,    output [WORD_SIZE-1:0]    data_reg_1
,    output [WORD_SIZE-1:0]    data_reg_2
    // Write data
,    input                     signal_we
,    input   [ADDRES-1:0]      addres_write
,    input   [WORD_SIZE-1:0]   data_write
); 

reg [WORD_SIZE-1:0] registers [32 - 1:0];

always @(posedge clk) begin
    registers[0] <= 32'h00000000;
end

always @(posedge clk) begin
   if ( signal_we ) begin
        registers[addres_write] <= data_write;
   end 
end

assign data_reg_1 = addres_reg_1 ? registers[addres_reg_1] : registers[0];
assign data_reg_2 = addres_reg_2 ? registers[addres_reg_2] : registers[0];

endmodule