module tar_controller
(
    input   TDI
,   input   TDO
,   input   TMS
,   input   TCK
,   input   TRST
);

// TAP controller state diagram / Specifications
reg [3:0] state;
localparam STATE_TEST_LOGIC_RESET = 4'b0000;
localparam STATE_RUN_TEST_IDLE    = 4'b0001;
localparam STATE_SELECT_DR_SCAN   = 4'b0010;
localparam STATE_CAPTURE_DR       = 4'b0011;
localparam STATE_SHIFT_DR         = 4'b0100;
localparam STATE_EXIT1_DR         = 4'b0101;
localparam STATE_PAUSE_DR         = 4'b0110;
localparam STATE_EXIT2_DR         = 4'b0111;
localparam STATE_UPDATE_DR        = 4'b1000;
localparam STATE_SELECT_IR_SCAN   = 4'b1001;
localparam STATE_CAPTURE_IR       = 4'b1010;
localparam STATE_SHIFT_IR         = 4'b1011;
localparam STATE_EXIT1_IR         = 4'b1100;
localparam STATE_PAUSE_IR         = 4'b1101;
localparam STATE_EXIT2_IR         = 4'b1110;
localparam STATE_UPDATE_IR        = 4'b1111;

always @(negedge TRST) begin
    state <= STATE_TEST_LOGIC_RESET;
end

always @(posedge TCK) begin
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
        end
        STATE_UPDATE_IR: begin
            if (TMS) begin state <= STATE_SELECT_DR_SCAN;   end
            else     begin state <= STATE_RUN_TEST_IDLE;    end
        end
    endcase
end

endmodule