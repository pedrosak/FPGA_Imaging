module	eqGrey(		iCLK, 
							iBlueRGB, 
							iRedRGB, 
							iGreenRGB, 
							oGreenEQ, 
							oRedEQ, 
							oBlueEQ,
							inc_KEY, 
							dec_KEY,
							EQ_mode_SW,
							GREY_mode_SW,
							const_mode_SW
							);


input			 	iCLK;
input				GREY_mode_SW;
input				EQ_mode_SW;
input				const_mode_SW;
input				inc_KEY;
input				dec_KEY;
input  [11:0] 	iBlueRGB;
input  [11:0] 	iRedRGB;
input  [11:0] 	iGreenRGB;

output [11:0]  oBlueEQ;
output [11:0]  oRedEQ;
output [11:0]  oGreenEQ;

reg [35:0]	toRGB_output;
reg [18:0]  sOut;
reg [7:0] const_K = 1;
reg [7:0] const_C = 0;

assign oBlueEQ = toRGB_output[35:24];
assign oRedEQ = toRGB_output[23:12];
assign oGreenEQ = toRGB_output[11:0];

always@(posedge iCLK)
begin
	if(GREY_mode_SW)
	begin
		if(inc_KEY && !const_mode_SW)
		begin
			const_K <= const_K + 1;
		end
		else if(dec_KEY && !const_mode_SW)
		begin
			const_K <= const_K - 1;
		end
		else if(inc_KEY && const_mode_SW)
		begin
			const_C <= const_C + 1;
		end
		else if(dec_KEY && const_mode_SW)
		begin
			const_C <= const_C - 1;
		end
		
		sOut <= iRedRGB * const_K + const_C;
		toRGB_output[35:24] <= sOut[11:0];
		toRGB_output[23:12] <=sOut[11:0];
		toRGB_output[11:0] <= sOut[11:0];
		
	end
	else
	begin
		toRGB_output[35:24] <= iBlueRGB;
		toRGB_output[23:12] <= iRedRGB;
		toRGB_output[11:0] <= iGreenRGB;
	end
end

//always@(negedge inc_KEY)
//begin
//if(!const_mode_SW)
//		begin
//			const_K <= const_K + 1;
//		end
//else if(const_mode_SW)
//		begin
//			const_C <= const_C + 1;
//		end
//
//	
//end
//
//always@(negedge dec_KEY)
//begin
//if(!const_mode_SW)
//		begin
//			const_K <= const_K - 1;
//		end
//else if(const_mode_SW)
//		begin
//			const_C <= const_C - 1;
//		end
//
//	
//end
endmodule
