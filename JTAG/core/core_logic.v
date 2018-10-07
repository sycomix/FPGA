module core_logic
(
    input          TCK
,   input          SHIFTDR
,   input          TRST
,   output [7:0]   CORE_LOGIC_DATA
);

reg [7:0] previous, current;

always @(posedge TCK) begin
 if ( TRST ) begin
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
assign CORE_LOGIC_DATA = 8'hDD;

endmodule