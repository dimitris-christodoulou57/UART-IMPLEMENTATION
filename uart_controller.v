`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:31:56 11/13/2018 
// Design Name: 
// Module Name:    uart_controller 
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
module uart_controller(reset, clk, baud_select, Rx_DATA, Rx_FERROR, Rx_PERROR, Rx_VALID,
								an3, an2, an1, an0, a, b, c, d, e, f, g, dp, clkdv);
input reset, clk;
input [2:0] baud_select;
output wire Rx_FERROR, Rx_PERROR, Rx_VALID;
output wire [7:0] Rx_DATA;
output wire a, b, c, d, e, f, g, dp, clkdv;
output wire an3, an2, an1, an0;

wire Tx_EN, Rx_EN, Tx_WR, Tx_BUSY;
wire TxD;
wire reset_new;
wire [7:0] Tx_DATA;
wire Tx_sample_ENABLE;

//ANTI_BOUNCE ANTI_BOUNCE_INST(.clk(clk), .button_signal(reset), .button_state(reset_new));

baud_controller baud_controller_ins_1(.reset(reset), .clk(clk), .baud_select(baud_select), .sample_ENABLE(Tx_sample_ENABLE));

data data_inst(.reset(reset), .Tx_BUSY(Tx_BUSY), .Rx_VALID(Rx_VALID), .Tx_sample_ENABLE(Tx_sample_ENABLE), .Tx_DATA(Tx_DATA), .Tx_EN(Tx_EN), .Rx_EN(Rx_EN), .Tx_WR(Tx_WR));

uart_transmitter uart_transmitter_inst(.reset(reset), 
													.clk(clk), 
													.Tx_DATA(Tx_DATA), 
													.baud_select(baud_select), 
													.Tx_WR(Tx_WR), 
													.Tx_EN(Tx_EN), 
													.TxD(TxD), 
													.Tx_BUSY(Tx_BUSY));

uart_receiver uart_receiver_inst(.reset(reset), 
											.clk(clk), 
											.Rx_DATA(Rx_DATA), 
											.baud_select(baud_select), 
											.Rx_EN(Rx_EN), 
											.RxD(TxD), 
											.Rx_FERROR(Rx_FERROR), 
											.Rx_PERROR(Rx_PERROR), 
											.Rx_VALID(Rx_VALID));
										
FourDigitLEDdriver FourDigitLEDdriver_inst(.reset(reset), 
															.clk(clk),
															.Rx_VALID(Rx_VALID),
															.Rx_DATA(Rx_DATA),
															.an3(an3), 
															.an2(an2),
															.an1(an1), 
															.an0(an0), 
															.a(a), 
															.b(b), 
															.c(c), 
															.d(d), 
															.e(e),
															.f(f), 
															.g(g), 
															.dp(dp),
															.clkdv(clkdv));


endmodule
