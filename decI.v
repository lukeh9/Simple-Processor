module decI (count, I);

	input [3:0] count;
	output reg [0:10] I;
	
	always @(count) 
		case (count)
			4'b0000: I = 11'b10000000000;
			4'b0001: I = 11'b01000000000;
			4'b0010: I = 11'b00100000000;
			4'b0011: I = 11'b00010000000;
			4'b0100: I = 11'b00001000000;
			4'b0101: I = 11'b00000100000;
			4'b0110: I = 11'b00000010000;
			4'b0111: I = 11'b00000001000;
			4'b1000: I = 11'b00000000100;
			4'b1001: I = 11'b00000000010;
			4'b1010: I = 11'b00000000001;
			default: I = 11'b00000000000;
		endcase
			
endmodule