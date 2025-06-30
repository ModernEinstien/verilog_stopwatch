Field Programmable Gate Array (FPGA) is a complex programmable logic device that can be programmed to carry out specific digital logic functions.
It contains memory blocks, transceivers, protocol controllers, CPUs. It also consists of Configurable Logic Blocks (CLB) and programmable interconnections to allow for various digital logic functions.
The programming can be carried out using Hardware Development languages (HDL) such as Verilog to program a digital circuit, synthesis it and map it to the FPGA’s resources.

In this project the skills we have learnt will be put to the test by designing and creating a Stopwatch that will be used on the FPGA using Verilog. This Stopwatch will have a reset, start/stop, hold input. The reset will take the stopwatch back to 00:00:00 when pressed, the start/stop when pressed will start the stopwatch if it is not already running or will stop it if running, the hold will act as a play/pause button when pressed. It will make use of the 6 seven segments displays to show what the time is from 00:00:00 to 99:59:99, also using an LED as an overflow flag if the stopwatch has crossed 99:59:99. Serval Modules will be needed to make this possible as well as having test benches that will be used to evaluate our code. Then a module which connects all these different modules to work unison.

Over the course of this project, I would love to finally be Integrating more complicated designs with a tangible hardware platform like FPGA. After this project using primitive logic and counters shouldn’t be much of an issue anymore since most of the modules require this so I will get a lot of practice from them.

Section 2-1: Clock Divider Module 
A D latch flip flop was designed for the clock divider as a submodule. It has a 1-bit D (Data) input, a clock input, Q and Q_n output. The flip flop becomes transparent when the clock signal is high and is locked when clock is low. In the module the D flip flop is described with an always block so it is sensitive the positive edge of the clock and negative edge of reset.

Input	Output
CLK	D	Qt	Q_n
0	0	Qt-1	Q_nt-1
0	1	Qt-1	Q_nt-1
1	0	0	1
1	1	1	0

With this behaviour a D flip flop can divide a frequency by 2 per a flip flop with D being the frequency to be reduced (f_in) and Q being the new frequency (f_in/2). By cascading many D latch flip flops, you get an output frequency of  (f_in)/2^n  Hz where f_in is 50 MHz and n is the number of flips flops needed to achieve that frequency. So, to get a frequency of approximately 100 Hz (95 Hz) 19 cascaded flip flops are used which is implemented in the clock divider module.

Clock Divider is described by calling 19 D flip flop modules with first using the 50 MHz clock as its clock signal and the last Q output being the 100Hz (95 Hz) signal we acre looking for. This module or flip flops were connected with a 19-bit wire to connect the output of one flip flip to the input of the other.
The D inputs of the flips flops which are defined by a 19-bit wire are assigned by inverting the Q output as seen the diagram below.

Section 2-2: Stopwatch Logic Module 
The Stopwatch module is basically the brains of the operation. It checks for a falling edge on the start/stop input and should start the timer, which counts the decs, secs and mins until another falling edge is detected where it should stop. A logic 0 on the hold input should pause the counter or timer and logic 1 will allow it to run. It also checks for a falling edge on reset_n input and will reset the timer to zero and keep it there for as long as reset_n is low.

An always block is used to be sensitive to positive edge of the clock and negative edge of reset_n. Using behavioural logic an if/else statement is used check the status of reset_n, if is low all registers, counters or overflow flag is set 0 and when high the timer process begins.

Behavioural logic is used to manage the flags (running and hold_flag) which enables the start/stop and hold buttons to be functional. 
•	When start/stop is low and running is low, running flag is set high which starts the timer. Its pauses when start/stop is low, and running is high. 
•	When hold is low and running is high, hold flag is set to high which will cause the timer to stop counting but remain at previous timer position. Its resumes the timer when hold is high, hold_flag is low, and running is high. 

For the timer more behavioural logic is used in unison with three binary counters (minutes_reg, seconds_reg and tenths_reg) if the running flag is high and hold flag is low. Tenths_reg counts until 99 (7’b1100011) and is cleared to 0 while enabling seconds_reg to add 1. Seconds_reg counts until 59 (6’b111011) and is cleared to 0 while enabling minutes_reg to add 1. Minutes_reg counts until 99 (7’b1100011) and is cleared to 0 which sets the overflow flag. All this combined makes a working timer/ stopwatch.

Section 2-3: Binary to Seven Segment Encoder 
Binary to Seven Segment Encoder module is designed to take in binary values from the Stopwatch logic module which are 7-bit stopwatch_unit_mins, 6-bitstopwatch_unit_secs and 7-bit stopwatch_unit_decs and convert these binary values to BCD which can then be assigned to one of the 6 seven segment displays to form a number on it.

The module makes use of the BCDEncoder submodule which converts binary to BCD. It makes use of the of the “Shift and add 3” algorithm. Its shift 8 times but if the Thousands, Hundreds, Tens, or Units is greater than 4 the code should add 3.

Example: convert 0011 1011 to BCD.
Operation	Thousands	Hundreds	Tens	Units	Binary 
Start					                            0011 1011
Shift 1				                          0	011 1011
Shift 2				                         00	11 1011
Shift 3				                        001	1 1011
Shift 4				                       0011	1011
Shift 5			                       0 0111	011
Add 3			                         0 1010 011
Shift 6			                      01 0100	11
Shift 7			                     010 1001	1
Add 3			                       010 1100	1
Shift 8			                    0101 1001	
BCD			                        0101 1001	
			                           5	   9

This can be implemented with an always block to be sensitive to any change in the 8-bit input. It then uses a for loop that will use all bits of the input, shifts the bit left 8 times and makes use of behavioural if statements to check if bits 3-0, 7-4 and 11-8 are greater than 4 which if it is will add 3 (2’b11) and output a 12-bit BCD.

Then using the truth table gotten from a previous lab session. We create a formula to get BCD to HEX segment by taking the sum of products of LOW since the seven segment display is active low.

HEX0=~(ABC)D+~(A)B~(CD)
HEX1=(~A)B(~C)D+(~A)BC(~D)
HEX2=~(AB)C(~D)
HEX3=~(ABC)D+(~A)B~(CD)+(~A)BCD
HEX4=~(ABC)D+~(AB)CD+(~A)B~(CD)+(~A)B(~C)D+(~A)BCD+A(~B)CD
HEX5=~(ABC)D+~(AB)C(~D)+(~AB)CD+(~A)BCD
HEX6=~(ABCD)+~(ABC)D+(~A)BCD

Section 2-4: Stopwatch (Top-level entity) 
The Stopwatch module combines the SevenSegEncoder, StopwatchLogic and ClockDivider modules as submodules shown the Hierarchical Design below. The DFlipFlop is submioduke for ClockDivider. BCDEncoder is the submodule of the SevenSegEncoder.
The 50MHz clock signal is sent to the ClockDivider submodule from the input of the Stopwatch module. The ClockDivider then outputs the 100Hz signal which is sent to the StopwatchLogic submodule using a wire called CLK_100Hz. It also outputs the 100Hz signal to the Stopwatch module’s CLK_ind. The StopwatchLogic outputs the mins, secs and decs binary value and sends it to the SevenSegEncoder using a 7-bit stopwatch_unit_mins wire, 6-bit stopwatch_unit_secs wire and 7-bit stopwatch_unit_decs wire while also outputting the overflow flag to the Stopwatch module’s output overflow_flag. The SevenSegEncoder finally outputs the 7-bit segment HEX value to the stopwatch Module’s ten_mins_seven_seg, one_min_seven_seg, ten_secs_seven_seg, one_sec_seven_seg, hundreths_seven_seg and tenths_seven_seg.

Validation 
The stopwatch module must be validated to make sure all the functions work as expected. First off all, all the module’s test vectors need to be tested so see if any problems will arise if certain inputs were triggered with other inputs. Then the module will be allowed to time or count for about 10 seconds after the start/stop input has been triggered with a falling edge. This process should check if the hex values are correct and timer counting properly. Then after this period reset is triggered to see if the timer and 100 Hz signal goes to 0 or low and continues if reset input was untriggered then after timer continues for about a minute to cross check if seconds and minutes are following behaviour. Then after hold input is tested. Counter should then count for 100 minutes to validate overflow flag.

The testbench is designed to display all the function of the stopwatch by setting specific inputs.
The testbench design incorporates the 50 MHz clock signal with an always block that inverts the clock value every 10 ns simulating a 50 MHz signal. The procedural initial block is used to set the value of he ports. A for loop is used to test all test vectors which is 8 different combinations which leaves them all at HIGH. Brute force is used to set the start_stop input too low for 20 ns then after set to high for around 1 second for the hundredths and tenth to count. Reset is set to low to clear all timers. Then the start_stop input is set to low for half a second and then set back to HIGH. This to enable use show that functionally of the hold input which will now be set too low for 11 ms. Reset is set to low to clear the stopwatch and start_stop input is set to 0 to check the functionality of the other seven seg values for the seconds and minutes.

