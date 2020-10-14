`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dimitris Christodoulou
// 
// Create Date:    14:16:02 10/10/2018 
// Design Name: 
// Module Name:    Counter 
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
module Counter(clkdv, reset, Rx_VALID, Rx_DATA, an3, an2, an1, an0, out);
input clkdv;
input reset;
input Rx_VALID;
input [7:0] Rx_DATA;
output reg an3;
output reg an2;
output reg an1;
output reg an0;
output reg [3:0] out;

reg [3:0] counter;
reg [3:0] data_led3, data_led2;

always @(posedge clkdv or posedge reset)
begin 
	if (reset)
	begin
		counter = 4'b0000;
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		out = 4'b0000;
		data_led2 = 4'b0000;
		data_led3 = 4'b0000;
	end
	else if (counter == 4'b1110)//LED-3 
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 0;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		counter = counter - 1;
	end
	else if (counter == 4'b1100)//LOAD DATA LED-2
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		out = data_led2;
		counter = counter - 1;
	end
	else if (counter == 4'b1010)//LED-2
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 0;
		an1 = 1;
		an0 = 1;
		counter = counter - 1;
	end
	else if (counter == 4'b1000)//LOAD DATA LED-1
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		counter = counter - 1;
	end
	else if (counter == 4'b0110)//LED-1
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		counter = counter - 1;
	end
	else if (counter == 4'b0100)//LOAD DATA LED-0
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		counter = counter - 1;
	end
	else if (counter == 4'b0010)//LED-0
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		counter = counter - 1;
	end
	else if (counter == 4'b0000)//LOAD DATA LED-3
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		out = data_led3;
		counter = 4'b1111;
	end
	else 
	begin
		if (Rx_VALID == 1'b1)//SAVE DATA WHICH RECEIVE RECEIVER
		begin
			data_led3 = Rx_DATA[7:4];
			data_led2 = Rx_DATA[3:0];
		end
		an3 = 1;
		an2 = 1;
		an1 = 1;
		an0 = 1;
		counter = counter - 1; 
	end
	
end


endmodule
