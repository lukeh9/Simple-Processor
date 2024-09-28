module upcount_test (Clear, Clock, Q); 

	input Clear, Clock;
	output reg [1:0] Q;
	
	initial begin
		Q = 2'b00;
	end
	
	always @(posedge Clock or posedge Clear) begin
		if (Clear == 1'b1)
			Q <= 2'b00;
		else
			case (Q) 
				2'b00 : begin Q <= 2'b01 ; end
				2'b01 : begin Q <= 2'b10 ; end
				2'b10 : begin Q <= 2'b11 ; end
				default : begin Q <= 2'b00 ; end
			endcase
	end
		
endmodule