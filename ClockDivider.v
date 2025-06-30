/* ClockDivider.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A ClockDivider module - divides 50 Mhz signal to 100 Hz signal
*
* Inputs:
* CLK_50MHz - The 50 MHz clock signal
* reset_n - The reset signal that is active when low
*
* Output:
* CLK_100Hz - The 100 Hz output clock signal 
*
*/
module ClockDivider(
	input CLK_50MHz,
	input reset_n,
	
	output CLK_100Hz
);	
	wire [18:0] D;
	wire [18:0] clk_out;
	
	
	DFlipFlop dff1(
		CLK_50MHz,
		D[0],
		reset_n,
		clk_out[0]
	);
	
	DFlipFlop dff2(
		clk_out[0],
		D[1],
		reset_n,
		clk_out[1]
	);
	
	DFlipFlop dff3(
		clk_out[1],
		D[2],
		reset_n,
		clk_out[2]
	);
	
	DFlipFlop dff4(
		clk_out[2],
		D[3],
		reset_n,
		clk_out[3]
	);
	
	DFlipFlop dff5(
		clk_out[3],
		D[4],
		reset_n,
		clk_out[4]
	);
	
	DFlipFlop dff6(
		clk_out[4],
		D[5],
		reset_n,
		clk_out[5]
	);
	
	DFlipFlop dff7(
		clk_out[5],
		D[6],
		reset_n,
		clk_out[6]
	);
	
	DFlipFlop dff8(
		clk_out[6],
		D[7],
		reset_n,
		clk_out[7]
	);
	
	DFlipFlop dff9(
		clk_out[7],
		D[8],
		reset_n,
		clk_out[8]
	);
	
	DFlipFlop dff10(
		clk_out[8],
		D[9],
		reset_n,
		clk_out[9]
	);
	
	DFlipFlop dff11(
		clk_out[9],
		D[10],
		reset_n,
		clk_out[10]
	);
	
	DFlipFlop dff12(
		clk_out[10],
		D[11],
		reset_n,
		clk_out[11]
	);
	
	DFlipFlop dff13(
		clk_out[11],
		D[12],
		reset_n,
		clk_out[12]
	);
	
	DFlipFlop dff14(
		clk_out[12],
		D[13],
		reset_n,
		clk_out[13]
	);
	
	DFlipFlop dff15(
		clk_out[13],
		D[14],
		reset_n,
		clk_out[14]
	);
	
	DFlipFlop dff16(
		clk_out[14],
		D[15],
		reset_n,
		clk_out[15]
	);
	
	DFlipFlop dff17(
		clk_out[15],
		D[16],
		reset_n,
		clk_out[16]
	);
	
	DFlipFlop dff18(
		clk_out[16],
		D[17],
		reset_n,
		clk_out[17]
	);
	
	DFlipFlop dff19(
		clk_out[17],
		D[18],
		reset_n,
		CLK_100Hz
	);
	
	assign D[0] = ~clk_out[0];
	assign D[1] = ~clk_out[1];
	assign D[2] = ~clk_out[2];
	assign D[3] = ~clk_out[3];
	assign D[4] = ~clk_out[4];
	assign D[5] = ~clk_out[5];
	assign D[6] = ~clk_out[6];
	assign D[7] = ~clk_out[7];
	assign D[8] = ~clk_out[8];
	assign D[9] = ~clk_out[9];
	assign D[10] = ~clk_out[10];
	assign D[11] = ~clk_out[11];
	assign D[12] = ~clk_out[12];
	assign D[13] = ~clk_out[13];
	assign D[14] = ~clk_out[14];
	assign D[15] = ~clk_out[15];
	assign D[16] = ~clk_out[16];
	assign D[17] = ~clk_out[17];
	assign D[18] = ~CLK_100Hz;

endmodule