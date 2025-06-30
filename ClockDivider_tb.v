/* ClockDivider_tb.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A ClockDivider testbench module
*
* Inputs:
* CLK_50MHz - The 50 MHz clock signal
* reset_n - The reset signal that is active when low
*
* Output:
* CLK_100Hz - The 100 Hz output clock signal 
*
*/
`timescale 1 ns/100 ps
module ClockDivider_tb;
	reg CLK_50MHz;
	reg reset_n;
	wire CLK_100Hz;

		always begin
			#10;
			CLK_50MHz <= ~CLK_50MHz;
		end
		
		
		initial begin
			
			CLK_50MHz <= 1'b0;
			reset_n = 1'b0;
			#10
			reset_n = 1'b1;
			#11000000
			reset_n = 1'b0;
			#40
			$stop;
		
		end
		
		ClockDivider dut(
			CLK_50MHz,
			reset_n,
			CLK_100Hz
		);

endmodule