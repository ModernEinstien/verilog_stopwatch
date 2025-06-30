/* SevenSegEncoder.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A SevenSegEncoder module - converts binary to a format appropriate for four seven-segment displays
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
module SevenSegEncoder(
	input [6:0] stopwatch_unit_mins,
	input [5:0] stopwatch_unit_secs,
	input [6:0] stopwatch_unit_decs,
	output [6:0] hex_10_mins,
	output [6:0] hex_1_min,
	output [6:0] hex_10_secs,
	output [6:0] hex_1_sec,
	output [6:0] hex_tenths,
	output [6:0] hex_hundredths
);

	reg [6:0] reg_hex_10_mins;
	reg [6:0] reg_hex_1_min;
	reg [6:0] reg_hex_10_secs;
	reg [6:0] reg_hex_1_sec;
	reg [6:0] reg_hex_hundredths;
	reg [6:0] reg_hex_tenths;

	wire [11:0] BCD0;
	wire [11:0] BCD1;
	wire [11:0] BCD2;
	
	wire [7:0] decs;
	wire [7:0] mins;
	wire [7:0] secs;
	
	assign decs = stopwatch_unit_decs | 8'b00000000;
	assign secs = stopwatch_unit_secs | 8'b00000000;
	assign mins = stopwatch_unit_mins | 8'b00000000;
	

		BCDEncoder encoder1(
			decs,
			BCD0
		);
	 
		BCDEncoder encoder2(
			secs,
			BCD1
		);
		
		BCDEncoder encoder3(
			mins,
			BCD2
		);
		
	assign hex_hundredths[0] = ((~BCD0[3])&(~BCD0[2])&(~BCD0[1])&BCD0[0])|((~BCD0[3])&BCD0[2]&(~BCD0[1])&(~BCD0[0]));
	assign hex_hundredths[1] = ((~BCD0[3])&BCD0[2]&(~BCD0[1])&BCD0[0])|((~BCD0[3])&BCD0[2]&BCD0[1]&(~BCD0[0]));
	assign hex_hundredths[2] = ((~BCD0[3])&(~BCD0[2])&BCD0[1]&(~BCD0[0]));
	assign hex_hundredths[3] = ((~BCD0[3])&(~BCD0[2])&(~BCD0[1])&BCD0[0])|((~BCD0[3])&BCD0[2]&(~BCD0[1])&(~BCD0[0]))|((~BCD0[3])&BCD0[2]&BCD0[1]&BCD0[0]);
	assign hex_hundredths[4] = ((~BCD0[3])&(~BCD0[2])&(~BCD0[1])&BCD0[0])|((~BCD0[3])&(~BCD0[2])&BCD0[1]&BCD0[0])|((~BCD0[3])&BCD0[2]&(~BCD0[1])&(~BCD0[0]))|((~BCD0[3])&BCD0[2]&(~BCD0[1])&BCD0[0])|((~BCD0[3])&BCD0[2]&BCD0[1]&BCD0[0])|(BCD0[3]&(~BCD0[2])&(~BCD0[1])&BCD0[0]);
	assign hex_hundredths[5] = ((~BCD0[3])&(~BCD0[2])&(~BCD0[1])&BCD0[0])|((~BCD0[3])&(~BCD0[2])&BCD0[1]&(~BCD0[0]))|((~BCD0[3])&(~BCD0[2])&BCD0[1]&BCD0[0])|((~BCD0[3])&BCD0[2]&BCD0[1]&BCD0[0]);
	assign hex_hundredths[6] = ((~BCD0[3])&(~BCD0[2])&(~BCD0[1])&(~BCD0[0]))|((~BCD0[3])&(~BCD0[2])&(~BCD0[1])&BCD0[0])|((~BCD0[3])&BCD0[2]&BCD0[1]&BCD0[0]);

	assign hex_tenths[0] = ((~BCD0[7])&(~BCD0[6])&(~BCD0[5])&BCD0[4])|((~BCD0[7])&BCD0[6]&(~BCD0[5])&(~BCD0[4]));
	assign hex_tenths[1] = ((~BCD0[7])&BCD0[6]&(~BCD0[5])&BCD0[4])|((~BCD0[7])&BCD0[6]&BCD0[5]&(~BCD0[4]));
	assign hex_tenths[2] = ((~BCD0[7])&(~BCD0[6])&BCD0[5]&(~BCD0[4]));
	assign hex_tenths[3] = ((~BCD0[7])&(~BCD0[6])&(~BCD0[5])&BCD0[4])|((~BCD0[7])&BCD0[6]&(~BCD0[5])&(~BCD0[4]))|((~BCD0[7])&BCD0[6]&BCD0[5]&BCD0[4]);
	assign hex_tenths[4] = ((~BCD0[7])&(~BCD0[6])&(~BCD0[5])&BCD0[4])|((~BCD0[7])&(~BCD0[6])&BCD0[5]&BCD0[4])|((~BCD0[7])&BCD0[6]&(~BCD0[5])&(~BCD0[4]))|((~BCD0[7])&BCD0[6]&(~BCD0[5])&BCD0[4])|((~BCD0[7])&BCD0[6]&BCD0[5]&BCD0[4])|(BCD0[7]&(~BCD0[2])&(~BCD0[5])&BCD0[4]);
	assign hex_tenths[5] = ((~BCD0[7])&(~BCD0[6])&(~BCD0[5])&BCD0[4])|((~BCD0[7])&(~BCD0[6])&BCD0[5]&(~BCD0[4]))|((~BCD0[7])&(~BCD0[6])&BCD0[5]&BCD0[4])|((~BCD0[7])&BCD0[6]&BCD0[5]&BCD0[4]);
	assign hex_tenths[6] = ((~BCD0[7])&(~BCD0[6])&(~BCD0[5])&(~BCD0[4]))|((~BCD0[7])&(~BCD0[6])&(~BCD0[5])&BCD0[4])|((~BCD0[7])&BCD0[6]&BCD0[5]&BCD0[4]);
	
	assign hex_1_sec[0] = ((~BCD1[3])&(~BCD1[2])&(~BCD1[1])&BCD1[0])|((~BCD1[3])&BCD1[2]&(~BCD1[1])&(~BCD1[0]));
	assign hex_1_sec[1] = ((~BCD1[3])&BCD1[2]&(~BCD1[1])&BCD1[0])|((~BCD1[3])&BCD1[2]&BCD1[1]&(~BCD1[0]));
	assign hex_1_sec[2] = ((~BCD1[3])&(~BCD1[2])&BCD1[1]&(~BCD1[0]));
	assign hex_1_sec[3] = ((~BCD1[3])&(~BCD1[2])&(~BCD1[1])&BCD1[0])|((~BCD1[3])&BCD1[2]&(~BCD1[1])&(~BCD1[0]))|((~BCD1[3])&BCD1[2]&BCD1[1]&BCD1[0]);
	assign hex_1_sec[4] = ((~BCD1[3])&(~BCD1[2])&(~BCD1[1])&BCD1[0])|((~BCD1[3])&(~BCD1[2])&BCD1[1]&BCD1[0])|((~BCD1[3])&BCD1[2]&(~BCD1[1])&(~BCD1[0]))|((~BCD1[3])&BCD1[2]&(~BCD1[1])&BCD1[0])|((~BCD1[3])&BCD1[2]&BCD1[1]&BCD1[0])|(BCD1[3]&(~BCD1[2])&(~BCD1[1])&BCD1[0]);
	assign hex_1_sec[5] = ((~BCD1[3])&(~BCD1[2])&(~BCD1[1])&BCD1[0])|((~BCD1[3])&(~BCD1[2])&BCD1[1]&(~BCD1[0]))|((~BCD1[3])&(~BCD1[2])&BCD1[1]&BCD1[0])|((~BCD1[3])&BCD1[2]&BCD1[1]&BCD1[0]);
	assign hex_1_sec[6] = ((~BCD1[3])&(~BCD1[2])&(~BCD1[1])&(~BCD1[0]))|((~BCD1[3])&(~BCD1[2])&(~BCD1[1])&BCD1[0])|((~BCD1[3])&BCD1[2]&BCD1[1]&BCD1[0]);
	
	assign hex_10_secs[0] = ((~BCD1[7])&(~BCD1[6])&(~BCD1[5])&BCD1[4])|((~BCD1[7])&BCD1[6]&(~BCD1[5])&(~BCD1[4]));
	assign hex_10_secs[1] = ((~BCD1[7])&BCD1[6]&(~BCD1[5])&BCD1[4])|((~BCD1[7])&BCD1[6]&BCD1[5]&(~BCD1[4]));
	assign hex_10_secs[2] = ((~BCD1[7])&(~BCD1[6])&BCD1[5]&(~BCD1[4]));
	assign hex_10_secs[3] = ((~BCD1[7])&(~BCD1[6])&(~BCD1[5])&BCD1[4])|((~BCD1[7])&BCD1[6]&(~BCD1[5])&(~BCD1[4]))|((~BCD1[7])&BCD1[6]&BCD1[5]&BCD1[4]);
	assign hex_10_secs[4] = ((~BCD1[7])&(~BCD1[6])&(~BCD1[5])&BCD1[4])|((~BCD1[7])&(~BCD1[6])&BCD1[5]&BCD1[4])|((~BCD1[7])&BCD1[6]&(~BCD1[5])&(~BCD1[4]))|((~BCD1[7])&BCD1[6]&(~BCD1[5])&BCD1[4])|((~BCD1[7])&BCD1[6]&BCD1[5]&BCD1[4])|(BCD1[7]&(~BCD1[2])&(~BCD1[5])&BCD1[4]);
	assign hex_10_secs[5] = ((~BCD1[7])&(~BCD1[6])&(~BCD1[5])&BCD1[4])|((~BCD1[7])&(~BCD1[6])&BCD1[5]&(~BCD1[4]))|((~BCD1[7])&(~BCD1[6])&BCD1[5]&BCD1[4])|((~BCD1[7])&BCD1[6]&BCD1[5]&BCD1[4]);
	assign hex_10_secs[6] = ((~BCD1[7])&(~BCD1[6])&(~BCD1[5])&(~BCD1[4]))|((~BCD1[7])&(~BCD1[6])&(~BCD1[5])&BCD1[4])|((~BCD1[7])&BCD1[6]&BCD1[5]&BCD1[4]);
	
	assign hex_1_min[0] = ((~BCD2[3])&(~BCD2[2])&(~BCD2[1])&BCD2[0])|((~BCD2[3])&BCD2[2]&(~BCD2[1])&(~BCD2[0]));
	assign hex_1_min[1] = ((~BCD2[3])&BCD2[2]&(~BCD2[1])&BCD2[0])|((~BCD2[3])&BCD2[2]&BCD2[1]&(~BCD2[0]));
	assign hex_1_min[2] = ((~BCD2[3])&(~BCD2[2])&BCD2[1]&(~BCD2[0]));
	assign hex_1_min[3] = ((~BCD2[3])&(~BCD2[2])&(~BCD2[1])&BCD2[0])|((~BCD2[3])&BCD2[2]&(~BCD2[1])&(~BCD2[0]))|((~BCD2[3])&BCD2[2]&BCD2[1]&BCD2[0]);
	assign hex_1_min[4] = ((~BCD2[3])&(~BCD2[2])&(~BCD2[1])&BCD2[0])|((~BCD2[3])&(~BCD2[2])&BCD2[1]&BCD2[0])|((~BCD2[3])&BCD2[2]&(~BCD2[1])&(~BCD2[0]))|((~BCD2[3])&BCD2[2]&(~BCD2[1])&BCD2[0])|((~BCD2[3])&BCD2[2]&BCD2[1]&BCD2[0])|(BCD2[3]&(~BCD2[2])&(~BCD2[1])&BCD2[0]);
	assign hex_1_min[5] = ((~BCD2[3])&(~BCD2[2])&(~BCD2[1])&BCD2[0])|((~BCD2[3])&(~BCD2[2])&BCD2[1]&(~BCD2[0]))|((~BCD2[3])&(~BCD2[2])&BCD2[1]&BCD2[0])|((~BCD2[3])&BCD2[2]&BCD2[1]&BCD2[0]);
	assign hex_1_min[6] = ((~BCD2[3])&(~BCD2[2])&(~BCD2[1])&(~BCD2[0]))|((~BCD2[3])&(~BCD2[2])&(~BCD2[1])&BCD2[0])|((~BCD2[3])&BCD2[2]&BCD2[1]&BCD2[0]);
	
	assign hex_10_mins[0] = ((~BCD2[7])&(~BCD2[6])&(~BCD2[5])&BCD2[4])|((~BCD2[7])&BCD2[6]&(~BCD2[5])&(~BCD2[4]));
	assign hex_10_mins[1] = ((~BCD2[7])&BCD2[6]&(~BCD2[5])&BCD2[4])|((~BCD2[7])&BCD2[6]&BCD2[5]&(~BCD2[4]));
	assign hex_10_mins[2] = ((~BCD2[7])&(~BCD2[6])&BCD2[5]&(~BCD2[4]));
	assign hex_10_mins[3] = ((~BCD2[7])&(~BCD2[6])&(~BCD2[5])&BCD2[4])|((~BCD2[7])&BCD2[6]&(~BCD2[5])&(~BCD2[4]))|((~BCD2[7])&BCD2[6]&BCD2[5]&BCD2[4]);
	assign hex_10_mins[4] = ((~BCD2[7])&(~BCD2[6])&(~BCD2[5])&BCD2[4])|((~BCD2[7])&(~BCD2[6])&BCD2[5]&BCD2[4])|((~BCD2[7])&BCD2[6]&(~BCD2[5])&(~BCD2[4]))|((~BCD2[7])&BCD2[6]&(~BCD2[5])&BCD2[4])|((~BCD2[7])&BCD2[6]&BCD2[5]&BCD2[4])|(BCD2[7]&(~BCD2[6])&(~BCD2[5])&BCD2[4]);
	assign hex_10_mins[5] = ((~BCD2[7])&(~BCD2[6])&(~BCD2[5])&BCD2[4])|((~BCD2[7])&(~BCD2[6])&BCD2[5]&(~BCD2[4]))|((~BCD2[7])&(~BCD2[6])&BCD2[5]&BCD2[4])|((~BCD2[7])&BCD2[6]&BCD2[5]&BCD2[4]);
	assign hex_10_mins[6] = ((~BCD2[7])&(~BCD2[6])&(~BCD2[5])&(~BCD2[4]))|((~BCD2[7])&(~BCD2[6])&(~BCD2[5])&BCD2[4])|((~BCD2[7])&BCD2[6]&BCD2[5]&BCD2[4]);
	
endmodule