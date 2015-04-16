// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	Reset_Delay
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
// --------------------------------------------------------------------

module	Reset_Delay(iCLK,oRST_0,oRST_1,oRST_2,oRST_3,oRST_4);
input		iCLK;
output reg	oRST_0;
output reg	oRST_1;
output reg	oRST_2;
output reg	oRST_3;
output reg	oRST_4;

reg	[31:0]	Cont;

always@(posedge iCLK)
begin
		if(Cont!=32'h01FFFFFF)
		Cont	<=	Cont+1;
		if(Cont>=32'h001FFFFF)
		oRST_0	<=	1;
		if(Cont>=32'h002FFFFF)
		oRST_1	<=	1;
		if(Cont>=32'h011FFFFF)
		oRST_2	<=	1;
		if(Cont>=32'h016FFFFF)
		oRST_3	<=	1;
		if(Cont>=32'h01FFFFFF)
		oRST_4	<=	1;

end

endmodule