/* Stopwatch.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A Stopwatch module - uses ClockDivider, StopwatchLogic and SevenSegEncoder to make a stopwatch
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
module Stopwatch(
	input CLK_50MHz,
	input reset_n,
	input start_stop,
	input hold,
	output [6:0] ten_mins_seven_seg,
	output [6:0] one_min_seven_seg,
	output [6:0] ten_secs_seven_seg,
	output [6:0] one_sec_seven_seg,
	output [6:0] tenths_seven_seg,
	output [6:0] hundredths_seven_seg,
	output CLK_ind,
	output overflow_flag
);
	wire CLK_100Hz;
	wire [6:0] stopwatch_unit_mins;
	wire [5:0] stopwatch_unit_secs;
	wire [6:0] stopwatch_unit_decs;

	ClockDivider clkdivider(
		CLK_50MHz,
		reset_n,
		CLK_100Hz
	);
	
	StopwatchLogic stopwatchlogic(
		CLK_100Hz,
		reset_n,
		start_stop,
		hold,
		stopwatch_unit_mins,
		stopwatch_unit_secs,
		stopwatch_unit_decs,
		overflow_flag
	);
	
	SevenSegEncoder sevensegencoder(
		stopwatch_unit_mins,
		stopwatch_unit_secs,
		stopwatch_unit_decs,
		ten_mins_seven_seg,
		one_min_seven_seg,
		ten_secs_seven_seg,
		one_sec_seven_seg,
		tenths_seven_seg,
		hundredths_seven_seg
	);
	
	assign CLK_ind = CLK_100Hz;


endmodule
