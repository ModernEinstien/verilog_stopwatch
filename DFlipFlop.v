/* DFlipFlop.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A D latch flip flop module
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
module DFlipFlop(
	input clk,
	input D,
	input reset,
	output reg Q
);

	always @ (posedge clk or negedge reset)
	begin
	
		if (~reset)
		begin
			  Q <= 1'b0;
		end
		else begin
			  Q <= D;
		end
		
	end

endmodule