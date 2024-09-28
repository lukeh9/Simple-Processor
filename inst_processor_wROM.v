module inst_processor_wROM (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX5);
	
	input [9:0] SW;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX5;
	output LEDR;
	
	wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
	
	wire [2:0] disp_count;
	
	reg [3:0] t1, t2, t3, t4;
	
	processor_8_16bit inst_proc ( .Data(SW[7:0]), .Reset(KEY[0]), .w(KEY[1]), .Clock(KEY[2]), .Func(SW[9:0]), .Done(LEDR), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7));
	
	upcount_3bit display_counter ( .Clear(KEY[0]) , .Press_button(KEY[3]) , .Q(disp_count));
	
	always @(disp_count, R0, R1, R2, R3, R4, R5, R6, R7) begin
		if (disp_count == 3'b000) begin
			t1 <= R0[3:0];
			t2 <= R0[7:4];
			t3 <= R0[11:8];
			t4 <= R0[15:12];
		end else if (disp_count == 3'b001) begin
			t1 <= R1[3:0];
			t2 <= R1[7:4];
			t3 <= R1[11:8];
			t4 <= R1[15:12];
		end else if (disp_count == 3'b010) begin
			t1 <= R2[3:0];
			t2 <= R2[7:4];
			t3 <= R2[11:8];
			t4 <= R2[15:12];
		end else if (disp_count == 3'b011) begin
			t1 <= R3[3:0];
			t2 <= R3[7:4];
			t3 <= R3[11:8];
			t4 <= R3[15:12];
		end else if (disp_count == 3'b100) begin
			t1 <= R4[3:0];
			t2 <= R4[7:4];
			t3 <= R4[11:8];
			t4 <= R4[15:12];
		end else if (disp_count == 3'b101) begin
			t1 <= R5[3:0];
			t2 <= R5[7:4];
			t3 <= R5[11:8];
			t4 <= R5[15:12];
		end else if (disp_count == 3'b110) begin
			t1 <= R6[3:0];
			t2 <= R6[7:4];
			t3 <= R6[11:8];
			t4 <= R6[15:12];
		end else begin
			t1 <= R7[3:0];
			t2 <= R7[7:4];
			t3 <= R7[11:8];
			t4 <= R7[15:12];
		end
	end
	
	binary_to_7Seg seg_lowlow ( .binary(t1), .sevenSeg(HEX0) );
	
	binary_to_7Seg seg_low ( .binary(t2), .sevenSeg(HEX1) );

	binary_to_7Seg seg_high ( .binary(t3), .sevenSeg(HEX2) );
	
	binary_to_7Seg seg_highhigh ( .binary(t4), .sevenSeg(HEX3) );
	
	binary_to_7Seg seg_display ( .binary({1'b0 , disp_count}), .sevenSeg(HEX5) );
	
endmodule