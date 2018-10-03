module ir
(
	input            rst
,   input            TDI
,	input	         UPDATEIR
,	input	         CLOCKIR
,	input	         SHIFTIR
,	output reg [3:0] JTAG_IR
,   input      [3:0] state
);

// State assignments for example TAP controller
localparam STATE_TEST_LOGIC_RESET = 4'hF;
localparam STATE_RUN_TEST_IDLE    = 4'hC;
localparam STATE_SELECT_DR_SCAN   = 4'h7;
localparam STATE_CAPTURE_DR       = 4'h6;
localparam STATE_SHIFT_DR         = 4'h2;
localparam STATE_EXIT1_DR         = 4'h1;
localparam STATE_PAUSE_DR         = 4'h3;
localparam STATE_EXIT2_DR         = 4'h0;
localparam STATE_UPDATE_DR        = 4'h5;
localparam STATE_SELECT_IR_SCAN   = 4'h4;
localparam STATE_CAPTURE_IR       = 4'hE;
localparam STATE_SHIFT_IR         = 4'hA;
localparam STATE_EXIT1_IR         = 4'h9;
localparam STATE_PAUSE_IR         = 4'hB;
localparam STATE_EXIT2_IR         = 4'h8;
localparam STATE_UPDATE_IR        = 4'hD;

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

always @(posedge CLOCKIR) begin
    case(state)
        STATE_TEST_LOGIC_RESET:begin JTAG_IR <= IDCODE; end
    endcase
end	

endmodule