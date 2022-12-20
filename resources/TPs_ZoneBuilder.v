
module TPs_ZoneBuilder(

					TPsfromCB0_,TPsfromCB1_,TPsfromCB2_,
							
					n_rst_phaser,
												
					lpbus_clk,clock40,
																			
					n_global_reset,n_poweron_reset,
					
					ZoneBuilding_enable,
					projection_OK,
												
					S0_Zoning_Word_Pattern, S1_Zoning_Word_Pattern, S0_Zoning_Word_Near_Source, S1_Zoning_Word_Near_Source, 
							
					TSZB_S0Z0_,TSZB_S0Z1_,TSZB_S0Z2_,TSZB_S0Z3_,TSZB_S0Z4_,TSZB_S0Z5_,
					TSZB_S0Z6_,TSZB_S0Z7_,TSZB_S0Z8_,TSZB_S0Z9_,TSZB_S1Z0_,TSZB_S1Z1_,
					TSZB_S1Z2_,TSZB_S1Z3_,TSZB_S1Z4_,TSZB_S1Z5_,TSZB_S1Z6_,TSZB_S1Z7_,
					TSZB_S1Z8_,TSZB_S1Z9_,
					
					compute_tracker_OK,
		
               PR_SZA_S0Z0_, PR_SZB_S0Z0_,  PR_SZC_S0Z0_, PR_SZD_S0Z0_,  
               PL_SZA_S0Z0_,  PL_SZB_S0Z0_,  PL_SZC_S0Z0_,  PL_SZD_S0Z0_,   
               VSZB_S0Z0_, HSZB_S0Z0_,   
               PR_SZA_S0Z1_, PR_SZB_S0Z1_,  PR_SZC_S0Z1_, PR_SZD_S0Z1_,  
               PL_SZA_S0Z1_,  PL_SZB_S0Z1_,  PL_SZC_S0Z1_,  PL_SZD_S0Z1_,   
               VSZB_S0Z1_, HSZB_S0Z1_,   
               PR_SZA_S0Z2_, PR_SZB_S0Z2_,  PR_SZC_S0Z2_, PR_SZD_S0Z2_,  
               PL_SZA_S0Z2_,  PL_SZB_S0Z2_,  PL_SZC_S0Z2_,  PL_SZD_S0Z2_,   
               VSZB_S0Z2_, HSZB_S0Z2_,   
               PR_SZA_S0Z3_, PR_SZB_S0Z3_,  PR_SZC_S0Z3_, PR_SZD_S0Z3_,  
               PL_SZA_S0Z3_,  PL_SZB_S0Z3_,  PL_SZC_S0Z3_,  PL_SZD_S0Z3_,   
               VSZB_S0Z3_, HSZB_S0Z3_,   
               PR_SZA_S0Z4_, PR_SZB_S0Z4_,  PR_SZC_S0Z4_, PR_SZD_S0Z4_,  
               PL_SZA_S0Z4_,  PL_SZB_S0Z4_,  PL_SZC_S0Z4_,  PL_SZD_S0Z4_,   
               VSZB_S0Z4_, HSZB_S0Z4_,   
               PR_SZA_S0Z5_, PR_SZB_S0Z5_,  PR_SZC_S0Z5_, PR_SZD_S0Z5_,  
               PL_SZA_S0Z5_,  PL_SZB_S0Z5_,  PL_SZC_S0Z5_,  PL_SZD_S0Z5_,   
               VSZB_S0Z5_, HSZB_S0Z5_,   
               PR_SZA_S0Z6_, PR_SZB_S0Z6_,  PR_SZC_S0Z6_, PR_SZD_S0Z6_,  
               PL_SZA_S0Z6_,  PL_SZB_S0Z6_,  PL_SZC_S0Z6_,  PL_SZD_S0Z6_,   
               VSZB_S0Z6_, HSZB_S0Z6_,   
               PR_SZA_S0Z7_, PR_SZB_S0Z7_,  PR_SZC_S0Z7_, PR_SZD_S0Z7_,  
               PL_SZA_S0Z7_,  PL_SZB_S0Z7_,  PL_SZC_S0Z7_,  PL_SZD_S0Z7_,   
               VSZB_S0Z7_, HSZB_S0Z7_,   
               PR_SZA_S0Z8_, PR_SZB_S0Z8_,  PR_SZC_S0Z8_, PR_SZD_S0Z8_,  
               PL_SZA_S0Z8_,  PL_SZB_S0Z8_,  PL_SZC_S0Z8_,  PL_SZD_S0Z8_,   
               VSZB_S0Z8_, HSZB_S0Z8_, 
               PR_SZA_S0Z9_, PR_SZB_S0Z9_,  PR_SZC_S0Z9_, PR_SZD_S0Z9_,  
               PL_SZA_S0Z9_,  PL_SZB_S0Z9_,  PL_SZC_S0Z9_,  PL_SZD_S0Z9_,   
               VSZB_S0Z9_, HSZB_S0Z9_,    

               PR_SZA_S1Z0_, PR_SZB_S1Z0_,  PR_SZC_S1Z0_, PR_SZD_S1Z0_,  
               PL_SZA_S1Z0_,  PL_SZB_S1Z0_,  PL_SZC_S1Z0_,  PL_SZD_S1Z0_,   
               VSZB_S1Z0_, HSZB_S1Z0_,   
               PR_SZA_S1Z1_, PR_SZB_S1Z1_,  PR_SZC_S1Z1_, PR_SZD_S1Z1_,  
               PL_SZA_S1Z1_,  PL_SZB_S1Z1_,  PL_SZC_S1Z1_,  PL_SZD_S1Z1_,   
               VSZB_S1Z1_, HSZB_S1Z1_,   
               PR_SZA_S1Z2_, PR_SZB_S1Z2_,  PR_SZC_S1Z2_, PR_SZD_S1Z2_,  
               PL_SZA_S1Z2_,  PL_SZB_S1Z2_,  PL_SZC_S1Z2_,  PL_SZD_S1Z2_,   
               VSZB_S1Z2_, HSZB_S1Z2_,   
               PR_SZA_S1Z3_, PR_SZB_S1Z3_,  PR_SZC_S1Z3_, PR_SZD_S1Z3_,  
               PL_SZA_S1Z3_,  PL_SZB_S1Z3_,  PL_SZC_S1Z3_,  PL_SZD_S1Z3_,   
               VSZB_S1Z3_, HSZB_S1Z3_,   
               PR_SZA_S1Z4_, PR_SZB_S1Z4_,  PR_SZC_S1Z4_, PR_SZD_S1Z4_,  
               PL_SZA_S1Z4_,  PL_SZB_S1Z4_,  PL_SZC_S1Z4_,  PL_SZD_S1Z4_,   
               VSZB_S1Z4_, HSZB_S1Z4_,   
               PR_SZA_S1Z5_, PR_SZB_S1Z5_,  PR_SZC_S1Z5_, PR_SZD_S1Z5_,  
               PL_SZA_S1Z5_,  PL_SZB_S1Z5_,  PL_SZC_S1Z5_,  PL_SZD_S1Z5_,   
               VSZB_S1Z5_, HSZB_S1Z5_,   
               PR_SZA_S1Z6_, PR_SZB_S1Z6_,  PR_SZC_S1Z6_, PR_SZD_S1Z6_,  
               PL_SZA_S1Z6_,  PL_SZB_S1Z6_,  PL_SZC_S1Z6_,  PL_SZD_S1Z6_,   
               VSZB_S1Z6_, HSZB_S1Z6_,   
               PR_SZA_S1Z7_, PR_SZB_S1Z7_,  PR_SZC_S1Z7_, PR_SZD_S1Z7_,  
               PL_SZA_S1Z7_,  PL_SZB_S1Z7_,  PL_SZC_S1Z7_,  PL_SZD_S1Z7_,   
               VSZB_S1Z7_, HSZB_S1Z7_,   
               PR_SZA_S1Z8_, PR_SZB_S1Z8_,  PR_SZC_S1Z8_, PR_SZD_S1Z8_,  
               PL_SZA_S1Z8_,  PL_SZB_S1Z8_,  PL_SZC_S1Z8_,  PL_SZD_S1Z8_,   
               VSZB_S1Z8_, HSZB_S1Z8_, 
               PR_SZA_S1Z9_, PR_SZB_S1Z9_,  PR_SZC_S1Z9_, PR_SZD_S1Z9_,  
               PL_SZA_S1Z9_,  PL_SZB_S1Z9_,  PL_SZC_S1Z9_,  PL_SZD_S1Z9_,   
               VSZB_S1Z9_, HSZB_S1Z9_,
					
					S0_Zoning_Word_Pattern,S1_Zoning_Word_Pattern,
					S0_Zoning_Word_Near_Source,S1_Zoning_Word_Near_Source 
			);
							

input [683:0]	TPsfromCB0_,TPsfromCB1_,TPsfromCB2_;
									
input			n_rst_phaser;

input			lpbus_clk,clock40;

input			n_global_reset,n_poweron_reset;

input 		ZoneBuilding_enable;
input			projection_OK;

output [9:0] 	S0_Zoning_Word_Pattern,S1_Zoning_Word_Pattern;
output [9:0] 	S0_Zoning_Word_Near_Source,S1_Zoning_Word_Near_Source; 

output [6:0]	TSZB_S0Z0_,TSZB_S0Z1_,TSZB_S0Z2_,TSZB_S0Z3_,TSZB_S0Z4_,TSZB_S0Z5_,
					TSZB_S0Z6_,TSZB_S0Z7_,TSZB_S0Z8_,TSZB_S0Z9_,TSZB_S1Z0_,TSZB_S1Z1_,
					TSZB_S1Z2_,TSZB_S1Z3_,TSZB_S1Z4_,TSZB_S1Z5_,TSZB_S1Z6_,TSZB_S1Z7_,
					TSZB_S1Z8_,TSZB_S1Z9_;
					
output			compute_tracker_OK;
	
output [7:0] PR_SZA_S0Z0_, PR_SZB_S0Z0_,  PR_SZC_S0Z0_, PR_SZD_S0Z0_; 
output [8:0] PL_SZA_S0Z0_,  PL_SZB_S0Z0_,  PL_SZC_S0Z0_,  PL_SZD_S0Z0_;  
output [7:0] VSZB_S0Z0_, HSZB_S0Z0_;  
output [7:0] PR_SZA_S0Z1_, PR_SZB_S0Z1_,  PR_SZC_S0Z1_, PR_SZD_S0Z1_; 
output [8:0] PL_SZA_S0Z1_,  PL_SZB_S0Z1_,  PL_SZC_S0Z1_,  PL_SZD_S0Z1_;  
output [7:0] VSZB_S0Z1_, HSZB_S0Z1_;  
output [7:0] PR_SZA_S0Z2_, PR_SZB_S0Z2_,  PR_SZC_S0Z2_, PR_SZD_S0Z2_; 
output [8:0] PL_SZA_S0Z2_,  PL_SZB_S0Z2_,  PL_SZC_S0Z2_,  PL_SZD_S0Z2_;  
output [7:0] VSZB_S0Z2_, HSZB_S0Z2_;  
output [7:0] PR_SZA_S0Z3_, PR_SZB_S0Z3_,  PR_SZC_S0Z3_, PR_SZD_S0Z3_; 
output [8:0] PL_SZA_S0Z3_,  PL_SZB_S0Z3_,  PL_SZC_S0Z3_,  PL_SZD_S0Z3_;  
output [7:0] VSZB_S0Z3_, HSZB_S0Z3_;  
output [7:0] PR_SZA_S0Z4_, PR_SZB_S0Z4_,  PR_SZC_S0Z4_, PR_SZD_S0Z4_; 
output [8:0] PL_SZA_S0Z4_,  PL_SZB_S0Z4_,  PL_SZC_S0Z4_,  PL_SZD_S0Z4_;  
output [7:0] VSZB_S0Z4_, HSZB_S0Z4_;  
output [7:0] PR_SZA_S0Z5_, PR_SZB_S0Z5_,  PR_SZC_S0Z5_, PR_SZD_S0Z5_; 
output [8:0] PL_SZA_S0Z5_,  PL_SZB_S0Z5_,  PL_SZC_S0Z5_,  PL_SZD_S0Z5_;  
output [7:0] VSZB_S0Z5_, HSZB_S0Z5_;  
output [7:0] PR_SZA_S0Z6_, PR_SZB_S0Z6_,  PR_SZC_S0Z6_, PR_SZD_S0Z6_; 
output [8:0] PL_SZA_S0Z6_,  PL_SZB_S0Z6_,  PL_SZC_S0Z6_,  PL_SZD_S0Z6_;  
output [7:0] VSZB_S0Z6_, HSZB_S0Z6_;  
output [7:0] PR_SZA_S0Z7_, PR_SZB_S0Z7_,  PR_SZC_S0Z7_, PR_SZD_S0Z7_; 
output [8:0] PL_SZA_S0Z7_,  PL_SZB_S0Z7_,  PL_SZC_S0Z7_,  PL_SZD_S0Z7_;  
output [7:0] VSZB_S0Z7_, HSZB_S0Z7_;  
output [7:0] PR_SZA_S0Z8_, PR_SZB_S0Z8_,  PR_SZC_S0Z8_, PR_SZD_S0Z8_; 
output [8:0] PL_SZA_S0Z8_,  PL_SZB_S0Z8_,  PL_SZC_S0Z8_,  PL_SZD_S0Z8_;  
output [7:0] VSZB_S0Z8_, HSZB_S0Z8_;
output [7:0] PR_SZA_S0Z9_, PR_SZB_S0Z9_,  PR_SZC_S0Z9_, PR_SZD_S0Z9_; 
output [8:0] PL_SZA_S0Z9_,  PL_SZB_S0Z9_,  PL_SZC_S0Z9_,  PL_SZD_S0Z9_;  
output [7:0] VSZB_S0Z9_, HSZB_S0Z9_;   

output [7:0] PR_SZA_S1Z0_, PR_SZB_S1Z0_,  PR_SZC_S1Z0_, PR_SZD_S1Z0_; 
output [8:0] PL_SZA_S1Z0_,  PL_SZB_S1Z0_,  PL_SZC_S1Z0_,  PL_SZD_S1Z0_;  
output [7:0] VSZB_S1Z0_, HSZB_S1Z0_;  
output [7:0] PR_SZA_S1Z1_, PR_SZB_S1Z1_,  PR_SZC_S1Z1_, PR_SZD_S1Z1_; 
output [8:0] PL_SZA_S1Z1_,  PL_SZB_S1Z1_,  PL_SZC_S1Z1_,  PL_SZD_S1Z1_;  
output [7:0] VSZB_S1Z1_, HSZB_S1Z1_;  
output [7:0] PR_SZA_S1Z2_, PR_SZB_S1Z2_,  PR_SZC_S1Z2_, PR_SZD_S1Z2_; 
output [8:0] PL_SZA_S1Z2_,  PL_SZB_S1Z2_,  PL_SZC_S1Z2_,  PL_SZD_S1Z2_;  
output [7:0] VSZB_S1Z2_, HSZB_S1Z2_;  
output [7:0] PR_SZA_S1Z3_, PR_SZB_S1Z3_,  PR_SZC_S1Z3_, PR_SZD_S1Z3_; 
output [8:0] PL_SZA_S1Z3_,  PL_SZB_S1Z3_,  PL_SZC_S1Z3_,  PL_SZD_S1Z3_;  
output [7:0] VSZB_S1Z3_, HSZB_S1Z3_;  
output [7:0] PR_SZA_S1Z4_, PR_SZB_S1Z4_,  PR_SZC_S1Z4_, PR_SZD_S1Z4_; 
output [8:0] PL_SZA_S1Z4_,  PL_SZB_S1Z4_,  PL_SZC_S1Z4_,  PL_SZD_S1Z4_;  
output [7:0] VSZB_S1Z4_, HSZB_S1Z4_;  
output [7:0] PR_SZA_S1Z5_, PR_SZB_S1Z5_,  PR_SZC_S1Z5_, PR_SZD_S1Z5_; 
output [8:0] PL_SZA_S1Z5_,  PL_SZB_S1Z5_,  PL_SZC_S1Z5_,  PL_SZD_S1Z5_;  
output [7:0] VSZB_S1Z5_, HSZB_S1Z5_;  
output [7:0] PR_SZA_S1Z6_, PR_SZB_S1Z6_,  PR_SZC_S1Z6_, PR_SZD_S1Z6_; 
output [8:0] PL_SZA_S1Z6_,  PL_SZB_S1Z6_,  PL_SZC_S1Z6_,  PL_SZD_S1Z6_;  
output [7:0] VSZB_S1Z6_, HSZB_S1Z6_;  
output [7:0] PR_SZA_S1Z7_, PR_SZB_S1Z7_,  PR_SZC_S1Z7_, PR_SZD_S1Z7_; 
output [8:0] PL_SZA_S1Z7_,  PL_SZB_S1Z7_,  PL_SZC_S1Z7_,  PL_SZD_S1Z7_;  
output [7:0] VSZB_S1Z7_, HSZB_S1Z7_;  
output [7:0] PR_SZA_S1Z8_, PR_SZB_S1Z8_,  PR_SZC_S1Z8_, PR_SZD_S1Z8_; 
output [8:0] PL_SZA_S1Z8_,  PL_SZB_S1Z8_,  PL_SZC_S1Z8_,  PL_SZD_S1Z8_;  
output [7:0] VSZB_S1Z8_, HSZB_S1Z8_;
output [7:0] PR_SZA_S1Z9_, PR_SZB_S1Z9_,  PR_SZC_S1Z9_, PR_SZD_S1Z9_; 
output [8:0] PL_SZA_S1Z9_,  PL_SZB_S1Z9_,  PL_SZC_S1Z9_,  PL_SZD_S1Z9_;  
output [7:0] VSZB_S1Z9_, HSZB_S1Z9_;    

//-----------------------------------------------------------
wire			n_rst_phaser;

wire			lpbus_clk,clock40;

wire			n_global_reset,n_poweron_reset;
//------------------------------------------------------------
wire 	[3:0]	view_sync; 
 
//Tps from Crate0 from Crate1 from Crate2 --
//------------------------------------------
//CB0
//---
wire	[35:0] 	FrameCB0toTB_Id;
wire 	[5:0]		NberWordsTPsfromCB0Shifted;
wire 	[3:0] 	st_transactionCB0toTB;
wire				toogleCB0_wren_reg;
wire 	[683:0]	TPsfromCB0_;	 
wire	[9:0]		view_CB0;

//CB1
//---
wire	[35:0] 	FrameCB1toTB_Id;
wire 	[5:0]		NberWordsTPsfromCB1Shifted;
wire 	[3:0] 	st_transactionCB1toTB;
wire				toogleCB1_wren_reg;
wire 	[683:0]	TPsfromCB1_;	
wire	[9:0]		view_CB1;

//CB2
//---
wire	[35:0] 	FrameCB2toTB_Id;
wire 	[5:0]		NberWordsTPsfromCB2Shifted;
wire 	[3:0] 	st_transactionCB2toTB;
wire				toogleCB2_wren_reg;
wire 	[683:0]	TPsfromCB2_;
wire	[9:0]		view_CB2;

//
wire	ZoneBuilding_enable;
wire	wrregTPs_CB0,wrregTPs_CB1,wrregTPs_CB2;
wire	projection_OK;

wire	[29:0] 	test_out;
wire	[16:0]	view_error;

wire 	n_rst;

//miscellaneous
//-------------
assign 	n_rst	= 	n_global_reset & n_poweron_reset & n_rst_phaser;

//------------------------------------------------------------
//------------------------------------------------------------
//------------------- ProjectionRowandLayer ------------------
//------------------------------------------------------------
//------------------------------------------------------------
wire [6:0]		TSZB_S0Z0_,TSZB_S0Z1_,TSZB_S0Z2_,TSZB_S0Z3_,TSZB_S0Z4_,TSZB_S0Z5_,
					TSZB_S0Z6_,TSZB_S0Z7_,TSZB_S0Z8_,TSZB_S0Z9_,TSZB_S1Z0_,TSZB_S1Z1_,
					TSZB_S1Z2_,TSZB_S1Z3_,TSZB_S1Z4_,TSZB_S1Z5_,TSZB_S1Z6_,TSZB_S1Z7_,
					TSZB_S1Z8_,TSZB_S1Z9_;

wire	bit_ZW_Pattern_S0Z0,bit_ZW_Pattern_S0Z1,bit_ZW_Pattern_S0Z2,
		bit_ZW_Pattern_S0Z3,bit_ZW_Pattern_S0Z4,bit_ZW_Pattern_S0Z5,
		bit_ZW_Pattern_S0Z6,bit_ZW_Pattern_S0Z7,bit_ZW_Pattern_S0Z8,bit_ZW_Pattern_S0Z9;  

wire	bit_ZW_Pattern_S1Z0,bit_ZW_Pattern_S1Z1,bit_ZW_Pattern_S1Z2,
		bit_ZW_Pattern_S1Z3,bit_ZW_Pattern_S1Z4,bit_ZW_Pattern_S1Z5,
		bit_ZW_Pattern_S1Z6,bit_ZW_Pattern_S1Z7,bit_ZW_Pattern_S1Z8,bit_ZW_Pattern_S1Z9;
		
wire	bit_ZW_NearSource_S0Z0,bit_ZW_NearSource_S0Z1,bit_ZW_NearSource_S0Z2,
		bit_ZW_NearSource_S0Z3,bit_ZW_NearSource_S0Z4,bit_ZW_NearSource_S0Z5,
		bit_ZW_NearSource_S0Z6,bit_ZW_NearSource_S0Z7,bit_ZW_NearSource_S0Z8,bit_ZW_NearSource_S0Z9; 
		
wire	bit_ZW_NearSource_S1Z0,bit_ZW_NearSource_S1Z1,bit_ZW_NearSource_S1Z2,
		bit_ZW_NearSource_S1Z3,bit_ZW_NearSource_S1Z4,bit_ZW_NearSource_S1Z5,
		bit_ZW_NearSource_S1Z6,bit_ZW_NearSource_S1Z7,bit_ZW_NearSource_S1Z8,bit_ZW_NearSource_S1Z9;
		
		
wire [7:0] PR_SZA_S0Z0_, PR_SZB_S0Z0_,  PR_SZC_S0Z0_, PR_SZD_S0Z0_; 
wire [8:0] PL_SZA_S0Z0_,  PL_SZB_S0Z0_,  PL_SZC_S0Z0_,  PL_SZD_S0Z0_;  
wire [7:0] VSZB_S0Z0_, HSZB_S0Z0_;  
wire [7:0] PR_SZA_S0Z1_, PR_SZB_S0Z1_,  PR_SZC_S0Z1_, PR_SZD_S0Z1_; 
wire [8:0] PL_SZA_S0Z1_,  PL_SZB_S0Z1_,  PL_SZC_S0Z1_,  PL_SZD_S0Z1_;  
wire [7:0] VSZB_S0Z1_, HSZB_S0Z1_;  
wire [7:0] PR_SZA_S0Z2_, PR_SZB_S0Z2_,  PR_SZC_S0Z2_, PR_SZD_S0Z2_; 
wire [8:0] PL_SZA_S0Z2_,  PL_SZB_S0Z2_,  PL_SZC_S0Z2_,  PL_SZD_S0Z2_;  
wire [7:0] VSZB_S0Z2_, HSZB_S0Z2_;  
wire [7:0] PR_SZA_S0Z3_, PR_SZB_S0Z3_,  PR_SZC_S0Z3_, PR_SZD_S0Z3_; 
wire [8:0] PL_SZA_S0Z3_,  PL_SZB_S0Z3_,  PL_SZC_S0Z3_,  PL_SZD_S0Z3_;  
wire [7:0] VSZB_S0Z3_, HSZB_S0Z3_;  
wire [7:0] PR_SZA_S0Z4_, PR_SZB_S0Z4_,  PR_SZC_S0Z4_, PR_SZD_S0Z4_; 
wire [8:0] PL_SZA_S0Z4_,  PL_SZB_S0Z4_,  PL_SZC_S0Z4_,  PL_SZD_S0Z4_;  
wire [7:0] VSZB_S0Z4_, HSZB_S0Z4_;  
wire [7:0] PR_SZA_S0Z5_, PR_SZB_S0Z5_,  PR_SZC_S0Z5_, PR_SZD_S0Z5_; 
wire [8:0] PL_SZA_S0Z5_,  PL_SZB_S0Z5_,  PL_SZC_S0Z5_,  PL_SZD_S0Z5_;  
wire [7:0] VSZB_S0Z5_, HSZB_S0Z5_;  
wire [7:0] PR_SZA_S0Z6_, PR_SZB_S0Z6_,  PR_SZC_S0Z6_, PR_SZD_S0Z6_; 
wire [8:0] PL_SZA_S0Z6_,  PL_SZB_S0Z6_,  PL_SZC_S0Z6_,  PL_SZD_S0Z6_;  
wire [7:0] VSZB_S0Z6_, HSZB_S0Z6_;  
wire [7:0] PR_SZA_S0Z7_, PR_SZB_S0Z7_,  PR_SZC_S0Z7_, PR_SZD_S0Z7_; 
wire [8:0] PL_SZA_S0Z7_,  PL_SZB_S0Z7_,  PL_SZC_S0Z7_,  PL_SZD_S0Z7_;  
wire [7:0] VSZB_S0Z7_, HSZB_S0Z7_;  
wire [7:0] PR_SZA_S0Z8_, PR_SZB_S0Z8_,  PR_SZC_S0Z8_, PR_SZD_S0Z8_; 
wire [8:0] PL_SZA_S0Z8_,  PL_SZB_S0Z8_,  PL_SZC_S0Z8_,  PL_SZD_S0Z8_;  
wire [7:0] VSZB_S0Z8_, HSZB_S0Z8_;
wire [7:0] PR_SZA_S0Z9_, PR_SZB_S0Z9_,  PR_SZC_S0Z9_, PR_SZD_S0Z9_; 
wire [8:0] PL_SZA_S0Z9_,  PL_SZB_S0Z9_,  PL_SZC_S0Z9_,  PL_SZD_S0Z9_;  
wire [7:0] VSZB_S0Z9_, HSZB_S0Z9_;   

wire [7:0] PR_SZA_S1Z0_, PR_SZB_S1Z0_,  PR_SZC_S1Z0_, PR_SZD_S1Z0_; 
wire [8:0] PL_SZA_S1Z0_,  PL_SZB_S1Z0_,  PL_SZC_S1Z0_,  PL_SZD_S1Z0_;  
wire [7:0] VSZB_S1Z0_, HSZB_S1Z0_;  
wire [7:0] PR_SZA_S1Z1_, PR_SZB_S1Z1_,  PR_SZC_S1Z1_, PR_SZD_S1Z1_; 
wire [8:0] PL_SZA_S1Z1_,  PL_SZB_S1Z1_,  PL_SZC_S1Z1_,  PL_SZD_S1Z1_;  
wire [7:0] VSZB_S1Z1_, HSZB_S1Z1_;  
wire [7:0] PR_SZA_S1Z2_, PR_SZB_S1Z2_,  PR_SZC_S1Z2_, PR_SZD_S1Z2_; 
wire [8:0] PL_SZA_S1Z2_,  PL_SZB_S1Z2_,  PL_SZC_S1Z2_,  PL_SZD_S1Z2_;  
wire [7:0] VSZB_S1Z2_, HSZB_S1Z2_;  
wire [7:0] PR_SZA_S1Z3_, PR_SZB_S1Z3_,  PR_SZC_S1Z3_, PR_SZD_S1Z3_; 
wire [8:0] PL_SZA_S1Z3_,  PL_SZB_S1Z3_,  PL_SZC_S1Z3_,  PL_SZD_S1Z3_;  
wire [7:0] VSZB_S1Z3_, HSZB_S1Z3_;  
wire [7:0] PR_SZA_S1Z4_, PR_SZB_S1Z4_,  PR_SZC_S1Z4_, PR_SZD_S1Z4_; 
wire [8:0] PL_SZA_S1Z4_,  PL_SZB_S1Z4_,  PL_SZC_S1Z4_,  PL_SZD_S1Z4_;  
wire [7:0] VSZB_S1Z4_, HSZB_S1Z4_;  
wire [7:0] PR_SZA_S1Z5_, PR_SZB_S1Z5_,  PR_SZC_S1Z5_, PR_SZD_S1Z5_; 
wire [8:0] PL_SZA_S1Z5_,  PL_SZB_S1Z5_,  PL_SZC_S1Z5_,  PL_SZD_S1Z5_;  
wire [7:0] VSZB_S1Z5_, HSZB_S1Z5_;  
wire [7:0] PR_SZA_S1Z6_, PR_SZB_S1Z6_,  PR_SZC_S1Z6_, PR_SZD_S1Z6_; 
wire [8:0] PL_SZA_S1Z6_,  PL_SZB_S1Z6_,  PL_SZC_S1Z6_,  PL_SZD_S1Z6_;  
wire [7:0] VSZB_S1Z6_, HSZB_S1Z6_;  
wire [7:0] PR_SZA_S1Z7_, PR_SZB_S1Z7_,  PR_SZC_S1Z7_, PR_SZD_S1Z7_; 
wire [8:0] PL_SZA_S1Z7_,  PL_SZB_S1Z7_,  PL_SZC_S1Z7_,  PL_SZD_S1Z7_;  
wire [7:0] VSZB_S1Z7_, HSZB_S1Z7_;  
wire [7:0] PR_SZA_S1Z8_, PR_SZB_S1Z8_,  PR_SZC_S1Z8_, PR_SZD_S1Z8_; 
wire [8:0] PL_SZA_S1Z8_,  PL_SZB_S1Z8_,  PL_SZC_S1Z8_,  PL_SZD_S1Z8_;  
wire [7:0] VSZB_S1Z8_, HSZB_S1Z8_;
wire [7:0] PR_SZA_S1Z9_, PR_SZB_S1Z9_,  PR_SZC_S1Z9_, PR_SZD_S1Z9_; 
wire [8:0] PL_SZA_S1Z9_,  PL_SZB_S1Z9_,  PL_SZC_S1Z9_,  PL_SZD_S1Z9_;  
wire [7:0] VSZB_S1Z9_, HSZB_S1Z9_;    

wire	compute_tracker_OK;
//------------------------------------------------------------
//------------------------------------------------------------
//-- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  --
//-- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  --
//-- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  --
//-- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  --
//------------------------------------------------------------
//------------------------------------------------------------
//Ref: SNDER Version 0.1 p32,48,51-53.
//------------------------------------------------------------
//------------------------------------------------------------
//-----------------------------------------------------
//-----------------------------------------------------	
//------- Filling 20 Zones and 80 Sliding Zones -------
//-----------------------------------------------------
//-----------------------------------------------------
wire				zone0,zone5,zone9;

//-----------------------------------------------------
//-----------------------------------------------------	
//Every TPsfromFEB* is divided in 4 subprimitive fields:
//[8:0] from Side 0			GREEN
//[17:9] from Side 0			BLUE
//[26:18] from Side 1		RED
//[35:27] from Side 1		YELLOW

//input [683:0]	TPfromCB0;
//input [683:0]	TPfromCB1;
//input [683:0]	TPfromCB2;

//		Exemple: PR_S0Z0SZA, PL_S1Z9SZD
//-----------------------------------------------------
//-----------------------------------------------------
//Side0Zone0 
//----------
OneSideZone Side0Zone0
(
	.Rows0(9'b000000000) ,	// input [8:0] Rows0_sig
	.Rows1(9'b000000000) ,	// input [8:0] Rows1_sig
	.Rows2(9'b000000000) ,	// input [8:0] Rows2_sig
	.Rows3(9'b000000000) ,	// input [8:0] Rows3_sig
	.Rows4(9'b000000000) ,	// input [8:0] Rows4_sig
	.Rows5(9'b000000000) ,	// input [8:0] Rows5_sig
	.Rows6(9'b000000000) ,	// input [8:0] Rows6_sig

	.Rows7(TPsfromCB0_[8:0]) ,	// input [8:0] Rows7_sig
	.Rows8(TPsfromCB0_[17:9]) ,	// input [8:0] Rows8_sig

	.Rows9(TPsfromCB0_[44:36]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB0_[53:45]) ,	// input [8:0] Rows10_sig

	.Rows11(TPsfromCB0_[80:72]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB0_[89:81]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB0_[116:108]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB0_[125:117]) ,	// input [8:0] Rows14_sig
	
	.Rows15(TPsfromCB0_[152:144]) ,	// input [8:0] Rows15_sig
	.Rows16(TPsfromCB0_[161:153]) ,	// input [8:0] Rows16_sig
	
	.Rows17(TPsfromCB0_[188:180]) ,	// input [8:0] Rows17_sig
	.Rows18(TPsfromCB0_[197:189]) ,	// input [8:0] Rows18_sig
	
	.Rows19(TPsfromCB0_[224:216]) ,	// input [8:0] Rows19_sig
	
	.zone0(1'b1),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	.compute_tracker_OK(compute_tracker_OK),
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z0_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z0_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z0_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z0_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z0_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z0_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z0_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z0_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z0_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z0_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB_zone0_(TSZB_S0Z0_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z0) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone0_(bit_ZW_NearSource_S0Z0) 	// output  bit_ZW_NearSource_zone0__sig
);

//Side0Zone1
//----------
OneSideZone Side0Zone1	
(
	.Rows0(TPsfromCB0_[89:81]) ,	// input [8:0] Rows0_sig
	
	.Rows1(TPsfromCB0_[116:108]) ,	// input [8:0] Rows1_sig
	.Rows2(TPsfromCB0_[125:117]) ,	// input [8:0] Rows2_sig
	
	.Rows3(TPsfromCB0_[152:144]) ,	// input [8:0] Rows3_sig
	.Rows4(TPsfromCB0_[161:153]) ,	// input [8:0] Rows4_sig
	
	.Rows5(TPsfromCB0_[188:180]) ,	// input [8:0] Rows5_sig
	.Rows6(TPsfromCB0_[197:189]) ,	// input [8:0] Rows6_sig
	
	.Rows7(TPsfromCB0_[224:216]) ,	// input [8:0] Rows7_sig
	.Rows8(TPsfromCB0_[233:225]) ,	// input [8:0] Rows8_sig
	
	.Rows9(TPsfromCB0_[260:252]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB0_[269:261]) ,	// input [8:0] Rows10_sig
	
	.Rows11(TPsfromCB0_[296:288]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB0_[305:297]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB0_[332:324]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB0_[341:333]) ,	// input [8:0] Rows14_sig
	
	.Rows15(TPsfromCB0_[368:360]) ,	// input [8:0] Rows15_sig
	.Rows16(TPsfromCB0_[377:369]) ,	// input [8:0] Rows16_sig
	
	.Rows17(TPsfromCB0_[404:396]) ,	// input [8:0] Rows17_sig
	.Rows18(TPsfromCB0_[413:405]) ,	// input [8:0] Rows18_sig
	
	.Rows19(TPsfromCB0_[440:432]) ,	// input [8:0] Rows19_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),
	
	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z1_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z1_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z1_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z1_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z1_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z1_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z1_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z1_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z1_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z1_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S0Z1_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z1) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S0Z1) 	// output  bit_ZW_NearSource_zone__sig
);

//Side0Zone2
//----------
OneSideZone Side0Zone2
(
	.Rows0(TPsfromCB0_[305:297]) ,	// input [8:0] Rows0_sig
	
	.Rows1(TPsfromCB0_[332:324]) ,	// input [8:0] Rows1_sig
	.Rows2(TPsfromCB0_[341:333]) ,	// input [8:0] Rows2_sig
	
	.Rows3(TPsfromCB0_[368:360]) ,	// input [8:0] Rows3_sig
	.Rows4(TPsfromCB0_[377:369]) ,	// input [8:0] Rows4_sig
	
	.Rows5(TPsfromCB0_[404:396]) ,	// input [8:0] Rows5_sig
	.Rows6(TPsfromCB0_[413:405]) ,	// input [8:0] Rows6_sig
	
	.Rows7(TPsfromCB0_[440:432]) ,	// input [8:0] Rows7_sig
	.Rows8(TPsfromCB0_[449:441]) ,	// input [8:0] Rows8_sig
	
	.Rows9(TPsfromCB0_[476:468]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB0_[485:477]) ,	// input [8:0] Rows10_sig
	
	.Rows11(TPsfromCB0_[512:504]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB0_[521:513]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB0_[548:540]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB0_[557:549]) ,
	
	.Rows15(TPsfromCB0_[584:576]) ,	// input [8:0] Rows15_sig
	.Rows16(TPsfromCB0_[593:585]) ,	// input [8:0] Rows16_sig
	
	.Rows17(TPsfromCB0_[620:612]) ,	// input [8:0] Rows17_sig
	.Rows18(TPsfromCB0_[629:621]) ,	// input [8:0] Rows18_sig
	
	.Rows19(TPsfromCB0_[656:648]) ,	// input [8:0] Rows19_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z2_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z2_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z2_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z2_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z2_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z2_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z2_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z2_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z2_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z2_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S0Z2_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z2) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S0Z2) // output  bit_ZW_NearSource_zone__sig
);

//Side0Zone3
//----------
OneSideZone Side0Zone3
(
	.Rows0(TPsfromCB0_[521:513]) ,	// input [8:0] Rows0_sig
	
	.Rows1(TPsfromCB0_[548:540]) ,	// input [8:0] Rows13_sig
	.Rows2(TPsfromCB0_[557:549]) ,
	
	.Rows3(TPsfromCB0_[584:576]) ,	// input [8:0] Rows15_sig	
	.Rows4(TPsfromCB0_[593:585]) ,	// input [8:0] Rows16_sig
	
	.Rows5(TPsfromCB0_[620:612]) ,	// input [8:0] Rows17_sig
	.Rows6(TPsfromCB0_[629:621]) ,	// input [8:0] Rows18_sig
	
	.Rows7(TPsfromCB0_[656:648]) ,	// input [8:0] Rows19_sig
	.Rows8(TPsfromCB0_[665:657]) ,	// input [8:0] Rows8_sig
	
	.Rows9(TPsfromCB1_[8:0]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB1_[17:9]) ,	// input [8:0] Rows10_sig
	
	.Rows11(TPsfromCB1_[44:36]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB1_[53:45]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB1_[80:72]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB1_[89:81]) ,
	
	.Rows15(TPsfromCB1_[116:108]) ,	// input [8:0] Rows15_sig
	.Rows16(TPsfromCB1_[125:117]) ,	// input [8:0] Rows2_sig
	
	.Rows17(TPsfromCB1_[152:144]) ,	// input [8:0] Rows3_sig
	.Rows18(TPsfromCB1_[161:153]) ,	// input [8:0] Rows4_sig
	
	.Rows19(TPsfromCB1_[188:180]) ,	// input [8:0] Rows5_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z3_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z3_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z3_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z3_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z3_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z3_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z3_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z3_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z3_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z3_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S0Z3_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z3) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S0Z3) // output  bit_ZW_NearSource_zone__sig
);
				
//Side0Zone4
//----------	
OneSideZone Side0Zone4
(
	.Rows0(TPsfromCB1_[53:45]) ,	// input [8:0] Rows0_sig
	
	.Rows1(TPsfromCB1_[80:72]) ,	// input [8:0] Rows1_sig
	.Rows2(TPsfromCB1_[89:81]) ,
	
	.Rows3(TPsfromCB1_[116:108]) ,	// input [8:0] Rows2_sig
	.Rows4(TPsfromCB1_[125:117]) ,	// input [8:0] Rows3_sig
	
	.Rows5(TPsfromCB1_[152:144]) ,	// input [8:0] Rows4_sig
	.Rows6(TPsfromCB1_[161:153]) ,	// input [8:0] Rows5_sig
	
	.Rows7(TPsfromCB1_[188:180]) ,	// input [8:0] Rows6_sig
	.Rows8(TPsfromCB1_[197:189]) ,	// input [8:0] Rows7_sig
	
	.Rows9(TPsfromCB1_[224:216]) ,	// input [8:0] Rows8_sig
	.Rows10(TPsfromCB1_[233:225]) ,	// input [8:0] Rows9_sig
	
	.Rows11(TPsfromCB1_[260:252]) ,	// input [8:0] Rows10_sig
	.Rows12(TPsfromCB1_[269:261]) ,	// input [8:0] Rows11_sig
	
	.Rows13(TPsfromCB1_[296:288]) ,	// input [8:0] Rows12_sig
	.Rows14(TPsfromCB1_[305:297]) ,
	
	.Rows15(TPsfromCB1_[332:324]) ,	// input [8:0] Rows15_sig
				
	.Rows16(TPsfromCB1_[368:360]) ,	// input [8:0] Rows16_sig
	.Rows17(TPsfromCB1_[377:369]) ,	// input [8:0] Rows17_sig
	
	.Rows18(TPsfromCB1_[404:396]) ,	// input [8:0] Rows18_sig
	.Rows19(TPsfromCB1_[413:405]) ,	// input [8:0] Rows19_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),
		
	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z4_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z4_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z4_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z4_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z4_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z4_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z4_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z4_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z4_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z4_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S0Z4_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z4) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S0Z4) 	// output  bit_ZW_NearSource_zone__sig
);

//Side0Zone5
//----------
OneSideZone Side0Zone5
(
	.Rows0(9'b000000000) ,	// input [8:0] Rows12_sig
	

	.Rows1(TPsfromCB1_[269:261]) ,	// input [8:0] Rows12_sig

	.Rows2(TPsfromCB1_[296:288]) ,	// input [8:0] Rows13_sig
	.Rows3(TPsfromCB1_[305:297]) ,					

	.Rows4(TPsfromCB1_[332:324]) ,	// input [8:0] Rows15_sig					

	.Rows5(TPsfromCB1_[368:360]) ,	// input [8:0] Rows3_sig	
	.Rows6(TPsfromCB1_[377:369]) ,	// input [8:0] Rows4_sig
	
	.Rows7(TPsfromCB1_[404:396]) ,	// input [8:0] Rows5_sig	
	.Rows8(TPsfromCB1_[413:405]) ,	// input [8:0] Rows6_sig
	
	.Rows9(TPsfromCB1_[440:432]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB1_[449:441]) ,	// input [8:0] Rows9_sig

	.Rows11(TPsfromCB1_[476:468]) ,	// input [8:0] Rows9_sig
	.Rows12(TPsfromCB1_[485:477]) ,	// input [8:0] Rows9_sig
	
	.Rows13(TPsfromCB1_[512:504]) ,	// input [8:0] Rows10_sig	
	.Rows14(TPsfromCB1_[521:513]) ,	// input [8:0] 
		
	.Rows15(TPsfromCB1_[548:540]) ,	// input [8:0] Rows12_sig	//sliding zoneD
	.Rows16(TPsfromCB1_[557:549]) ,	// input [8:0] Rows13_sig	

	.Rows17(TPsfromCB1_[584:576]) ,	
	.Rows18(TPsfromCB1_[593:585]) ,	// input [8:0] Rows15_sig	

	.Rows19(TPsfromCB1_[620:612]) ,	// input [8:0] 

	.zone0(1'b0),.zone5(1'b1),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z5_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z5_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z5_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z5_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z5_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z5_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z5_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z5_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z5_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z5_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB_zone5_(TSZB_S0Z5_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z5) ,	// output  bit_ZW_Pattern_zone5__sig
	.bit_ZW_NearSource_zone5_(bit_ZW_NearSource_S0Z5) // output  bit_ZW_NearSource_zone5__sig
);

//Side0Zone6
//----------
OneSideZone Side0Zone6
(
	.Rows0(TPsfromCB1_[485:477]) ,	// input [8:0] Rows9_sig

	.Rows1(TPsfromCB1_[512:504]) ,	// input [8:0] Rows10_sig	
	.Rows2(TPsfromCB1_[521:513]) ,	// input [8:0] 		

	.Rows3(TPsfromCB1_[548:540]) ,	// input [8:0] Rows12_sig	//sliding zoneD
	.Rows4(TPsfromCB1_[557:549]) ,	// input [8:0] Rows13_sig	

	.Rows5(TPsfromCB1_[584:576]) ,	
	.Rows6(TPsfromCB1_[593:585]) ,	// input [8:0] Rows15_sig	

	.Rows7(TPsfromCB1_[620:612]) ,	// input [8:0] Rows3_sig
	.Rows8(TPsfromCB1_[629:621]) ,	// input [8:0] Rows18_sig
	
	.Rows9(TPsfromCB1_[656:648]) ,	// input [8:0] Rows19_sig
	.Rows10(TPsfromCB1_[665:657]) ,	// input [8:0] Rows8_sig
	
	.Rows11(TPsfromCB2_[8:0]) ,	// input [8:0] Rows9_sig
	.Rows12(TPsfromCB2_[17:9]) ,	// input [8:0] Rows10_sig
	
	.Rows13(TPsfromCB2_[44:36]) ,	// input [8:0] Rows11_sig
	.Rows14(TPsfromCB2_[53:45]) ,	// input [8:0] Rows12_sig
	
	.Rows15(TPsfromCB2_[80:72]) ,	// input [8:0] Rows13_sig
	.Rows16(TPsfromCB2_[89:81]) ,
	
	.Rows17(TPsfromCB2_[116:108]) ,	// input [8:0] Rows15_sig
	.Rows18(TPsfromCB2_[125:117]) ,	// input [8:0] Rows2_sig
	
	.Rows19(TPsfromCB2_[152:144]) ,	// input [8:0] Rows3_sig

	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z6_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z6_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z6_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z6_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z6_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z6_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z6_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z6_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z6_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z6_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S0Z6_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z6) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S0Z6) // output  bit_ZW_NearSource_zone__sig
);
					
//Side0Zone7
//----------
OneSideZone Side0Zone7
(
	.Rows0(TPsfromCB2_[17:9]) ,	// input [8:0] Rows10_sig
	
	.Rows1(TPsfromCB2_[44:36]) ,	// input [8:0] Rows11_sig
	.Rows2(TPsfromCB2_[53:45]) ,	// input [8:0] Rows12_sig
	
	.Rows3(TPsfromCB2_[80:72]) ,	// input [8:0] Rows13_sig
	.Rows4(TPsfromCB2_[89:81]) ,
	
	.Rows5(TPsfromCB2_[116:108]) ,	// input [8:0] Rows15_sig
	.Rows6(TPsfromCB2_[125:117]) ,	// input [8:0] Rows2_sig
	
	.Rows7(TPsfromCB2_[152:144]) ,	// input [8:0] Rows3_sig
	.Rows8(TPsfromCB2_[161:153]) ,	// input [8:0] Rows4_sig
	
	.Rows9(TPsfromCB2_[188:180]) ,	// input [8:0] Rows5_sig
	.Rows10(TPsfromCB2_[197:189]) ,	// input [8:0] Rows8_sig
	
	.Rows11(TPsfromCB2_[224:216]) ,	// input [8:0] Rows9_sig
	.Rows12(TPsfromCB2_[233:225]) ,	// input [8:0] Rows10_sig
	
	.Rows13(TPsfromCB2_[260:252]) ,	// input [8:0] Rows11_sig
	.Rows14(TPsfromCB2_[269:261]) ,	// input [8:0] Rows12_sig
	
	.Rows15(TPsfromCB2_[296:288]) ,	// input [8:0] Rows13_sig
	.Rows16(TPsfromCB2_[305:297]) ,
	
	.Rows17(TPsfromCB2_[332:324]) ,	// input [8:0] Rows13_sig
	.Rows18(TPsfromCB2_[341:333]) ,	// input [8:0] Rows14_sig
	
	.Rows19(TPsfromCB2_[368:360]) ,	// input [8:0] Rows15_sig

	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z7_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z7_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z7_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z7_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z7_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z7_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z7_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z7_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z7_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z7_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S0Z7_) ,	// output [6:0] TSZB_sig
	
	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z7) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S0Z7) // output  bit_ZW_NearSource_zone__sig
);

//Side0Zone8
//----------
OneSideZone Side0Zone8
(
	.Rows0(TPsfromCB2_[233:225]) ,	// input [8:0] Rows10_sig
	
	.Rows1(TPsfromCB2_[260:252]) ,	// input [8:0] Rows11_sig
	.Rows2(TPsfromCB2_[269:261]) ,	// input [8:0] Rows12_sig
	
	.Rows3(TPsfromCB2_[296:288]) ,	// input [8:0] Rows13_sig
	.Rows4(TPsfromCB2_[305:297]) ,
	
	.Rows5(TPsfromCB2_[332:324]) ,	// input [8:0] Rows13_sig
	.Rows6(TPsfromCB2_[341:333]) ,	// input [8:0] Rows14_sig
	
	.Rows7(TPsfromCB2_[368:360]) ,	// input [8:0] Rows15_sig
	.Rows8(TPsfromCB2_[377:369]) ,	// input [8:0] Rows4_sig
	
	.Rows9(TPsfromCB2_[404:396]) ,	// input [8:0] Rows5_sig	
	.Rows10(TPsfromCB2_[413:405]) ,	// input [8:0] Rows6_sig

	.Rows11(TPsfromCB2_[440:432]) ,	// input [8:0] Rows9_sig
	.Rows12(TPsfromCB2_[449:441]) ,	// input [8:0] Rows9_sig

	.Rows13(TPsfromCB2_[476:468]) ,	// input [8:0] Rows9_sig
	.Rows14(TPsfromCB2_[485:477]) ,	// input [8:0] Rows9_sig
	
	.Rows15(TPsfromCB2_[512:504]) ,	// input [8:0] Rows10_sig	
	.Rows16(TPsfromCB2_[521:513]) ,	// input [8:0] 
		
	.Rows17(TPsfromCB2_[548:540]) ,	// input [8:0] Rows12_sig	//sliding zoneD
	.Rows18(TPsfromCB2_[557:549]) ,	// input [8:0] Rows13_sig	

	.Rows19(TPsfromCB2_[584:576]) ,
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),	

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z8_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z8_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z8_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z8_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z8_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z8_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z8_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z8_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z8_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z8_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S0Z8_) ,	// output [6:0] TSZB_sig
	
	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z8) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S0Z8)	// output  bit_ZW_NearSource_zone__sig
);

//Side0Zone9
//----------
OneSideZone Side0Zone9
(
	.Rows0(TPsfromCB2_[449:441]) ,	// input [8:0] Rows9_sig

	.Rows1(TPsfromCB2_[476:468]) ,	// input [8:0] Rows9_sig
	.Rows2(TPsfromCB2_[485:477]) ,	// input [8:0] Rows9_sig
	
	.Rows3(TPsfromCB2_[512:504]) ,	// input [8:0] Rows10_sig	
	.Rows4(TPsfromCB2_[521:513]) ,	// input [8:0] 
		
	.Rows5(TPsfromCB2_[548:540]) ,	// input [8:0] Rows12_sig	//sliding zoneD
	.Rows6(TPsfromCB2_[557:549]) ,	// input [8:0] Rows13_sig	

	.Rows7(TPsfromCB2_[584:576]) ,
	.Rows8(TPsfromCB2_[593:585]) ,	// input [8:0] Rows15_sig	

	.Rows9(TPsfromCB2_[620:612]) ,	// input [8:0] Rows3_sig
	.Rows10(TPsfromCB2_[629:621]) ,	// input [8:0] Rows18_sig
	
	.Rows11(TPsfromCB2_[656:648]) ,	// input [8:0] Rows19_sig
	.Rows12(TPsfromCB2_[665:657]) ,	// input [8:0] Rows8_sig
	
	.Rows13(9'b000000000) ,	// input [8:0] Rows0_sig	
	.Rows14(9'b000000000) ,	// input [8:0] Rows1_sig
	.Rows15(9'b000000000) ,	// input [8:0] Rows2_sig	
	.Rows16(9'b000000000) ,	// input [8:0] Rows3_sig
	.Rows17(9'b000000000) ,	// input [8:0] Rows4_sig	
	.Rows18(9'b000000000) ,	// input [8:0] Rows5_sig
	.Rows19(9'b000000000) ,	// input [8:0] Rows6_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b1),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
		
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S0Z9_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S0Z9_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S0Z9_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S0Z9_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S0Z9_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S0Z9_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S0Z9_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S0Z9_) ,	// output [8:0]
	
	.VSZB(VSZB_S0Z9_) ,	// output [7:0] 
	.HSZB(HSZB_S0Z9_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB_zone9_(TSZB_S0Z9_) ,	// output [6:0] TSZB_sig
	
	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S0Z9) ,	// output  bit_ZW_Pattern_zone9__sig
	.bit_ZW_NearSource_zone9_(bit_ZW_NearSource_S0Z9)	// output  bit_ZW_NearSource_zone9__sig		
);

//-----------------------------------------------------	
//--- Filling 10 Zones and 40 Sliding Zones in Side0 --
//-----------------------------------------------------
//Side1Zone0 
//----------
OneSideZone Side1Zone0
(
	.Rows0(9'b000000000) ,	// input [8:0] Rows0_sig
	.Rows1(9'b000000000) ,	// input [8:0] Rows1_sig
	.Rows2(9'b000000000) ,	// input [8:0] Rows2_sig	
	.Rows3(9'b000000000) ,	// input [8:0] Rows3_sig
	.Rows4(9'b000000000) ,	// input [8:0] Rows4_sig	
	.Rows5(9'b000000000) ,	// input [8:0] Rows5_sig
	.Rows6(9'b000000000) ,	// input [8:0] Rows6_sig
	
	.Rows7(TPsfromCB0_[26:18]) ,	// input [8:0] Rows7_sig
	.Rows8(TPsfromCB0_[35:27]) ,	// input [8:0] Rows8_sig
	
	.Rows9(TPsfromCB0_[62:54]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB0_[71:63]) ,	// input [8:0] Rows10_sig
	
	.Rows11(TPsfromCB0_[98:90]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB0_[107:99]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB0_[134:126]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB0_[143:135]) ,	// input [8:0] Rows14_sig
	
	.Rows15(TPsfromCB0_[170:162]) ,	// input [8:0] Rows15_sig
	.Rows16(TPsfromCB0_[179:171]) ,	// input [8:0] Rows16_sig
	
	.Rows17(TPsfromCB0_[206:198]) ,	// input [8:0] Rows17_sig
	.Rows18(TPsfromCB0_[215:207]) ,	// input [8:0] Rows18_sig
	
	.Rows19(TPsfromCB0_[242:234]) ,	// input [8:0] Rows19_sig

	.zone0(1'b1),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z0_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z0_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z0_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z0_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z0_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z0_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z0_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z0_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z0_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z0_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB_zone0_(TSZB_S1Z0_) ,	// output [6:0] TSZB_sig
	
	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z0) ,	// output  bit_ZW_Pattern_zone0__sig
	.bit_ZW_NearSource_zone0_(bit_ZW_NearSource_S1Z0) 	// output  bit_ZW_NearSource_zone0__sig
);

//Side1Zone1
//----------
OneSideZone Side1Zone1
(
	.Rows0(TPsfromCB0_[107:99]) ,	// input [8:0] Rows12_sig
	
	.Rows1(TPsfromCB0_[134:126]) ,	// input [8:0] Rows13_sig
	.Rows2(TPsfromCB0_[143:135]) ,	// input [8:0] Rows14_sig
	
	.Rows3(TPsfromCB0_[170:162]) ,	// input [8:0] Rows15_sig
	.Rows4(TPsfromCB0_[179:171]) ,	// input [8:0] Rows16_sig
	
	.Rows5(TPsfromCB0_[206:198]) ,	// input [8:0] Rows17_sig
	.Rows6(TPsfromCB0_[215:207]) ,	// input [8:0] Rows18_sig
	
	.Rows7(TPsfromCB0_[242:234]) ,	// input [8:0] Rows19_sig
	.Rows8(TPsfromCB0_[251:243]) ,	// input [8:0] Rows8_sig
	
	.Rows9(TPsfromCB0_[278:270]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB0_[287:279]) ,	// input [8:0] Rows10_sig
	
	.Rows11(TPsfromCB0_[314:306]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB0_[323:315]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB0_[350:342]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB0_[359:351]) ,	// input [8:0] Rows14_sig
	
	.Rows15(TPsfromCB0_[386:378]) ,	// input [8:0] Rows15_sig
	.Rows16(TPsfromCB0_[395:387]) ,	// input [8:0] Rows16_sig
	
	.Rows17(TPsfromCB0_[422:414]) ,	// input [8:0] Rows17_sig
	.Rows18(TPsfromCB0_[431:423]) ,	// input [8:0] Rows18_sig
	
	.Rows19(TPsfromCB0_[458:450]) ,	// input [8:0] Rows19_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),
	
	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
		
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z1_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z1_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z1_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z1_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z1_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z1_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z1_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z1_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z1_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z1_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S1Z1_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z1) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S1Z1) 	// output  bit_ZW_NearSource_zone__sig
);

//Side1Zone2
//----------
OneSideZone Side1Zone2
(
	.Rows0(TPsfromCB0_[323:315]) ,	// input [8:0] Rows12_sig
	
	.Rows1(TPsfromCB0_[350:342]) ,	// input [8:0] Rows13_sig
	.Rows2(TPsfromCB0_[359:351]) ,	// input [8:0] Rows14_sig
	
	.Rows3(TPsfromCB0_[386:378]) ,	// input [8:0] Rows15_sig
	.Rows4(TPsfromCB0_[395:387]) ,	// input [8:0] Rows16_sig
	
	.Rows5(TPsfromCB0_[422:414]) ,	// input [8:0] Rows17_sig
	.Rows6(TPsfromCB0_[431:423]) ,	// input [8:0] Rows18_sig
	
	.Rows7(TPsfromCB0_[458:450]) ,	// input [8:0] Rows19_sig
	.Rows8(TPsfromCB0_[467:459]) ,	// input [8:0] Rows8_sig

	.Rows9(TPsfromCB0_[494:486]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB0_[503:495]) ,	// input [8:0] Rows10_sig
	
	.Rows11(TPsfromCB0_[530:522]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB0_[539:531]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB0_[566:558]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB0_[575:567]) ,
	
	.Rows15(TPsfromCB0_[602:594]) ,	// input [8:0] Rows15_sig
	.Rows16(TPsfromCB0_[611:603]) ,	// input [8:0] Rows16_sig
	
	.Rows17(TPsfromCB0_[638:630]) ,	// input [8:0] Rows17_sig
	.Rows18(TPsfromCB0_[647:639]) ,	// input [8:0] Rows18_sig
	
	.Rows19(TPsfromCB0_[674:666]) ,	// input [8:0] Rows19_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z2_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z2_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z2_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z2_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z2_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z2_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z2_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z2_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z2_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z2_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S1Z2_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z2) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S1Z2) 	// output  bit_ZW_NearSource_zone__sig
);

//Side1Zone3
//----------
OneSideZone Side1Zone3
(
	.Rows0(TPsfromCB0_[539:531]) ,	// input [8:0] Rows12_sig
	
	.Rows1(TPsfromCB0_[566:558]) ,	// input [8:0] Rows13_sig
	.Rows2(TPsfromCB0_[575:567]) ,
	
	.Rows3(TPsfromCB0_[602:594]) ,	// input [8:0] Rows15_sig
	.Rows4(TPsfromCB0_[611:603]) ,	// input [8:0] Rows16_sig
	
	.Rows5(TPsfromCB0_[638:630]) ,	// input [8:0] Rows17_sig
	.Rows6(TPsfromCB0_[647:639]) ,	// input [8:0] Rows18_sig
	
	.Rows7(TPsfromCB0_[674:666]) ,	// input [8:0] Rows19_sig
	.Rows8(TPsfromCB0_[683:675]) ,	// input [8:0] Rows8_sig
	
	.Rows9(TPsfromCB1_[26:18]) ,	// input [8:0] Rows7_sig
	.Rows10(TPsfromCB1_[35:27]) ,	// input [8:0] Rows8_sig
	
	.Rows11(TPsfromCB1_[62:54]) ,	// input [8:0] Rows9_sig
	.Rows12(TPsfromCB1_[71:63]) ,	// input [8:0] Rows10_sig
	
	.Rows13(TPsfromCB1_[98:90]) ,	// input [8:0] Rows11_sig
	.Rows14(TPsfromCB1_[107:99]) ,	// input [8:0] Rows12_sig
	
	.Rows15(TPsfromCB1_[134:126]) ,	// input [8:0] Rows13_sig
	.Rows16(TPsfromCB1_[143:135]) ,	// input [8:0] Rows14_sig
	
	.Rows17(TPsfromCB1_[170:162]) ,	// input [8:0] Rows15_sig
	.Rows18(TPsfromCB1_[179:171]) ,	// input [8:0] Rows16_sig
	
	.Rows19(TPsfromCB1_[206:198]) ,	// input [8:0] Rows17_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z3_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z3_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z3_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z3_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z3_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z3_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z3_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z3_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z3_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z3_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S1Z3_) ,	// output [6:0] TSZB_sig
	
	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z3) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S1Z3) 	// output  bit_ZW_NearSource_zone__sig
);
				
//Side1Zone4
//----------
OneSideZone Side1Zone4
(
	.Rows0(TPsfromCB1_[71:63]) ,	// input [8:0] Rows10_sig
	
	.Rows1(TPsfromCB1_[98:90]) ,	// input [8:0] Rows11_sig
	.Rows2(TPsfromCB1_[107:99]) ,	// input [8:0] Rows12_sig
	
	.Rows3(TPsfromCB1_[134:126]) ,	// input [8:0] Rows13_sig
	.Rows4(TPsfromCB1_[143:135]) ,	// input [8:0] Rows14_sig
	
	.Rows5(TPsfromCB1_[170:162]) ,	// input [8:0] Rows15_sig
	.Rows6(TPsfromCB1_[179:171]) ,	// input [8:0] Rows16_sig
	
	.Rows7(TPsfromCB1_[206:198]) ,	// input [8:0] Rows17_sig		
	.Rows8(TPsfromCB1_[215:207]) ,	// input [8:0] Rows8_sig
	
	.Rows9(TPsfromCB1_[242:234]) ,	// input [8:0] Rows9_sig
	.Rows10(TPsfromCB1_[251:243]) ,	// input [8:0] Rows10_sig
	
	.Rows11(TPsfromCB1_[278:270]) ,	// input [8:0] Rows11_sig
	.Rows12(TPsfromCB1_[287:279]) ,	// input [8:0] Rows12_sig
	
	.Rows13(TPsfromCB1_[314:306]) ,	// input [8:0] Rows13_sig
	.Rows14(TPsfromCB1_[323:315]) ,

					.Rows15(TPsfromCB1_[350:342]) ,	// input [8:0] Rows15_sig
					
	.Rows16(TPsfromCB1_[386:378]) ,	// input [8:0] Rows3_sig
	.Rows17(TPsfromCB1_[395:387]) ,	// input [8:0] Rows4_sig
	
	.Rows18(TPsfromCB1_[422:414]) ,	// input [8:0] Rows5_sig
	.Rows19(TPsfromCB1_[431:423]) ,	// input [8:0] Rows6_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),
	
	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig

	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z4_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z4_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z4_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z4_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z4_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z4_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z4_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z4_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z4_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z4_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S1Z4_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z4) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S1Z4) 	// output  bit_ZW_NearSource_zone__sig
);

//Side1Zone5
//----------	
OneSideZone Side1Zone5
(
	.Rows0(9'b000000000) ,	// input [8:0] Rows12_sig	

	.Rows1(TPsfromCB1_[287:279]) ,	// input [8:0] Rows12_sig
	
	.Rows2(TPsfromCB1_[314:306]) ,	// input [8:0] Rows13_sig
	.Rows3(TPsfromCB1_[323:315]) ,

			.Rows4(TPsfromCB1_[350:342]) ,	// input [8:0] Rows15_sig
					
	.Rows5(TPsfromCB1_[386:378]) ,	// input [8:0] Rows3_sig
	.Rows6(TPsfromCB1_[395:387]) ,	// input [8:0] Rows4_sig
	
	.Rows7(TPsfromCB1_[422:414]) ,	// input [8:0] Rows5_sig
	.Rows8(TPsfromCB1_[431:423]) ,	// input [8:0] Rows6_sig

	.Rows9(TPsfromCB1_[458:450]) ,	// input [8:0] Rows0_sig
	.Rows10(TPsfromCB1_[467:459]) ,	// input [8:0] Rows8_sig

	.Rows11(TPsfromCB1_[494:486]) ,	// input [8:0] Rows9_sig
	.Rows12(TPsfromCB1_[503:495]) ,	// input [8:0] Rows10_sig
	
	.Rows13(TPsfromCB1_[530:522]) ,	// input [8:0] Rows11_sig
	.Rows14(TPsfromCB1_[539:531]) ,	// input [8:0] Rows12_sig
	
	.Rows15(TPsfromCB1_[566:558]) ,	// input [8:0] Rows13_sig
	.Rows16(TPsfromCB1_[575:567]) ,
	
	.Rows17(TPsfromCB1_[602:594]) ,	// input [8:0] Rows15_sig
	.Rows18(TPsfromCB1_[611:603]) ,	// input [8:0] Rows16_sig
	
	.Rows19(TPsfromCB1_[638:630]) ,	// input [8:0] Rows17_sig
	
	.zone0(1'b0),.zone5(1'b1),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z5_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z5_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z5_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z5_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z5_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z5_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z5_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z5_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z5_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z5_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB_zone5_(TSZB_S1Z5_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z5) ,	// output  bit_ZW_Pattern_zone5__sig
	.bit_ZW_NearSource_zone5_(bit_ZW_NearSource_S1Z5) 	// output  bit_ZW_NearSource_zone5__sig
);
	
//Side1Zone6
//----------
OneSideZone Side1Zone6
(
	.Rows0(TPsfromCB1_[503:495]) ,	// input [8:0] Rows10_sig
	
	.Rows1(TPsfromCB1_[530:522]) ,	// input [8:0] Rows11_sig
	.Rows2(TPsfromCB1_[539:531]) ,	// input [8:0] Rows12_sig
	
	.Rows3(TPsfromCB1_[566:558]) ,	// input [8:0] Rows13_sig
	.Rows4(TPsfromCB1_[575:567]) ,
	
	.Rows5(TPsfromCB1_[602:594]) ,	// input [8:0] Rows15_sig
	.Rows6(TPsfromCB1_[611:603]) ,	// input [8:0] Rows16_sig
	
	.Rows7(TPsfromCB1_[638:630]) ,	// input [8:0] Rows17_sig
	.Rows8(TPsfromCB1_[647:639]) ,	// input [8:0] Rows17_sig

	.Rows9(TPsfromCB1_[674:666]) ,	// input [8:0] Rows19_sig	
	.Rows10(TPsfromCB1_[683:675]) ,	// input [8:0] Rows8_sig

	.Rows11(TPsfromCB2_[26:18]) ,	// input [8:0] Rows10_sig
	.Rows12(TPsfromCB2_[35:27]) ,	// input [8:0] Rows11_sig

	.Rows13(TPsfromCB2_[62:54]) ,	// input [8:0] Rows10_sig	
	.Rows14(TPsfromCB2_[71:63]) ,	// input [8:0] Rows10_sig	
	
	.Rows15(TPsfromCB2_[98:90]) ,	// input [8:0] Rows11_sig
	.Rows16(TPsfromCB2_[107:99]) ,	// input [8:0] Rows12_sig	

	.Rows17(TPsfromCB2_[134:126]) ,	// input [8:0] Rows13_sig
	.Rows18(TPsfromCB2_[143:135]) ,	// input [8:0] Rows14_sig	

	.Rows19(TPsfromCB2_[170:162]) ,	// input [8:0] Rows15_sig
		
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig

	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z6_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z6_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z6_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z6_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z6_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z6_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z6_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z6_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z6_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z6_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S1Z6_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z6) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S1Z6) 	// output  bit_ZW_NearSource_zone__sig
);
					
//Side1Zone7
//----------
OneSideZone Side1Zone7			
(
	.Rows0(TPsfromCB2_[35:27]) ,	// input [8:0] Rows11_sig

	.Rows1(TPsfromCB2_[62:54]) ,	// input [8:0] Rows10_sig	
	.Rows2(TPsfromCB2_[71:63]) ,	// input [8:0] Rows10_sig	
	
	.Rows3(TPsfromCB2_[98:90]) ,	// input [8:0] Rows11_sig
	.Rows4(TPsfromCB2_[107:99]) ,	// input [8:0] Rows12_sig	

	.Rows5(TPsfromCB2_[134:126]) ,	// input [8:0] Rows13_sig
	.Rows6(TPsfromCB2_[143:135]) ,	// input [8:0] Rows14_sig	

	.Rows7(TPsfromCB2_[170:162]) ,	// input [8:0] Rows15_sig
	.Rows8(TPsfromCB2_[179:171]) ,	// input [8:0] Rows16_sig		
	
	.Rows9(TPsfromCB2_[206:198]) ,	// input [8:0] Rows16_sig
	.Rows10(TPsfromCB2_[215:207]) ,	// input [8:0] Rows8_sig
	
	.Rows11(TPsfromCB2_[242:234]) ,	// input [8:0] Rows10_sig	
	.Rows12(TPsfromCB2_[251:243]) ,	// input [8:0] Rows10_sig
	
	.Rows13(TPsfromCB2_[278:270]) ,	// input [8:0] Rows11_sig
	.Rows14(TPsfromCB2_[287:279]) ,	// input [8:0] Rows12_sig
	
	.Rows15(TPsfromCB2_[314:306]) ,	// input [8:0] Rows13_sig
	.Rows16(TPsfromCB2_[323:315]) ,

	.Rows17(TPsfromCB2_[350:342]) ,	// input [8:0] Rows15_sig
	.Rows18(TPsfromCB2_[359:351]) ,	// input [8:0] Rows15_sig
					
	.Rows19(TPsfromCB2_[386:378]) ,	// input [8:0] Rows3_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0),
	
	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig

	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z7_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z7_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z7_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z7_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z7_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z7_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z7_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z7_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z7_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z7_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S1Z7_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z7) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S1Z7) 	// output  bit_ZW_NearSource_zone__sig
);

//Side1Zone8
//----------
OneSideZone Side1Zone8
(
	.Rows0(TPsfromCB2_[251:243]) ,	// input [8:0] Rows10_sig
	
	.Rows1(TPsfromCB2_[278:270]) ,	// input [8:0] Rows11_sig
	.Rows2(TPsfromCB2_[287:279]) ,	// input [8:0] Rows12_sig
	
	.Rows3(TPsfromCB2_[314:306]) ,	// input [8:0] Rows13_sig
	.Rows4(TPsfromCB2_[323:315]) ,

	.Rows5(TPsfromCB2_[350:342]) ,	// input [8:0] Rows15_sig
	.Rows6(TPsfromCB2_[359:351]) ,	// input [8:0] Rows15_sig
					
	.Rows7(TPsfromCB2_[386:378]) ,	// input [8:0] Rows3_sig
	.Rows8(TPsfromCB2_[395:387]) ,	// input [8:0] Rows4_sig
	
	.Rows9(TPsfromCB2_[422:414]) ,	// input [8:0] Rows5_sig
	.Rows10(TPsfromCB2_[431:423]) ,	// input [8:0] Rows6_sig	
		
	.Rows11(TPsfromCB2_[458:450]) ,	// input [8:0] Rows5_sig		
	.Rows12(TPsfromCB2_[467:459]) ,	// input [8:0] Rows6_sig

	.Rows13(TPsfromCB2_[494:486]) ,	// input [8:0] Rows9_sig
	.Rows14(TPsfromCB2_[503:495]) ,	// input [8:0] Rows9_sig

	.Rows15(TPsfromCB2_[530:522]) ,	// input [8:0] Rows9_sig
	.Rows16(TPsfromCB2_[539:531]) ,	// input [8:0] Rows9_sig
	
	.Rows17(TPsfromCB2_[566:558]) ,	// input [8:0] Rows10_sig	
	.Rows18(TPsfromCB2_[575:567]) ,	// input [8:0] 
	
	.Rows19(TPsfromCB2_[602:594]) ,	// input [8:0] 
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b0) ,	
	
	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z8_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z8_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z8_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z8_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z8_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z8_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z8_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z8_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z8_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z8_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB(TSZB_S1Z8_) ,	// output [6:0] TSZB_sig

	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z8) ,	// output  bit_ZW_Pattern_zone__sig
	.bit_ZW_NearSource_zone_(bit_ZW_NearSource_S1Z8) 	// output  bit_ZW_NearSource_zone__sig
);

//Side1Zone9
//----------			
OneSideZone Side1Zone9
(	
	.Rows0(TPsfromCB2_[467:459]) ,	// input [8:0] Rows6_sig

	.Rows1(TPsfromCB2_[494:486]) ,	// input [8:0] Rows9_sig
	.Rows2(TPsfromCB2_[503:495]) ,	// input [8:0] Rows9_sig

	.Rows3(TPsfromCB2_[530:522]) ,	// input [8:0] Rows9_sig
	.Rows4(TPsfromCB2_[539:531]) ,	// input [8:0] Rows9_sig
	
	.Rows5(TPsfromCB2_[566:558]) ,	// input [8:0] Rows10_sig	
	.Rows6(TPsfromCB2_[575:567]) ,	// input [8:0] 
		
	.Rows7(TPsfromCB2_[602:594]) ,	// input [8:0] Rows12_sig	
	.Rows8(TPsfromCB2_[611:603]) ,	// input [8:0] Rows13_sig		
	
	.Rows9(TPsfromCB2_[638:630]) ,	// input [8:0] Rows5_sig
	.Rows10(TPsfromCB2_[647:639]) ,	// input [8:0] Rows5_sig
		
	.Rows11(TPsfromCB2_[674:666]) ,	// input [8:0] Rows3_sig
	.Rows12(TPsfromCB2_[683:675]) ,	// input [8:0] Rows18_sig	
	
	.Rows13(9'b000000000) ,	// input [8:0] Rows0_sig	
	.Rows14(9'b000000000) ,	// input [8:0] Rows1_sig
	.Rows15(9'b000000000) ,	// input [8:0] Rows2_sig	
	.Rows16(9'b000000000) ,	// input [8:0] Rows3_sig
	.Rows17(9'b000000000) ,	// input [8:0] Rows4_sig
	.Rows18(9'b000000000) ,	// input [8:0] Rows5_sig
	.Rows19(9'b000000000) ,	// input [8:0] Rows6_sig
	
	.zone0(1'b0),.zone5(1'b0),.zone9(1'b1),

	.clock40(clock40) ,	// input  clock40_sig
	.n_rst(n_rst) ,	// input  n_rst_sig
	
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// input  ZoneBuilding_enable
	.projection_OK(projection_OK) ,	// input  projection_OK
	
//	.ZoneBuilding_enable(1'b1) ,	// input  ZoneBuilding_enable
//	.projection_OK(1'b1) ,	// input  projection_OK
	
	.PR_SZA(PR_SZA_S1Z9_) ,	// output [7:0] 
	.PR_SZB(PR_SZB_S1Z9_) ,	// output [7:0] 
	.PR_SZC(PR_SZC_S1Z9_) ,	// output [7:0] 
	.PR_SZD(PR_SZD_S1Z9_) ,	// output [7:0] 
	.PL_SZA(PL_SZA_S1Z9_) ,	// output [8:0] 
	.PL_SZB(PL_SZB_S1Z9_) ,	// output [8:0] 
	.PL_SZC(PL_SZC_S1Z9_) ,	// output [8:0] 
	.PL_SZD(PL_SZD_S1Z9_) ,	// output [8:0]
	
	.VSZB(VSZB_S1Z9_) ,	// output [7:0] 
	.HSZB(HSZB_S1Z9_) ,	// output [7:0] 
	
	.VTSZ() ,	// output [1:0]
	
	.HTSZ_int() ,	// output [2:0] 
	.HTSZ_outmem4() ,	// output [2:0] 
	.HTSZ_outmem5() ,	// output [2:0]
	
	.HTSZ() ,	// output [2:0] 
	
	.NSZ_L() ,	// output  
	.NSZ_R() , 	// output

	.TSZB_zone9_(TSZB_S1Z9_) ,	// output [6:0] TSZB_sig
	.bit_ZW_Pattern_zone_(bit_ZW_Pattern_S1Z9) ,	// output  bit_ZW_Pattern_zone9__sig
	.bit_ZW_NearSource_zone9_(bit_ZW_NearSource_S1Z9) 	// output  bit_ZW_NearSource_zone9__sig		
);

//-----------------------------------------------------
//-----------------------------------------------------
//-----------------------------------------------------
//-------------------- zoning words -------------------
//-----------------------------------------------------
//-----------------------------------------------------
//-----------------------------------------------------			
reg [9:0] S0_Zoning_Word_Pattern; 
reg [9:0] S1_Zoning_Word_Pattern;
reg [9:0] S0_Zoning_Word_Near_Source;
reg [9:0] S1_Zoning_Word_Near_Source; 

always @ (posedge clock40 or negedge n_rst)
	begin
		if (!n_rst)
			begin
				S0_Zoning_Word_Pattern <= 10'h000; 
				S1_Zoning_Word_Pattern <= 10'h000;
				S0_Zoning_Word_Near_Source <= 10'h000;
				S1_Zoning_Word_Near_Source <= 10'h000; 
			end
		else
			begin	
				S0_Zoning_Word_Pattern <= {bit_ZW_Pattern_S0Z0,bit_ZW_Pattern_S0Z1,bit_ZW_Pattern_S0Z2,
														 bit_ZW_Pattern_S0Z3,bit_ZW_Pattern_S0Z4,bit_ZW_Pattern_S0Z5,
														 bit_ZW_Pattern_S0Z6,bit_ZW_Pattern_S0Z7,bit_ZW_Pattern_S0Z8,
														 bit_ZW_Pattern_S0Z9};  
				S1_Zoning_Word_Pattern <= {bit_ZW_Pattern_S1Z0,bit_ZW_Pattern_S1Z1,bit_ZW_Pattern_S1Z2,
														 bit_ZW_Pattern_S1Z3,bit_ZW_Pattern_S1Z4,bit_ZW_Pattern_S1Z5,
														 bit_ZW_Pattern_S1Z6,bit_ZW_Pattern_S1Z7,bit_ZW_Pattern_S1Z8,
														 bit_ZW_Pattern_S1Z9}; 
				S0_Zoning_Word_Near_Source <=  {bit_ZW_NearSource_S0Z0,bit_ZW_NearSource_S0Z1,bit_ZW_NearSource_S0Z2,
														 bit_ZW_NearSource_S0Z3,bit_ZW_NearSource_S0Z4,bit_ZW_NearSource_S0Z5,
														 bit_ZW_NearSource_S0Z6,bit_ZW_NearSource_S0Z7,bit_ZW_NearSource_S0Z8,
														 bit_ZW_NearSource_S0Z9}; 
				S1_Zoning_Word_Near_Source <=  {bit_ZW_NearSource_S1Z0,bit_ZW_NearSource_S1Z1,bit_ZW_NearSource_S1Z2,
														 bit_ZW_NearSource_S1Z3,bit_ZW_NearSource_S1Z4,bit_ZW_NearSource_S1Z5,
														 bit_ZW_NearSource_S1Z6,bit_ZW_NearSource_S1Z7,bit_ZW_NearSource_S1Z8,
														 bit_ZW_NearSource_S1Z9};  
			end
	end


endmodule






