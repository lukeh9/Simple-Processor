module regn (R, L, Clock, Q);
 	parameter n = 8;
	input [n - 1:0] R;
	input L, Clock;
	
	output reg [n - 1:0] Q;
	
	initial begin
		Q = 0;
	end
	
	always @(posedge Clock) 
		if (L)
			Q <= R;
			
endmodule