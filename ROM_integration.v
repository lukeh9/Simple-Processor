module ROM_integration (Start_ROM, FuncIN, Clk, FuncOUT);

	input [9:0] FuncIN;
	input Done, Start_ROM, Clk;
	output [9:0] FuncOUT;
	
	reg [9:0] Func_MUX;
	
	wire [1:0] PCtoROM;
	wire [9:0] FuncReg, ROM_out;
	wire ROMsel;
	
	regn functionreg (FuncIN, 1'b1 , Clk, FuncReg); 
		defparam functionreg.n = 10;
		
		
	program_counter PC (Start_ROM, Clk, PCtoROM);
	
	ROM_test rom (PCtoROM, ROM_out);
		
	ROM_Timer timer (Clk, Start_ROM, ROMsel);
		
		
	always @( posedge Clk ) begin
		case(ROMsel)
		1'b0 : Func_MUX = FuncReg;
		1'b1 : Func_MUX = ROM_out;
		endcase
	end
	
	assign FuncOUT = Func_MUX;
	
	
endmodule