module decALU (I, ALU);

	input [0:10] I;
	output reg [2:0] ALU;
	
	always @(I) 
		case (I)
			11'b00100000000: ALU = 3'b000;
			11'b00010000000: ALU = 3'b001;
			11'b00001000000: ALU = 3'b010;
			11'b00000100000: ALU = 3'b011;
			11'b00000010000: ALU = 3'b100;
			11'b00000001000: ALU = 3'b101;
			11'b00000000100: ALU = 3'b110;
			11'b00000000010: ALU = 3'b111;
			default: ALU = 3'b000;
		endcase
		
endmodule
		

