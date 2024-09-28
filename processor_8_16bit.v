module processor_8_16bit (Data, Reset, w, Clock, Func, Done, R0, R1, R2, R3, R4, R5, R6, R7); 

	input [7:0] Data;
	input Reset, w, Clock;
	input [9:0] Func;

	wire [15:0] BusWires; 
	wire [7:0] DataReg;
	output Done;

	reg [0:7] Rin, Rout;
	reg [15:0] ALU_out;
	reg [9:0] Func_MUX;

	wire Clear, Extern, Ain, Gin, Gout, FRin, Datain, ROMsel, Start_ROM; 
	wire [2:0] ALU;
	wire [1:0] Count;
	wire [0:3] T;
	wire [0:10] I;
	wire [0:7] Xreg, Y;
	output wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
	wire [15:0] A, G;
	wire [9:0] FuncReg, FuncOUT; 
	wire [1:0] PCtoROM;
	wire [9:0] ROM_out;

	integer k;
	
	initial begin
		Func_MUX = 10'b0000000000;
	end
	
	upcount counter (Clear, Clock, Count);
	
	dec2to4 decT (Count, 1'b1, T);

	assign Clear = Reset | Done | ( ~w & T[0] & ~ROMsel);
	assign FRin = ( w & T[0] );
	assign Datain = ( I[0] & T[1] );
	assign Start_ROM = ( I[10] & T[0] );
	
	
	functionreg functreg (Func, FRin , Clock, ROMsel, FuncReg); 
		
	program_counter PC (Start_ROM, Clock, PCtoROM);
	
	ROM_test rom (PCtoROM, ROM_out);
		
	ROM_Timer timer (Clock, Start_ROM, ROMsel);
	
		
	always @(*) begin
		case(ROMsel)
		1'b0 : Func_MUX = FuncReg;
		1'b1 : Func_MUX = ROM_out;
		endcase
	end
	
	assign FuncOUT = Func_MUX;
	
	regn datareg (Data, Datain, Clock, DataReg);
	
	decI inst_decI (FuncOUT[9:6], I);
	
	dec3to8 decX (FuncOUT[5:3], Xreg); 
	
	dec3to8 decY (FuncOUT[2:0], Y);
	
	decALU inst_decALU (I, ALU);

	
	assign Extern = (I[0] & T[2]);
	assign Done = (I[1] & T[1]) | ((I[0] | I[2] | I[3]) & T[2]) | ((I[4] | I[5] | I[6] | I[7] | I[8] | I[9]) & T[3]) | (I[10] & T[1]) ; 
	assign Ain =  (I[4] | I[5] | I[6] | I[7] | I[8] | I[9]) & T[1] ;
	assign Gin =  ((I[2] | I[3]) & T[1]) | ((I[4] | I[5] | I[6] | I[7] | I[8] | I[9]) & T[2]) ;
	assign Gout = ((I[2] | I[3]) & T[2]) | ((I[4] | I[5] | I[6] | I[7] | I[8] | I[9]) & T[3]);
	
	
	always @(I, T, Xreg, Y)
		for(k=0 ; k< 8; k=k+1) 
		begin
			Rin[k] = ((I[0] | I[2] | I[3]) & T[2] & Xreg[k]) | (I[1] & T[1] & Xreg[k]) | ((I[4] | I[5] | I[6] | I[7] | I[8] | I[9]) & T[3] & Xreg[k]);
			Rout[k] = (I[1] & T[1] & Y[k]) | ((I[2] | I[3] | I[4] | I[5] | I[6] | I[7] | I[8] | I[9]) & T[1] & Xreg[k]) | ((I[4] | I[5] | I[6] | I[7] | I[8] | I[9]) & T[2] & Y[k]);
		end
		
	tri16 tri_ext ( {Data , DataReg} , Extern, BusWires);
	
	reg16 reg_0 (BusWires, Rin[0], Clock, R0); 
	reg16 reg_1 (BusWires, Rin[1], Clock, R1); 
	reg16 reg_2 (BusWires, Rin[2], Clock, R2); 
	reg16 reg_3 (BusWires, Rin[3], Clock, R3);
	reg16 reg_4 (BusWires, Rin[4], Clock, R4);
	reg16 reg_5 (BusWires, Rin[5], Clock, R5);
	reg16 reg_6 (BusWires, Rin[6], Clock, R6);
	reg16 reg_7 (BusWires, Rin[7], Clock, R7);
	
	tri16 tri_0 (R0, Rout[0], BusWires);
	tri16 tri_1 (R1, Rout[1], BusWires);
	tri16 tri_2 (R2, Rout[2], BusWires);
	tri16 tri_3 (R3, Rout[3], BusWires);
	tri16 tri_4 (R4, Rout[4], BusWires); 
	tri16 tri_5 (R5, Rout[5], BusWires); 
	tri16 tri_6 (R6, Rout[6], BusWires); 
	tri16 tri_7 (R7, Rout[7], BusWires); 
	
	reg16 reg_A (BusWires, Ain, Clock, A);

	// alu
	always @(ALU, A, BusWires)
		if (ALU == 3'b000) // Bitwise Reverse
			ALU_out = {BusWires[0],BusWires[1],BusWires[2],BusWires[3],BusWires[4],BusWires[5],BusWires[6],BusWires[7],BusWires[8],BusWires[9],BusWires[10],BusWires[11],BusWires[12],BusWires[13],BusWires[14],BusWires[15]};
		else if (ALU == 3'b001) // Byte Reverse
			ALU_out = {BusWires[7],BusWires[6],BusWires[5],BusWires[4],BusWires[3],BusWires[2],BusWires[1],BusWires[0],BusWires[15],BusWires[14],BusWires[13],BusWires[12],BusWires[11],BusWires[10],BusWires[9],BusWires[8]};
		else if (ALU == 3'b010) // Add
			ALU_out = A + BusWires;
		else if (ALU == 3'b011) // Sub
			ALU_out = A - BusWires;
		else if (ALU == 3'b100) // Bitwise AND
			ALU_out = A & BusWires;
		else if (ALU == 3'b101) // Bitwise OR
			ALU_out = A | BusWires;
		else if (ALU == 3'b110) // Bitwise XOR
			ALU_out = A ^ BusWires;
		else
			ALU_out = ~A;
			
			
	reg16 reg_G (ALU_out, Gin, Clock, G); 
	
	tri16 tri_G (G, Gout, BusWires);
	
	
endmodule
	