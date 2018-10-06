module tar_controller
(
    // Jtag interface
    input      TMS
,   input      TCK
,   input      TRST
    // Instruction registre interface
,   output     UPDATEIR
,   output reg SHIFTIR
,   output reg CAPTUREIR
    // Test data register interface
,   output     UPDATEDR
,   output reg SHIFTDR
,   output reg CAPTUREDR
,   output reg TAP_RST
,   output     SELECT
,   output     ENABLE
);

reg UPDATEIR_TEMP;
reg UPDATEDR_TEMP;
reg [3:0] state;
// State assignments for example TAP controller
localparam STATE_TEST_LOGIC_RESET = 4'hF;
localparam STATE_RUN_TEST_IDLE    = 4'hC;
localparam STATE_SELECT_DR_SCAN   = 4'h7;
localparam STATE_CAPTURE_DR       = 4'h6;
localparam STATE_SHIFT_DR         = 4'h2; // Загрузка данных
localparam STATE_EXIT1_DR         = 4'h1;
localparam STATE_PAUSE_DR         = 4'h3;
localparam STATE_EXIT2_DR         = 4'h0;
localparam STATE_UPDATE_DR        = 4'h5;
localparam STATE_SELECT_IR_SCAN   = 4'h4;
localparam STATE_CAPTURE_IR       = 4'hE;
localparam STATE_SHIFT_IR         = 4'hA; // Загрузка комманд
localparam STATE_EXIT1_IR         = 4'h9;
localparam STATE_PAUSE_IR         = 4'hB;
localparam STATE_EXIT2_IR         = 4'h8;
localparam STATE_UPDATE_IR        = 4'hD;

always @(posedge TCK or posedge TRST) begin
    if (TRST) begin
        state <= STATE_TEST_LOGIC_RESET; 
    end else begin
        case(state)
            STATE_TEST_LOGIC_RESET: begin
                if (TMS) begin state <= STATE_TEST_LOGIC_RESET; end
                else     begin state <= STATE_RUN_TEST_IDLE;    end 
            end
            STATE_RUN_TEST_IDLE: begin
                if (TMS) begin state <= STATE_SELECT_DR_SCAN;   end
                else     begin state <= STATE_RUN_TEST_IDLE;    end 
            end
            STATE_SELECT_DR_SCAN: begin
                if (TMS) begin state <= STATE_SELECT_IR_SCAN;   end
                else     begin state <= STATE_CAPTURE_DR;       end 
            end
            STATE_CAPTURE_DR: begin
                if (TMS) begin state <= STATE_EXIT1_DR;         end
                else     begin state <= STATE_SHIFT_DR;         end
            end
            STATE_SHIFT_DR: begin
                if (TMS) begin state <= STATE_EXIT1_DR;         end
                else     begin state <= STATE_SHIFT_DR;         end
            end
            STATE_EXIT1_DR: begin
                if (TMS) begin state <= STATE_UPDATE_DR;        end
                else     begin state <= STATE_PAUSE_DR;         end
            end
            STATE_PAUSE_DR: begin
                if (TMS) begin state <= STATE_EXIT2_DR;         end
                else     begin state <= STATE_PAUSE_DR;         end
            end
            STATE_EXIT2_DR: begin
                if (TMS) begin state <= STATE_UPDATE_DR;        end
                else     begin state <= STATE_SHIFT_DR;         end
            end
            STATE_UPDATE_DR: begin
                if (TMS) begin state <= STATE_SELECT_DR_SCAN;   end
                else     begin state <= STATE_RUN_TEST_IDLE;    end
            end
            STATE_SELECT_IR_SCAN: begin
                if (TMS) begin state <= STATE_TEST_LOGIC_RESET; end
                else     begin state <= STATE_CAPTURE_IR;       end 
            end
            STATE_CAPTURE_IR: begin
                if (TMS) begin state <= STATE_EXIT1_IR;         end
                else     begin state <= STATE_SHIFT_IR;         end
            end
            STATE_SHIFT_IR: begin
                if (TMS) begin state <= STATE_EXIT1_IR;         end
                else     begin state <= STATE_SHIFT_IR;         end
            end
            STATE_EXIT1_IR: begin
                if (TMS) begin state <= STATE_UPDATE_IR;        end
                else     begin state <= STATE_PAUSE_IR;         end
            end
            STATE_PAUSE_IR: begin
                if (TMS) begin state <= STATE_EXIT2_IR;         end
                else     begin state <= STATE_PAUSE_IR;         end
            end
            STATE_EXIT2_IR: begin
                if (TMS) begin state <= STATE_UPDATE_IR;        end
                else     begin state <= STATE_SHIFT_IR;         end
            end
            STATE_UPDATE_IR: begin
                if (TMS) begin state <= STATE_SELECT_DR_SCAN;   end
                else     begin state <= STATE_RUN_TEST_IDLE;    end
            end
            default:           state <= STATE_TEST_LOGIC_RESET;
        endcase
    end
end

always @(negedge TCK) begin

    UPDATEIR_TEMP  <= 1'b0;
    SHIFTIR        <= 1'b0;
    UPDATEDR_TEMP  <= 1'b0;
    SHIFTDR        <= 1'b0;
    CAPTUREIR      <= 1'b0;
    CAPTUREDR      <= 1'b0;

    case(state)
        STATE_UPDATE_IR:  begin UPDATEIR_TEMP   <= 1'b1; end
        STATE_SHIFT_IR:   begin SHIFTIR         <= 1'b1; end
        STATE_UPDATE_DR:  begin UPDATEDR_TEMP   <= 1'b1; end
        STATE_SHIFT_DR:   begin SHIFTDR         <= 1'b1; end
        STATE_CAPTURE_DR: begin CAPTUREDR       <= 1'b1; end
        STATE_CAPTURE_IR: begin CAPTUREIR       <= 1'b1; end
    endcase
end

always @(negedge TCK) begin
    TAP_RST  = !(state == STATE_TEST_LOGIC_RESET);
end

assign UPDATEIR = UPDATEIR_TEMP && (state == STATE_UPDATE_IR);
assign UPDATEDR = UPDATEDR_TEMP && (state == STATE_UPDATE_DR);
assign ENABLE   = SHIFTDR | SHIFTIR;
assign SELECT   = state == STATE_TEST_LOGIC_RESET   
                | state == STATE_RUN_TEST_IDLE
                | state == STATE_CAPTURE_IR
                | state == STATE_SHIFT_IR
                | state == STATE_EXIT1_IR
                | state == STATE_PAUSE_IR
                | state == STATE_EXIT2_IR
                | state == STATE_UPDATE_IR
                | state == STATE_UPDATE_DR;

endmodule