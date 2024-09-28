module functionreg (R, L, Clock, romsel, Q);
	input [9:0] R;
	input L, Clock, romsel;
	
	output reg [9:0] Q;
	
	initial begin
		Q = 0;
	end
	
	always @(posedge Clock) 
		if (L)
			Q <= R;
		else if (romsel)
			Q <= 10'b0000000000;
			
endmodule