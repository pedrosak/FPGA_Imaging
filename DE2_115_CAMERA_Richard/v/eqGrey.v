module	eqGrey(		iCLK, 
							iBlueRGB, 
							iRedRGB, 
							iGreenRGB, 
							oGreenEQ, 
							oRedEQ, 
							oBlueEQ,
							K_reading,
							inc_dec_KEY,
							EQ_mode_SW,
							GREY_mode_SW,
							const_SW,
							const_mode_SW
							);


input			 	iCLK;
input				GREY_mode_SW;
input				EQ_mode_SW;
input				const_mode_SW;
input				inc_dec_KEY;
input				const_SW;
input  [11:0] 	iBlueRGB;
input  [11:0] 	iRedRGB;
input  [11:0] 	iGreenRGB;

output [11:0]  oBlueEQ;
output [11:0]  oRedEQ;
output [11:0]  oGreenEQ;
output [7:0]	K_reading;

reg [35:0]		toRGB_output;
reg [19:0]  	sOut;
reg [7:0] 		const_K, const_C;

assign oBlueEQ = toRGB_output[35:24];
assign oRedEQ = toRGB_output[23:12];
assign oGreenEQ = toRGB_output[11:0];

assign K_reading = const_K;

always@(posedge iCLK)
begin
if(GREY_mode_SW)
	begin
		if(sOut <= 8'd255)
			begin
				toRGB_output[35:24] 	<= sOut[13:2];
				toRGB_output[23:12] 	<= sOut[13:2];
				toRGB_output[11:0] 	<= sOut[13:2];
			end
		else if(sOut > 8'd255)
			begin
				toRGB_output[35:24] 	<= sOut[18:7];
				toRGB_output[23:12] 	<= sOut[18:7];
				toRGB_output[11:0] 	<= sOut[18:7];
			end
	end
else
	begin
		toRGB_output[35:24] 	<= iBlueRGB;
		toRGB_output[23:12] 	<= iRedRGB;
		toRGB_output[11:0] 	<= iGreenRGB;
	end
end


always@(negedge inc_dec_KEY && EQ_mode_SW)
begin
	if(!inc_dec_KEY)
	begin
		if(!const_mode_SW)
		begin
			const_K <= const_K+ 8'b00000001;
		end
	end
	else if(!inc_dec_KEY && const_SW)
	begin
		if(!const_mode_SW)
		begin
			const_K <= const_K-1;
			
		end
	end
	sOut <= iRedRGB * const_K;
end
endmodule
