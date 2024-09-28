module program_counter (start, Clock, Q); 

	input Clock, start;
	output reg [1:0] Q;
	reg hold;
	reg [3:0] count;
	
	initial begin
		Q = 2'b00;
		hold = 1'b0;
		count = 4'b0000;
	end
	
	always @( posedge Clock ) begin
	
		if ( (hold == 1'b0) && (start == 1'b1) ) begin
			hold <= 1'b1;
			Q <= 2'b00;
			count <= 4'b0000;
		end
		
		else if (hold == 1'b1) begin
			case (count)
				4'b0000 : begin count = 4'b0001 ; Q = 2'b00 ; hold = 1'b1 ; end // First Clk for MOV
				4'b0001 : begin count = 4'b0010 ; Q = 2'b01 ; hold = 1'b1 ; end // 2nd clk; change to 2nd ROM func
				4'b0010 : begin count = 4'b0011 ; Q = 2'b01 ; hold = 1'b1 ; end // 3rd clk 
				4'b0011 : begin count = 4'b0100 ; Q = 2'b01 ; hold = 1'b1 ; end
				4'b0100 : begin count = 4'b0101 ; Q = 2'b01 ; hold = 1'b1 ; end
				4'b0101 : begin count = 4'b0110 ; Q = 2'b10 ; hold = 1'b1 ; end
				4'b0110 : begin count = 4'b0111 ; Q = 2'b10 ; hold = 1'b1 ; end
				4'b0111 : begin count = 4'b1000 ; Q = 2'b10 ; hold = 1'b1 ; end
				4'b1000 : begin count = 4'b1001 ; Q = 2'b10 ; hold = 1'b1 ; end
				4'b1001 : begin count = 4'b1010 ; Q = 2'b11 ; hold = 1'b1 ; end
				4'b1010 : begin count = 4'b1011 ; Q = 2'b11 ; hold = 1'b1 ; end
				4'b1011 : begin count = 4'b1100 ; Q = 2'b11 ; hold = 1'b1 ; end
				4'b1100 : begin count = 4'b1101 ; Q = 2'b11 ; hold = 1'b1 ; end
				4'b1101 : begin count = 4'b1110 ; Q = 2'b11 ; hold = 1'b1 ; end
				4'b1110 : begin count = 4'b0000 ; Q = 2'b00 ; hold = 1'b0 ; end
				default : begin count = 4'b0000 ; Q = 2'b00 ; hold = 1'b0 ; end
			endcase
		end
	end
		
endmodule