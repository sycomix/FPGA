module debugging
#(
    parameter DEFAULT = 32
)
(
     input                   clk
,    input                   rst
,    input   [DEFAULT - 1:0] data_in
,    output  [DEFAULT - 1:0] data_out
);

always @(posedge clk) begin
 if ( rst ) begin
      
  end else begin
        
  end
end

endmodule