`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:04 11/03/2018 
// Design Name: 
// Module Name:    baud_controller 
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
module baud_controller(reset, clk, baud_select, sample_ENABLE);
input reset, clk;
input [2:0] baud_select;
output reg sample_ENABLE;

reg [13:0] counter_max;
reg [13:0] counter;

always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		sample_ENABLE = 1'b0;
		counter = 14'b00000000000000;
	end
	else
	begin
		case(baud_select)//define counter max from different baud_select value
		3'b000: counter_max = 14'b10100010100000;
		3'b001: counter_max = 14'b00101000101000;
		3'b010: counter_max = 14'b00001010001011;
		3'b011: counter_max = 14'b00000101000101;
		3'b100: counter_max = 14'b00000010100011;
		3'b101: counter_max = 14'b00000001010001;
		3'b110: counter_max = 14'b00000000110110;
		default: counter_max = 14'b00000000011011;
		endcase
		counter = counter + 1;
		if (counter == counter_max)//IF COUNTER TAKE MAX VALUE sample_ENABLE take value 1 and counter take value 0
		begin
			sample_ENABLE = 1'b1;
			counter = 14'b00000000000000;
		end
		else// if counter have different value sample_ENABLE remain 0
		begin 
			sample_ENABLE = 1'b0;
		end
	end
end

endmodule
