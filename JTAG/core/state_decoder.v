module state_decoder
(
    input      [3:0] LATCH_JTAG_IR
,   output reg       IDCODE_SELECT
,   output reg       BYPASS_SELECT
,   output reg       SAMPLE_SELECT
,   output reg       EXTEST_SELECT
,   output reg       INTEST_SELECT
,   output reg       USERCODE_SELECT
);

localparam IDCODE       = 4'h7;
localparam BYPASS       = 4'hF;
localparam SAMPLE       = 4'h1;
localparam EXTEST       = 4'h2;
localparam INTEST       = 4'h3;
localparam USERCODE     = 4'h8;

always @(LATCH_JTAG_IR) begin

     IDCODE_SELECT     <= 1'b0;
     BYPASS_SELECT     <= 1'b0;
     SAMPLE_SELECT     <= 1'b0;
     EXTEST_SELECT     <= 1'b0;
     INTEST_SELECT     <= 1'b0;
     USERCODE_SELECT   <= 1'b0;

    case(LATCH_JTAG_IR)
          IDCODE:     begin IDCODE_SELECT     <= 1'b1; end
          BYPASS:     begin BYPASS_SELECT     <= 1'b1; end
          SAMPLE:     begin SAMPLE_SELECT     <= 1'b1; end
          EXTEST:     begin EXTEST_SELECT     <= 1'b1; end
          INTEST:     begin INTEST_SELECT     <= 1'b1; end
          USERCODE:   begin USERCODE_SELECT   <= 1'b1; end
          default:    begin IDCODE_SELECT     <= 1'b1; end
    endcase
end

endmodule