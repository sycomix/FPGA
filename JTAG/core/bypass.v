module bypass
(
    input      TCK
,   input      TDI
,   input      TRST
,   input      SHIFTDR
,   output reg BYPASS_TDO
);

reg BYPASS;

always @(posedge TCK or posedge TRST) begin
    if ( TRST ) begin
        BYPASS <= 1'b0;
    end else 
    if ( SHIFTDR ) begin
        BYPASS <= TDI;
    end
end

always @(negedge TCK) begin
    BYPASS_TDO <= BYPASS;
end

endmodule