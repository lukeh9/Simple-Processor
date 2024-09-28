`timescale 1ns / 1ps

// iverilog -o TestROM_dumpfile.vvp ROM_TB.v ROM_integration.v ROM_test.v ROM_Timer.v program_counter.v regn.v
// vvp TestROM_dumpfile.vvp


module ROM_TB;
	
	reg [5:0] count;
	reg [9:0] fun;
	reg Start_ROM, Reset, Clk;
	wire [9:0] FuncOUT;
	
	ROM_integration ROM ( Start_ROM, fun, Clk, FuncOUT);
	
	initial begin 
		count = 6'b000000;
		Start_ROM = 1'b0;
		Clk = 1'b0;
		fun = 10'b0000000000;
	end
	
	always begin
		#50
		count=count+4'b0001;
	end

	
	always @(count) begin
		case (count)
		// Reset System
		6'b000000 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b000001 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b000010 : begin Clk = 1'b0 ; Start_ROM = 1'b1 ; fun = 10'b0000000000 ; end
		6'b000011 : begin Clk = 1'b1 ; Start_ROM = 1'b1 ; fun = 10'b0000000000 ; end
		6'b000100 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b000101 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b000110 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b000111 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001000 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001001 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001010 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001011 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001100 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001101 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001110 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b001111 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010000 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010001 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010010 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010011 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010100 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010101 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010110 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b010111 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011000 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011001 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011010 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011011 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011100 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011101 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011110 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b011111 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b100000 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b100001 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b100010 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b100011 : begin Clk = 1'b1 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		6'b100100 : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
		default : begin Clk = 1'b0 ; Start_ROM = 1'b0 ; fun = 10'b0000000000 ; end
	endcase
	end
	
	initial begin
		$dumpfile("TestROM_dumpfile.vcd");
		$dumpvars(0, ROM_TB);
		#3200
		$finish;
	end 

 
endmodule
