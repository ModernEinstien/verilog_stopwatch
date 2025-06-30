 /* BCDEncoder.v
* --------------
* By: Zuriel Nkoro
* Date: 1st April 2023
* 
* Module Desciption:
* -------------------
* A BCDEncoder module - converts 8-bit binary to 12-bit BCD
*
* Inputs:
* BinaryIn[7:0] - 8-bit binary value
*
* Output:
* BCDOut[11:0] - 12-bit BCD value
*
*/
 module BCDEncoder(
   input [7:0] BinaryIn,
   output reg [11:0] BCDOut
);
   
integer i;  
     

always @(BinaryIn)
  begin
		BCDOut = 0; 
		for (i = 0; i < 8; i = i + 1) begin
		 BCDOut = {BCDOut[10:0],BinaryIn[7-i]}; 
			  
		 if(i < 7 && BCDOut[3:0] > 4) 
			  BCDOut[3:0] = BCDOut[3:0] + 3;
		 if(i < 7 && BCDOut[7:4] > 4)
			  BCDOut[7:4] = BCDOut[7:4] + 3;
		 if(i < 7 && BCDOut[11:8] > 4)
			  BCDOut[11:8] = BCDOut[11:8] + 3;  
		end
end     


				 
endmodule