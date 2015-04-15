module	RGB2Grey(	iCLK, 
							BlueRGB, 
							RedRGB, 
							GreenRGB, 
							GGrey, 
							RGrey, 
							BGrey,
							BINARY_mode_SW,
							GRAY_mode_SW
							);


input			 	iCLK;
input				GRAY_mode_SW;
input				BINARY_mode_SW;
input  [11:0] 	BlueRGB;
input  [11:0] 	RedRGB;
input  [11:0] 	GreenRGB;

output [11:0]  BGrey;
output [11:0]  RGrey;
output [11:0]  GGrey;

reg [13:0]	grey;
reg [35:0]	toRGB_output;

assign BGrey = toRGB_output[35:24];
assign RGrey = toRGB_output[23:12];
assign GGrey = toRGB_output[11:0];

always@(posedge iCLK)
begin
	if(GRAY_mode_SW)
		begin
			grey <= (BlueRGB + RedRGB + GreenRGB)/3;
			 toRGB_output[35:24] <= grey[11:0];
			 toRGB_output[23:12] <= grey[11:0];
			 toRGB_output[11:0] <= grey[11:0];
			 
			 if(BINARY_mode_SW)
			 begin
				if(grey[11:0] > 12'd2000)
				begin
					toRGB_output[35:24] <= 12'd0;
					toRGB_output[23:12] <= 12'd0;
					toRGB_output[11:0] <= 12'd0;
				end
				else
				begin
					toRGB_output[35:24] <= 12'd4095;
					toRGB_output[23:12] <= 12'd4095;
					toRGB_output[11:0] <= 12'd4095;
				end
			end
		end
	else
		begin
			 toRGB_output[35:24] <= BlueRGB;
			 toRGB_output[23:12] <= RedRGB;
			 toRGB_output[11:0] <= GreenRGB;
		end
end

endmodule
