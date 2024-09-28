module upcount_4bit (Clear, Press_button, Q);
	
	input Press_button, Clear;
	
	output reg [3:0] Q;
	
	always @(posedge Press_button) 
		if (Clear)
			Q <= 0;
		else
			Q <= Q + 1;
		
endmodule