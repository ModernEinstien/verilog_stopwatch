/* Stopwatch_tb.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A Stopwatch testbench module
*
* Inputs:
* CLK_50MHz - The 50 MHz clock signal
* reset_n - The reset signal that is active when low
* start_stop - The start_stop signal that is active when low
* hold - The hold signal that is active when low
*
* Output:
* hex_10_mins[6:0] - seven-segment display format for 10 mins
* hex_1_min[6:0] - seven-segment display format for 1 min
* hex_10_secs[6:0] - seven-segment display format for 10 secs 
* hex_1_sec[6:0] - seven-segment display format for 1 sec
* hex_hundredths[6:0] - seven-segment display format for hundredths  
* hex_tenths[6:0] - seven-segment display format for tenths  
* CLK_ind - The 100 Hz clock signal
* overflow_flag - flags when 99:59:99 has been exceeded
*
*/
`timescale 1 ns/100 ps
module Stopwatch_tb;
	reg CLK_50MHz;
	reg reset_n;
	reg start_stop;
	reg hold;
	wire [6:0] ten_mins_seven_seg;
	wire [6:0] one_min_seven_seg;
	wire [6:0] ten_secs_seven_seg;
	wire [6:0] one_sec_seven_seg;
	wire [6:0] tenths_seven_seg;
	wire [6:0] hundredths_seven_seg;
	wire CLK_ind;
	wire overflow_flag;
	
	
	
	always begin
			#10;
			CLK_50MHz <= ~CLK_50MHz;
	end
	
	integer i;
		
	initial begin
		CLK_50MHz <= 1'b0;
		#10
		
	
		for(i=0; i<8; i = i + 1)
		begin
			{reset_n, start_stop, hold} = i;
			#20;
		end
		
		reset_n = 1'b1;
		start_stop = 1'b0;
		#10
		start_stop = 1'b1;
		#1000000000
		reset_n = 1'b0;
		#20
		reset_n = 1'b1;
		start_stop = 1'b0;
		#20
		start_stop = 1'b1;
		#500000000
		hold = 1'b0;
		#11000000
		hold = 1'b1;
		#1000
		hold = 1'b0;
		#20
		hold = 1'b1;
		start_stop = 1'b1;
		#500000000
		reset_n = 1'b0;
		#20
		reset_n = 1'b1;
		start_stop = 1'b0;
		#20
		start_stop = 1'b1;
		#20
		
		$stop;
		
	end
	
	Stopwatch dut(
		CLK_50MHz,
		reset_n,
		start_stop,
		hold,
		ten_mins_seven_seg,
		one_min_seven_seg,
		ten_secs_seven_seg,
		one_sec_seven_seg,
		tenths_seven_seg,
		hundredths_seven_seg,
		CLK_ind,
		overflow_flag
	);
		
endmodule