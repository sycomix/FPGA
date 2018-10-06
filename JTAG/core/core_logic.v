module core_logic
(
    input          TCK
,   input          SHIFTDR
,   input          rst
,   output [7:0]   CORE_LOGIC_BSR
,   output         CORE_LOGIC_TDO
);

reg [7:0] previous, current;

always @(posedge TCK) begin
 if ( rst ) begin
    previous <= 8'h00;
    current  <= 8'h01;
  end else begin
    if (!SHIFTDR) begin
        current <= current + previous;
        previous <= current;  
    end
  end
end

//assign CORE_LOGIC_BSR = current;
assign CORE_LOGIC_BSR = 8'hDD;
assign CORE_LOGIC_TDO = current[0];

endmodule