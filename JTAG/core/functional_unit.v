module functional_unit
(
    input            clk         
,   input            TLR         
,   input      [3:0] X           
,   output     [3:0] Yin         
);

reg [3:0] state;
localparam STATE_0 = 4'b0000; 
localparam STATE_1 = 4'b0001; 
localparam STATE_2 = 4'b0010; 
localparam STATE_3 = 4'b0011;
localparam STATE_4 = 4'b0100;
localparam STATE_5 = 4'b0101;
localparam STATE_6 = 4'b0110;
localparam STATE_7 = 4'b0111;
localparam STATE_8 = 4'b1000;
localparam STATE_9 = 4'b1001;
localparam STATE_A = 4'b1010;
localparam STATE_B = 4'b1011;
localparam STATE_C = 4'b1100;
localparam STATE_D = 4'b1101;
localparam STATE_E = 4'b1110;
localparam STATE_F = 4'b1111;

always @ (posedge clk) begin
	if (TLR) begin
		state <= STATE_0;
	end else begin
		case(state)
			STATE_0: begin
				if ( X == 4'b0010 )                 state <= STATE_1;
				if ( {X[3], X[2], X[0]} == 3'b100 ) state <= STATE_6;
				if ( X == 4'b1111 )                 state <= STATE_D;
			end
			STATE_1: begin
				if ( {X[3], X[2]} == 2'b01 )        state <= STATE_0;
				if ( {X[3], X[2], X[1]} == 3'b101 ) state <= STATE_3;
				if ( X == 4'b0010 )                 state <= STATE_B;
			end
			STATE_2: begin
				if ( X == 4'b1011 )                 state <= STATE_1;
				if ( X == 4'b1111 )                 state <= STATE_6;
				if ( {X[3], X[2]} == 2'b00 )        state <= STATE_9;
				if ( X == 4'b1100 )                 state <= STATE_E;
			end
			STATE_3: begin
				if ( X == 4'b1110 )                 state <= STATE_2;
				if ( X == 4'b1010 )                 state <= STATE_4;
				if ( X == 4'b0110 )                 state <= STATE_D;
			end
			STATE_4: begin
				if ( X == 4'b1111 )                 state <= STATE_1;
				if ( X == 4'b0001 )                 state <= STATE_7;
				if ( X == 4'b1110 )                 state <= STATE_9;
				if ( {X[3], X[2], X[0]} == 3'b011 ) state <= STATE_C;
			end
			STATE_5: begin
				if ( X == 4'b1100 )                 state <= STATE_0;
				if ( X == 4'b0011 )                 state <= STATE_2;
				if ( X == 4'b1111 )                 state <= STATE_4;
				if ( X == 4'b0010 )                 state <= STATE_8;
				if ( X == 4'b1101 )                 state <= STATE_D;
			end
			STATE_6: begin
				if ( X == 4'b0000 )                 state <= STATE_2;
				if ( X == 4'b0001 )                 state <= STATE_5;
				if ( {X[3], X[2], X[1]} == 3'b001 ) state <= STATE_9;
				if ( {X[3], X[2], X[1]} == 3'b111 ) state <= STATE_C;
			end
			STATE_7: begin
				if ( X == 4'b0000 )                 state <= STATE_0;
				if ( {X[3], X[2], X[0]} == 3'b110 ) state <= STATE_2;
				if ( X == 4'b0101 )                 state <= STATE_5;
				if ( X == 4'b0011 )                 state <= STATE_A;
				if ( {X[3], X[2], X[0]} == 3'b111 ) state <= STATE_9;
			end
			STATE_8: begin
				if ( {X[3], X[2], X[1]} == 3'b110 ) state <= STATE_3;
				if ( {X[3], X[2], X[0]} == 3'b001 ) state <= STATE_7;
				if ( X == 4'b1111 )                 state <= STATE_B;
			end
			STATE_9: begin
				if ( X == 4'b0000 )                 state <= STATE_4;
				if ( X == 4'b0001 )                 state <= STATE_7;
				if ( X == 4'b1110 )                 state <= STATE_C;
				if ( X == 4'b1011 )                 state <= STATE_E;
			end
			STATE_A: begin
				if ( X == 4'b0011 )                 state <= STATE_2;
				if ( X == 4'b1111 )                 state <= STATE_5;
				if ( X == 4'b1010 )                 state <= STATE_8;
				if ( X == 4'b0001 )                 state <= STATE_D;
			end
			STATE_B: begin
				if ( X == 4'b1010 )                 state <= STATE_1;
				if ( {X[3], X[2], X[1]} == 3'b110 ) state <= STATE_8;
				if ( X == 4'b1110 )                 state <= STATE_C;
				if ( X == 4'b1001 )                 state <= STATE_E;
			end
			STATE_C: begin
				if ( X == 4'b1110 )                 state <= STATE_2;
				if ( X == 4'b1001 )                 state <= STATE_6;
				if ( {X[3], X[2], X[1]} == 3'b101 ) state <= STATE_9;
				if ( X == 4'b0010 )                 state <= STATE_E;
			end
			STATE_D: begin
				if ( X == 4'b0101 )                 state <= STATE_1;
				if ( X == 4'b1001 )                 state <= STATE_2;
				if ( {X[1], X[0]} == 2'b10 )        state <= STATE_5;
				if ( X == 4'b1111 )                 state <= STATE_9;
			end
			STATE_E: begin
				if ( X == 4'b1111 )                 state <= STATE_1;
				if ( {X[2], X[1], X[0]} == 3'b101 ) state <= STATE_4;				
				if ( X == 4'b1100 )                 state <= STATE_7;
			end
			STATE_F: begin
				if ( X == 4'b1100 )                 state <= STATE_3;
				if ( X == 4'b1010 )                 state <= STATE_7;				
				if ( X == 4'b0000 )                 state <= STATE_A;
				if ( {X[3], X[2]} == 2'b01 )        state <= STATE_C;
			end
			default:                                state <= STATE_0;
		endcase
	end
end

assign Yin = state;

endmodule