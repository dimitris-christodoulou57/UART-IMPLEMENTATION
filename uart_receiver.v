`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:41:22 11/11/2018 
// Design Name: 
// Module Name:    uart_receiver 
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
module uart_receiver(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD, Rx_FERROR, Rx_PERROR, Rx_VALID); 
input reset, clk;
input [2:0] baud_select; 
input Rx_EN; 
input RxD;

output wire [7:0] Rx_DATA; 
output wire Rx_FERROR; // Framing Error // 
output wire Rx_PERROR; // Parity Error // 
output wire Rx_VALID; // Rx_DATA is Valid // 

wire Rx_sample_ENABLE;

baud_controller baud_controller_inst(.reset(reset), .clk(clk), .baud_select(baud_select), .sample_ENABLE(Rx_sample_ENABLE));

message_Rx message_Rx_inst(.reset(reset), .Rx_sample(Rx_sample_ENABLE), .Rx_EN(Rx_EN), .RxD(RxD), .Rx_DATA(Rx_DATA), .Rx_FERROR(Rx_FERROR), .Rx_PERROR(Rx_PERROR), .Rx_VALID(Rx_VALID));


endmodule
