`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:58:05 11/04/2018 
// Design Name: 
// Module Name:    uart_transmitter 
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
module uart_transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);
input reset, clk;
input [7:0] Tx_DATA;
input [2:0] baud_select;
input Tx_WR;
input Tx_EN;

output TxD;
output Tx_BUSY;

wire Tx_sample_ENABLE;

baud_controller baud_controller_inst(.reset(reset), .clk(clk), .baud_select(baud_select), .sample_ENABLE(Tx_sample_ENABLE));

message message_inst(.reset(reset), .Tx_sample_ENABLE(Tx_sample_ENABLE), .Tx_EN(Tx_EN), .Tx_WR(Tx_WR), .Tx_DATA(Tx_DATA), .TxD(TxD), .Tx_BUSY(Tx_BUSY));

endmodule
