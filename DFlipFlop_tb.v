/* DFlipFlop_tb.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A D latch flip flop testbench module
*
* Inputs:
* clk - The clock signal
* D - The data signal
* reset_n - The reset signal that is active when low
*
* Output:
* Q - The divided output clock signal 
*
*/
`timescale 1 ns / 100 ps
module DFlipFlop_tb;
    reg D;
    reg clk;
    reg reset;
    wire Q;
 
	always begin
			#10;
			clk <= ~clk;
	end
	
	initial begin
			
			clk <= 1'b0;
			reset = 1'b0;
			#20
			reset = 1'b1;
			D = 1'b1;
			#20
			D = 1'b0;
			#20
			D = 1'b1;
			#20
			D = 1'b0;
			#20
			D = 1'b1;
			#20
			D = 1'b1;
			#20
			D = 1'b1;
			#20
			D = 1'b0;
			#20
			D = 1'b1;
			#20
			D = 1'b0;
			#20
			reset = 1'b0;
			#20
			$stop;
		
		end
		
		DFlipFlop dut(
			clk,
			D,
			reset,
			Q
		);
     
endmodule