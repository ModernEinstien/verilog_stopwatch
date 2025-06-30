/* SevenSegEncoder-tb.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A SevenSegEncoder testbench module
*
* Inputs:
* stopwatch_unit_mins[6:0] - binary counter for minutes 
* stopwatch_unit_secs[5:0] - binary counter for seconds 
* stopwatch_unit_decs[6:0] - binary counter for decs
*
* Output:
* hex_10_mins[6:0] - seven-segment display format for 10 mins
* hex_1_min[6:0] - seven-segment display format for 1 min
* hex_10_secs[6:0] - seven-segment display format for 10 secs 
* hex_1_sec[6:0] - seven-segment display format for 1 sec
* hex_hundredths[6:0] - seven-segment display format for hundredths  
* hex_tenths[6:0] - seven-segment display format for tenths  
*
*/
`timescale 1 ns/100 ps
module SevenSegEncoder_tb;
	reg [6:0] stopwatch_unit_mins;
	reg [5:0] stopwatch_unit_secs;
	reg [6:0] stopwatch_unit_decs;
	wire [6:0] hex_10_mins;
	wire [6:0] hex_1_min;
	wire [6:0] hex_10_secs;
	wire [6:0] hex_1_sec;
	wire [6:0] hex_hundredths;
	wire [6:0] hex_tenths;
	
	SevenSegEncoder dut(
		stopwatch_unit_mins,
		stopwatch_unit_secs,
		stopwatch_unit_decs,
		hex_10_mins,
		hex_1_min,
		hex_10_secs,
		hex_1_sec,
		hex_hundredths,
		hex_tenths
	);
	
	integer i;
	
	initial begin
		for(i=0; i<100; i=i+1)
		begin
			{stopwatch_unit_decs} = i;
			{stopwatch_unit_secs} = i;
			{stopwatch_unit_mins} = i;
			#10;
		end
		$stop;
	end
	
endmodule