module state_decoder
(
    input      [3:0] LATCH_JTAG_IR

,   output reg       BYPASS_SELECT
,   output reg       SAMPLE_SELECT
,   output reg       EXTEST_SELECT
,   output reg       INTEST_SELECT
,   output reg       RUNBIST_SELECT
,   output reg       CLAMP_SELECT
,   output reg       IDCODE_SELECT
,   output reg       USERCODE_SELECT
,   output reg       HIGHZ_SELECT
);

localparam BYPASS   = 4'hF; // Обход тестовой логики
localparam SAMPLE   = 4'h1; // В стадии Capture загрузка входных данных (Normal -> 0) / PRELOAD
                            // Данные на стадии Update не попадают на ножки микросхемы
localparam EXTEST   = 4'h2; // ModeTest -> 1 Передача данных на ножки микроконтроллера
localparam INTEST   = 4'h3; 
localparam RUNBIST  = 4'h4; // Внутренняя система самотестирования
localparam CLAMP    = 4'h5; // На выходах фиксирваонное значение
localparam IDCODE   = 4'h7; // Индетефикатор производителя
localparam USERCODE = 4'h8; // Индетефикатор пользователя
localparam HIGHZ    = 4'h9; // Все выходы микросхемы в высокоомное состояние

always @(LATCH_JTAG_IR) begin

    BYPASS_SELECT   <= 1'b0;
    SAMPLE_SELECT   <= 1'b0;
    EXTEST_SELECT   <= 1'b0;
    INTEST_SELECT   <= 1'b0;
    RUNBIST_SELECT  <= 1'b0;
    CLAMP_SELECT    <= 1'b0;
    IDCODE_SELECT   <= 1'b0;
    USERCODE_SELECT <= 1'b0;
    HIGHZ_SELECT    <= 1'b0;

    case(LATCH_JTAG_IR)
        BYPASS:   begin BYPASS_SELECT   <= 1'b1; end
        SAMPLE:   begin SAMPLE_SELECT   <= 1'b1; end
        EXTEST:   begin EXTEST_SELECT   <= 1'b1; end
        INTEST:   begin INTEST_SELECT   <= 1'b1; end
        RUNBIST:  begin RUNBIST_SELECT  <= 1'b1; end
        CLAMP:    begin CLAMP_SELECT    <= 1'b1; end
        IDCODE:   begin IDCODE_SELECT   <= 1'b1; end
        USERCODE: begin USERCODE_SELECT <= 1'b1; end
        HIGHZ:    begin HIGHZ_SELECT    <= 1'b1; end
        default:  begin BYPASS_SELECT   <= 1'b1; end
    endcase
end

endmodule