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
module message_Rx(reset, Rx_sample, Rx_EN, RxD, Rx_DATA, Rx_FERROR, Rx_PERROR, Rx_VALID);
input reset;
input Rx_sample, Rx_EN;
input RxD;

output reg [7:0] Rx_DATA;
output reg Rx_FERROR;
output reg Rx_PERROR;
output reg Rx_VALID;

reg PERROR;
reg [3:0] counter_bit;
reg [3:0] counter;// cycle counter for middle
reg Parity_Bit;
reg [7:0] DATA;

always@(posedge reset or posedge Rx_sample)
begin
	if(reset)
	begin
		Rx_DATA = 8'b00000000;
		Rx_FERROR = 1'b0;
		Rx_PERROR = 1'b0;
		DATA = 8'b00000000;
		PERROR = 1'b0;
		Rx_VALID = 1'b0;
		Parity_Bit = 1'b0;
		counter_bit = 4'b1111;
		counter = 4'b0000;
	end
	else if (Rx_EN == 1'b1)
	begin
		if (RxD == 1'b1 && counter_bit == 4'b1111) //BEFORE START BIT
		begin
			counter = 4'b0000;
		end
		else if (RxD == 1'b0 && counter_bit == 4'b1111) //START BIT
		begin
			if (counter == 4'b0111)//MDDLE CHECK
			begin
				counter = 4'b0000;
				counter_bit = 4'b0000;
			end
			else if(counter == 4'b0000) //WHEN TAKE NEW SYMBOL ALL TAKE VALUE 0
			begin
				counter = counter + 1;
				PERROR = 1'b0;
				Rx_PERROR = 1'b0;
				Rx_FERROR = 1'b0;
				Rx_DATA = 8'b00000000;
				DATA = 8'b00000000;
			end
			else
				counter = counter + 1;
		end
		else
		begin
			if (counter == 4'b1111)//MIDDLE CHECK
			begin
				case(counter_bit)
				4'b1000:// CALCULATE AND CHECK PARITY BIT
				begin
					Parity_Bit = DATA[0] ^ DATA[1] ^ DATA[2] ^ DATA[3] ^ DATA[4] ^ DATA[5] ^ DATA[6] ^ DATA[7];
					if (RxD != Parity_Bit)
						PERROR = 1'b1;
					counter_bit = counter_bit + 1;//GO TO NEXT BIT
					counter = 4'b0000;
				end
				4'b1001://CHECK STOP BIT
				begin
					if (RxD != 1) //STOP BIT HANEN'T CORRECT VALUE SENT FERROR
					begin
						Rx_DATA = 8'b00000000;
						Rx_FERROR = 1'b1;//FERROR TAKE VALUE 1
						Rx_PERROR = 1'b0;
						Rx_VALID = 1'b0;
					end
					else if (PERROR == 1'b1) //PARITY BIT DIDN'T HAVE CORRECT VALUE SENT PERROR
					begin
						Rx_DATA = 8'b00000000;
						Rx_FERROR = 1'b0;
						Rx_PERROR = 1'b1;
						Rx_VALID = 1'b0;
					end
					else // TRANSFER DATA TO Rx_DATA
					begin
						Rx_DATA = DATA;
						Rx_FERROR = 1'b0;
						Rx_PERROR = 1'b0;
						Rx_VALID = 1'b1;
					end
					
					Parity_Bit = 1'b0;
					counter_bit = counter_bit + 1;
					counter = 4'b1111;
				end
				4'b1010:// hold Rx_VALID 1 for one cycle
				begin
					PERROR = 1'b0;
					Rx_VALID = 1'b0;
					counter_bit = 4'b1111;
					counter = 4'b0000;
				end
				default: //SAVE SYMBOL BIT
				begin
					DATA[counter_bit] = RxD;
					counter_bit = counter_bit + 1;
					counter = 4'b0000;
				end
				endcase
			end
			else
				counter = counter + 1;
		end
	end
	else //IF RECEIVER IS CLOSE
	begin
		Rx_DATA = 8'b00000000;
		DATA = 8'b00000000;
		Rx_FERROR = 1'b0;
		Rx_PERROR = 1'b0;
		PERROR = 1'b0;
		Rx_VALID = 1'b0;
		Parity_Bit = 1'b0;
		counter_bit = 4'b1111;
		counter = 4'b0000;
	end
end

endmodule
