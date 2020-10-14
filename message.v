`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:13:50 11/05/2018 
// Design Name: 
// Module Name:    message 
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
module message(reset, Tx_sample_ENABLE, Tx_EN, Tx_WR, Tx_DATA , TxD, Tx_BUSY);
input reset;
input Tx_sample_ENABLE, Tx_EN, Tx_WR;
input [7:0] Tx_DATA;
output reg TxD;
output reg Tx_BUSY;

reg [1:0] state;
reg [3:0] counter_bit;
reg [3:0] counter;//counter period
reg Parity_Bit;

wire [3:0] counter_max;

assign counter_max = 4'b1111;

always@(posedge Tx_sample_ENABLE or posedge reset)
begin
	if (reset)
	begin
		state = 2'b00;
		counter_bit = 4'b0000;
		counter = 4'b0000;
		TxD = 1'b1;
		Tx_BUSY = 1'b0;
	end
	else if(Tx_EN == 1'b1)
	begin
		case(state)
			2'b00: //WAIT SYMBOL
			begin
				if(Tx_WR == 1'b1)//REICEVE SYMBOL
				begin
					state = 2'b01;//GO TO NEXT STATE
					Tx_BUSY = 1'b1;//TRANSMITTER IS BUSY
					Parity_Bit = Tx_DATA[0] + Tx_DATA[1] + Tx_DATA[2] + Tx_DATA[3] + Tx_DATA[4] + Tx_DATA[5] + Tx_DATA[6] + Tx_DATA[7];//CALCURATET PARITY BIT
				end
			end
			2'b01: //START BIT
			begin
				if (counter == counter_max)
				begin
					state = 2'b10;
					counter = 4'b0000;
				end
				else
				begin
					TxD = 1'b0;
					counter = counter + 1;
				end
			end
			2'b10: //DATA BIT
			begin
				if (counter == counter_max && counter_bit == 4'b0111) //PARITY BIT
				begin
					TxD = Parity_Bit;
					counter = 4'b0000;
					counter_bit = counter_bit + 1;
				end
				else if(counter_bit == 4'b1000)//SEND PARITY BIT X16
					begin
						counter = counter + 1;
						if (counter == counter_max)
						begin
							counter_bit = 4'b0000;
							counter = 4'b0000;
							state = 2'b11;
						end
					end
				else if (counter == counter_max) //NEXT BIT
				begin
					counter_bit = counter_bit + 1;
					counter = 4'b0000;
				end
				else // SENT SYMBOL BIT
				begin
					TxD = Tx_DATA[counter_bit];
					counter = counter + 1;
				end
			end
			2'b11: //STOP BIT
			begin
				if (counter == counter_max)
				begin
					Tx_BUSY = 1'b0;//TRANSMITTER ISN'T BUSY
					state = 2'b00;
					counter = 4'b0000;
				end
				else
				begin
					TxD = 1'b1;
					counter = counter + 1;
				end
			end
		endcase
	end
	else//IF TRANSMITTER IS CLOSE
	begin
		state = 2'b00;
		counter_bit = 4'b0000;
		counter = 4'b0000;
		TxD = 1'b1;
		Tx_BUSY = 1'b0;
	end
end

endmodule
