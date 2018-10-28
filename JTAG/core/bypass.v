module bypass
(
    input      TCK
,   input      TDI
,   input      TAP_RST
,   input      SHIFTDR
,   output reg BYPASS_TDO
);

reg BYPASS;

always @(posedge TCK) begin
    if ( !TAP_RST ) begin
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