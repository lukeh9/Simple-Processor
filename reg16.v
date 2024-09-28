module reg16 (R, L, Clock, Q);
	input [15:0] R;
	input L, Clock;
	
	output reg [15:0] Q;
	
	always @(posedge Clock) 
		if (L)
			Q <= R;
			
endmodule