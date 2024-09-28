module upcount_3bit (Clear, Press_button, Q);
	
	input Press_button, Clear;
	
	output reg [2:0] Q;
	
	initial begin
		Q = 3'b000;
	end
	
	always @(posedge Press_button) 
		if (Clear)
			Q <= 0;
		else
			Q <= Q + 1;
		
endmodule