module tri16 (Y, E, F);
 
	input [15:0] Y; 
	input E;
	output wire [15:0] F;
	
	assign F=E?Y:'bz;
	
endmodule