/* BCDEncoder_tb.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A BCDEncoder testbench module
*
* Inputs:
* BinaryIn[7:0] - 8-bit binary value
*
* Output:
* BCDOut[11:0] - 12-bit BCD value
*
*/
`timescale 1 ns/100 ps
module BCDEncoder_tb;
	reg [7:0] BinaryIn;
	wire [11:0] BCDOut;
	
	BCDEncoder dut(
		BinaryIn,
		BCDOut
	);
	
	integer i;
	
	initial begin
		for(i=0; i<256; i=i+1)
		begin
			{BinaryIn} = i;
			#10;
		end
		$stop;
	end
	
	
	
endmodule