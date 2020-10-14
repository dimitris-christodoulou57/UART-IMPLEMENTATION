`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:07 11/14/2018 
// Design Name: 
// Module Name:    data 
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
module data(reset, Tx_BUSY, Rx_VALID, Tx_sample_ENABLE, Tx_DATA, Tx_EN, Rx_EN, Tx_WR);
input reset;
input Tx_BUSY, Rx_VALID, Tx_sample_ENABLE;
output reg [7:0] Tx_DATA;
output reg Tx_EN, Rx_EN, Tx_WR;

reg [1:0] data;
reg data_load;

always@(posedge reset or posedge Tx_sample_ENABLE)
begin
	if(reset)
	begin
		data_load = 1'b0;
		data = 2'b00;
		Tx_EN = 1'b1;
		Rx_EN = 1'b1;
		Tx_WR = 1'b0;
	end
	else
	begin
		if (Tx_BUSY == 1'b0 && data_load == 1'b0)// IF TRANSMITTER ISN'T BUSY AND DIDN'T TAKE SYMBOL, SEND SYMBOL
		begin
			case(data)
			2'b00: //FIRST SYMBOL
			begin
				Tx_WR = 1'b1; //TAKE VALUE 1 FOR 1 CYCLE
				data_load = 1'b1;
				Tx_DATA = 8'b10101010;
				data = 2'b01;
			end
			2'b01: //SECOND SYMBOL
			begin
				Tx_WR = 1'b1;
				data_load = 1'b1;
				Tx_DATA = 8'b01010101;
				data = 2'b10;
			end
			2'b10: //THIRD SYMBOL
			begin
				Tx_WR = 1'b1;
				data_load = 1'b1;
				Tx_DATA = 8'b11001100;
				data = 2'b11;
			end
			2'b11: //FINAL SYMBOL
			begin
				Tx_WR = 1'b1;
				data_load = 1'b1;
				Tx_DATA = 8'b10001001;
				data = 2'b00;
			end
			endcase
		end
		else if (Rx_VALID == 1'b1) // IF VALID = 1 DATA RECEIVED FROM RECEIVER
		begin
				data_load = 1'b0;
		end
		else // CHANGE Tx_WR IN ORDER TO HAVE VALUE ONLY FOR ONE CYCLE
		begin
			Tx_WR = 1'b0;
		end
	end
end


endmodule
