/* StopwatchLogic.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A StopwatchLogic module - counter for mins, secs and decs
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
module StopwatchLogic(
	input CLK_100Hz,
	input reset_n,
	input start_stop,
	input	hold,
	
	output [6:0] stopwatch_unit_mins,
	output [5:0] stopwatch_unit_secs,
	output [6:0] stopwatch_unit_decs,
	output reg stopwatch_overflow
);
	reg [6:0] minutes_reg;
	reg [5:0] seconds_reg;
	reg [6:0] tenths_reg;
	reg running;
	reg hold_flag;
	
	initial begin
		minutes_reg <= 7'b0;   	// current minutes value
		seconds_reg <= 6'b0;   	// current seconds value
		tenths_reg <= 7'b0;    	// current tenths of second value
		running <= 1'b0;        // timer running flag
		hold_flag <= 1'b0;      // hold flag
	end
	
	
	always @ (posedge CLK_100Hz or negedge reset_n)
	begin
		if(~reset_n)
		begin
			minutes_reg <= 0;
			seconds_reg <= 0;
			tenths_reg <= 0;
			running <= 0;
			hold_flag <= 0;
			stopwatch_overflow <= 0;
		end
		
		else
		begin
			//start/stop timer
			if(~running && ~start_stop)
			begin
				//start timer
				running <= 1;
			end
			
			else if(running && ~start_stop)
			begin
				//stop timer
				running <= 0;
			end
			
			//resume/pause timer
			if(~hold)
			begin
				//pause timer
				hold_flag <= 1;
			end
			
			else if(hold)
			begin
				//resume timer
				hold_flag <= 0;
			end	
		
		/////////////////////////////////////////////////
			if(running && ~hold_flag)
			begin
				tenths_reg <= tenths_reg + 1;
				
				if(tenths_reg >= 99)
				begin
					tenths_reg <= 0;
					seconds_reg <= seconds_reg + 1;
				end
				
				if(seconds_reg >= 59)
				begin
					seconds_reg <= 0;
					minutes_reg <= minutes_reg + 1;
				end
				
				if(minutes_reg >= 99)
				begin
					minutes_reg <= 0;
					stopwatch_overflow <= 1;
				end
			end
		end
		
		
	end
	
	assign stopwatch_unit_decs = tenths_reg;
	assign stopwatch_unit_secs = seconds_reg;
	assign stopwatch_unit_mins = minutes_reg;

endmodule	