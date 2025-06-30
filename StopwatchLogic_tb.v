/* StopwatchLogic_tb.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A StopwatchLogic tesetbench module - counter for mins, secs and decs
*
* Inputs:
* CLK_100Hz - The 100 Hz clock signal
* reset_n - The reset signal that is active when low
* start_stop - The start_stop signal that is active when low
* hold - The hold signal that is active when low
*
* Output:
* stopwatch_unit_mins[6:0] - binary counter for minutes 
* stopwatch_unit_secs[5:0] - binary counter for seconds 
* stopwatch_unit_decs[6:0] - binary counter for decs 
*
*/
`timescale 1 ns/100 ps
module StopwatchLogic_tb;
	reg CLK_100Hz;
	reg reset_n;
	reg start_stop;
	reg hold;
	wire [6:0] stopwatch_unit_mins;
	wire [5:0] stopwatch_unit_secs;
	wire [6:0] stopwatch_unit_decs;
	wire stopwatch_overflow;
	
	always begin
			#10;
			CLK_100Hz <= ~CLK_100Hz;
	end
	
	initial begin
			
		CLK_100Hz <= 1'b0;
		reset_n = 1'b0;
		start_stop=1'b1;
		hold = 1'b1;
		#10
		reset_n = 1'b1;
		start_stop=1'b0;
		#1000000
		start_stop=1'b1;
		hold=1'b0;
		#1000
		hold=1'b1;
		start_stop=1'b0;
		#1000
		//reset_n = 1'b1;
		//#10000000
		$stop;
		
	end
	
	StopwatchLogic dut(
		CLK_100Hz,
		reset_n,
		start_stop,
		hold,
		stopwatch_unit_mins,
		stopwatch_unit_secs,
		stopwatch_unit_decs,
		stopwatch_overflow
	);

endmodule