`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:47:10 10/05/2018 
// Design Name: 
// Module Name:    LEDdecoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LEDdecoder(char, LED);
input [3:0] char;
output [6:0] LED;

reg [6:0] LED;

always @(char)
begin 
	if (char == 4'b0000)//binary zero match 0
	begin
		LED = 7'b0000001;
	end
	else if (char == 4'b0001)//binary one match 1
	begin 
		LED = 7'b1001111;
	end
	else if (char == 4'b0010)//binary two match 2
	begin 
		LED = 7'b0010010;
	end
	else if (char == 4'b0011)//binary three match 3
	begin 
		LED = 7'b0000110;
	end
	else if (char == 4'b0100)//binary four match 4
	begin 
		LED = 7'b1001100;
	end
	else if (char == 4'b0101)//binary five match 5
	begin 
		LED = 7'b0100100;
	end
	else if (char == 4'b0110)//binary six match 6
	begin 
		LED = 7'b0100000;
	end
	else if (char == 4'b0111)//binary seven match 7
	begin 
		LED = 7'b0001111;
	end
	else if (char == 4'b1000)//binary eight match 8
	begin 
		LED = 7'b0000000;
	end
	else if (char == 4'b1001)//binary nine match 9
	begin 
		LED = 7'b0000100;
	end
	else if (char == 4'b1010)//binary ten match A
	begin 
		LED = 7'b0001000;
	end
	else if (char == 4'b1011)//binary eleven match b
	begin 
		LED = 7'b1100000;
	end
	else if (char == 4'b1100)//binary twelve match C
	begin 
		LED = 7'b0110001;
	end
	else if (char == 4'b1101)//binary thirteen match d
	begin 
		LED = 7'b1000010;
	end
	else if (char == 4'b1110)//binary fourteen match E
	begin 
		LED = 7'b0110000;
	end
	else//binary fifteen match F
	begin 
		LED = 7'b0111000;
	end
end


endmodule
