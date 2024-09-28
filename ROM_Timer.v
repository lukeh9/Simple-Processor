module ROM_Timer ( Clk, start_timer, ROMsel);

	input Clk, start_timer;
	output reg ROMsel;
	reg [3:0] count;
	reg hold;
	
	initial begin
		count = 4'b0000;
		ROMsel = 1'b0;
		hold = 1'b0;
	end
	
	
	always @(posedge Clk) begin
	
		if ((hold == 1'b0) && (start_timer == 1'b1)) begin
			hold <= 1'b1;
			count <= 4'b0000;
			ROMsel <= 1'b1;
		end
		
		else if (hold == 1'b1) begin
			if (count == 4'b1100) begin // Counting to 12 Clock Cycles
				hold <= 1'b0;
				ROMsel <= 1'b0;
			end
			
			else begin
				count <= count + 1;
			end
		end
	end 
		
endmodule