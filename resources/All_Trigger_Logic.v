
// All_Trigger_Logic.v

//-----------------------------------------------------------------------
//-
//- Entity name : All_Trigger_Logic
//-
//-----------------------------------------------------------------------

`define DEBUG_DATA_SIZE_LSB 16'h6C
`define DEBUG_DATA_SIZE_MSB 16'h02

`define DAQ_DATA_SIZE_LSB 16'h2C
`define DAQ_DATA_SIZE_MSB 16'h01

module All_Trigger_Logic(

//Link With 6 ControlBooard		(datas)
							clk40_To_FPGA,
							TP_synchro_clock,
							//DataReceiv


							DataReceivfrom_calo_0,
							DataReceivfrom_calo_1,
							DataReceivfrom_calo_2,


							DataReceivLSB_from_tracker_0,
							DataReceivMSB_from_tracker_0,

							DataReceivLSB_from_tracker_1,
							DataReceivMSB_from_tracker_1,

							DataReceivLSB_from_tracker_2,
							DataReceivMSB_from_tracker_2,

							//DataTransmit
							DataTransto_CB_0_,
							DataTransto_CB_1_,
							DataTransto_CB_2_,
							DataTransto_CB_3_,
							DataTransto_CB_4_,
							DataTransto_CB_5_,

							Clock_To_Serdes_LSB_CB,
							Clock_To_Serdes_MSB_CB,


							out_sync,

//interface with partition Jihane

							n_reset_all_fpga,
							n_global_reset,
							n_poweron_reset,


//userdata sources from user
						  lpbus_clk,


							datafrom_testlinkfifo,
							datafrom_eventbuffer,

							n_read_eventbuffer,
							n_read_testlinkfifo,
							read_req_from_eventbuffer,
							sel_readout_for_eventbuffer,

							n_init_seqrd_Monitoring_Test_LinkFIFO,
							sync_out_to_all_systems,
							synchro_from_TB,

	//one byte regs

							Debug_reg,
							Coincidence_Window_width_reg,
							CB_Mask_Reg,

// two bytes regs
							SetUp_reg,
							n_Reset_reg,


							error,
							L1_Calo,
							L2_Tracker,
							external_trig,


							receiving_TP_from_Calo,
							receiving_TP_from_Tracker,
// test for debug
						   test_for_debug



);


input clk40_To_FPGA;
input TP_synchro_clock;

//------------------------------------------------------------
//------------------------------------------------------------
//----- Link with the 6 ControlBoard	Front Panel(datas) ----
//------------------------------------------------------------
//------------------------------------------------------------
input  [17:0]	DataReceivfrom_calo_0, DataReceivfrom_calo_1, DataReceivfrom_calo_2; // from calo crates
input  [17:0]	DataReceivLSB_from_tracker_0,DataReceivMSB_from_tracker_0;
input  [17:0]  DataReceivLSB_from_tracker_1,DataReceivMSB_from_tracker_1;
input  [17:0]	DataReceivLSB_from_tracker_2,DataReceivMSB_from_tracker_2;




output [17:0]	DataTransto_CB_0_,DataTransto_CB_1_,DataTransto_CB_2_;
output [17:0]	DataTransto_CB_3_,DataTransto_CB_4_,DataTransto_CB_5_;
output [5:0]	Clock_To_Serdes_LSB_CB,Clock_To_Serdes_MSB_CB;

//------------------------------------------------------------
//------------------------------------------------------------
//----- TriggerBoard  ControlBoard  Backplane Interface ------
//------------------------------------------------------------
//------------------------------------------------------------

output			out_sync;


//------------------------------------------------------------
//------------------------------------------------------------
//----- Interface with partition Jihane   ----
//------------------------------------------------------------
//------------------------------------------------------------

input			n_read_testlinkfifo;

input			n_init_seqrd_Monitoring_Test_LinkFIFO;


input [7:0]		Debug_reg;
input [7:0] 	Coincidence_Window_width_reg;
input [7:0]	   CB_Mask_Reg;


input [15:0]	n_Reset_reg;
input [15:0]	SetUp_reg;

input 	sync_out_to_all_systems;
input 	synchro_from_TB;

input		n_reset_all_fpga;
input 	n_global_reset;
input 	n_poweron_reset;


//INPUTS

output [7:0] 		datafrom_testlinkfifo;
output [7:0] 		datafrom_eventbuffer;

input			      n_read_eventbuffer;
input 				sel_readout_for_eventbuffer;
output		      read_req_from_eventbuffer;


//User interface


input lpbus_clk;

input external_trig;

// for LEDs;

output error;
output L1_Calo;
output L2_Tracker;
output receiving_TP_from_Calo;
output receiving_TP_from_Tracker;


output [15:0]test_for_debug;

//------------------------------------------------------------
//------------------------------------------------------------
//------- Link With 6 ControlBooard	Front Panel(datas) -------
//------------------------------------------------------------

wire	[5:0]		RcdClk_RcvDatLSB_fromCB_;


wire  [17:0]	DataReceivfrom_calo_0, DataReceivfrom_calo_1, DataReceivfrom_calo_2; // from calo crates
wire  [17:0]	DataReceivLSB_from_tracker_0,DataReceivMSB_from_tracker_0;
wire  [17:0]   DataReceivLSB_from_tracker_1,DataReceivMSB_from_tracker_1;
wire  [17:0]	DataReceivLSB_from_tracker_2,DataReceivMSB_from_tracker_2;

wire	[5:0]		RcdClk_RcvDatMSB_fromCB_;

reg 	[17:0]	DataTransto_CB_0_int,DataTransto_CB_1_int,DataTransto_CB_2_int;
reg 	[17:0]	DataTransto_CB_3_int,DataTransto_CB_4_int,DataTransto_CB_5_int;

reg 	[17:0]	DataTransto_CB_0_,DataTransto_CB_1_,DataTransto_CB_2_;
reg 	[17:0]	DataTransto_CB_3_,DataTransto_CB_4_,DataTransto_CB_5_;

wire 	[5:0]		Clock_To_Serdes_LSB_CB,Clock_To_Serdes_MSB_CB;

//------------------------------------------------------------
//------------------------------------------------------------
//----- TriggerBoard  ControlBoard  Backplane Interface -----
//------------------------------------------------------------
//------------------------------------------------------------

wire				refclk_DataTransto_CB;


//------------------------------------------------------------
//------------------------------------------------------------
//----------------------- out_sync ---------------------------
//------------------------------------------------------------
//------------------------------------------------------------

wire 		[4:0]		view_sync;
//------------------------------------------------------------
//------------------------------------------------------------
//- STREAMING - STREAMING - STREAMING - STREAMING - STREAMING
//------------------------------------------------------------
//------------------------------------------------------------
wire 	[9:0] 	view_CB0_,view_CB1_,view_CB2_;
wire 	[19:0] 	view_error;
//------------------------------------------------------------
//------------------------------------------------------------
//--- CALORIMETER - CALORIMETER - CALORIMETER - CALORIMETER --
//------------------------------------------------------------
//------------------------------------------------------------
wire [31:0]	CaloRecordBitset_;
wire [31:0]	CaloRecordBitsetMoins1_,CaloRecordBitsetMoins2_,CaloRecordBitsetMoins3_;
wire [34:0]	CaloSummaryRecordBitset_;

wire [31:0]	CaloRecordBitset_fromFifo;
wire [31:0]	CaloRecordBitsetNow_fromFifo,CaloRecordBitsetMoins1_fromFifo;
wire [31:0]	CaloRecordBitsetMoins2_fromFifo,CaloRecordBitsetMoins3_fromFifo;
wire [39:0] CaloSummaryRecordBitset_fromFifo;


wire  		CaloDecision;
wire			SScoinc;
wire			TTM;
//------------------------------------------------------------
//------------------------------------------------------------
//- TRACKER - TRACKER - TRACKER - TRACKER - TRACKER - TRACKER
//------------------------------------------------------------
//------------------------------------------------------------
//TPsfromCB*
//----------
//CB0
//---
wire 	[683:0]	TPsfromCB0FromStreaming_;
wire 	[683:0]	TPsfromCB1FromStreaming_;
wire 	[683:0]	TPsfromCB2FromStreaming_;

//----------------------------------------------
//-- Sliding Zone and Projection Construction --
//----------------------------------------------
wire [9:0] S0_Zoning_Word_Pattern,S1_Zoning_Word_Pattern;
wire [9:0] S0_Zoning_Word_Near_Source,S1_Zoning_Word_Near_Source;

wire [6:0] TSZB_S0Z0_,TSZB_S0Z1_,TSZB_S0Z2_,TSZB_S0Z3_,TSZB_S0Z4_,TSZB_S0Z5_,
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

wire	projection_OK,compute_tracker_OK;

wire	APE_Decision, DAVE_Decision;

//to link:
//--------

wire  [17:0]	DataReceivfrom_calo_0_sync, DataReceivfrom_calo_1_sync, DataReceivfrom_calo_2_sync; // from calo crates
wire  [17:0]	DataReceivLSB_from_tracker_0_sync,DataReceivMSB_from_tracker_0_sync;
wire  [17:0]   DataReceivLSB_from_tracker_1_sync,DataReceivMSB_from_tracker_1_sync;
wire  [17:0]	DataReceivLSB_from_tracker_2_sync,DataReceivMSB_from_tracker_2_sync;

wire error_clock800Id_allCBtoTB;

wire [14:0]		clock800Id_TB;
//------------------------------------------------------------
//------------------------------------------------------------


//------------------------------------------------------------
//------------------------------------------------------------
//----- Interface with partition Jihane   ----
//------------------------------------------------------------
//------------------------------------------------------------



//outputs

reg [7:0] 		datafrom_testlinkfifo;
wire [7:0] 		datafrom_testlinkfifo_int;
wire [7:0] 		datafrom_eventbuffer;

//------------------------------------------------------------
//------------------------------------------------------------

reg receiving_TP_from_Calo;
reg receiving_TP_from_Tracker;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin
  if (~n_reset_all_fpga) begin
			receiving_TP_from_Calo 	  <= 1'b0;
			receiving_TP_from_Tracker <= 1'b0;
		end
  else begin
			receiving_TP_from_Calo 	  <= receiving_TP_from_Calo_int;
			receiving_TP_from_Tracker <= receiving_TP_from_Tracker_int;
		 end
  end

assign  receiving_TP_from_Calo_int = (|DataReceivfrom_calo_0_sync[17:0]) || (|DataReceivfrom_calo_1_sync[17:0]) || (|DataReceivfrom_calo_2_sync[17:0]);
assign  receiving_TP_from_Tracker_int = (|DataReceivLSB_from_tracker_0_sync[17:0]) || (|DataReceivLSB_from_tracker_1_sync[17:0]) || (|DataReceivLSB_from_tracker_2_sync[17:0]);

assign 		test_for_debug[1]	=	receiving_TP_from_Calo;
assign 		test_for_debug[2]	=	Coincidence_Window;
assign 		test_for_debug[3]	=	PER_Gate[0];
assign 		test_for_debug[4] 	=  CARACO_Decision;
assign 		test_for_debug[5] 	=  CARACO_Decision_Gate;
assign 		test_for_debug[6] 	=  APE_Decision;
assign 		test_for_debug[7] 	=  memo_PER;
assign 		test_for_debug[8] 	=  CaloDecision;
assign 		test_for_debug[9] 	=  counter40Mhz_enable;
assign 		test_for_debug[10] 	=  view_CB0_[8];
assign 		test_for_debug[11] 	=  DAVE_Decision; //CaloSummaryRecordBitset[3];
assign 		test_for_debug[12] 	=  rden_EmulCTWsFifo;
assign 		test_for_debug[13] 	=  L2_Decision;
assign 		test_for_debug[14] 	=  L2_memo;
assign 		test_for_debug[15] 	=  clock1600;

//------------------------------------------------------------
//------------------------------------------------------------

assign	n_rst_phaser =  n_reset_all_fpga && n_Reset_reg[6];

assign	Clock_To_Serdes_LSB_CB 	= 	({clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA});
assign	Clock_To_Serdes_MSB_CB 	= 	({clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA,clk40_To_FPGA});



reg enable_acquisition;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin
  if (~n_reset_all_fpga)
		enable_acquisition <= 1'b0;
  else
	   enable_acquisition <= SetUp_reg[0];
end



//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
// Synchro Reveived Data From Control Boards -----------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------


// CALO TRIGGER DATA

Serdes_Sync_Input_v2 m_synchro_data_from_calo_0(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[0]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),

	 .datain_from_serdes(DataReceivfrom_calo_0),
	 .datain_from_serdes_synchro(DataReceivfrom_calo_0_sync)

	 );

Serdes_Sync_Input_v2 m_synchro_data_from_calo_1(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[1]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),
	 .datain_from_serdes(DataReceivfrom_calo_1),
	 .datain_from_serdes_synchro(DataReceivfrom_calo_1_sync)

	 );

Serdes_Sync_Input_v2 m_synchro_data_from_calo_2(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[2]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),
	 .datain_from_serdes(DataReceivfrom_calo_2),
	 .datain_from_serdes_synchro(DataReceivfrom_calo_2_sync)

	 );

// TRACKER TRIGGER DATA LSB & MSB
//---
Serdes_Sync_Input_v2 m_synchro_data_LSB_from_tracker_0(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[3]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),
	 .datain_from_serdes(DataReceivLSB_from_tracker_0),
	 .datain_from_serdes_synchro(DataReceivLSB_from_tracker_0_sync)

	 );

Serdes_Sync_Input_v2 m_synchro_data_LSB_from_tracker_1(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[4]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),
	 .datain_from_serdes(DataReceivLSB_from_tracker_1),
	 .datain_from_serdes_synchro(DataReceivLSB_from_tracker_1_sync)

	 );

Serdes_Sync_Input_v2 m_synchro_data_LSB_from_tracker_2(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[5]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),
	 .datain_from_serdes(DataReceivLSB_from_tracker_2),
	 .datain_from_serdes_synchro(DataReceivLSB_from_tracker_2_sync)

	 );
 Serdes_Sync_Input_v2 m_synchro_data_MSB_from_tracker_0(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[3]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),

	 .datain_from_serdes(DataReceivMSB_from_tracker_0),
	 .datain_from_serdes_synchro(DataReceivMSB_from_tracker_0_sync)

	 );

Serdes_Sync_Input_v2 m_synchro_data_MSB_from_tracker_1(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[4]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),
	 .datain_from_serdes(DataReceivMSB_from_tracker_1),
	 .datain_from_serdes_synchro(DataReceivMSB_from_tracker_1_sync)

	 );

Serdes_Sync_Input_v2 m_synchro_data_MSB_from_tracker_2(

    .n_reset(n_reset_all_fpga && !CB_Mask_Reg[5]),
	 .system_clk(clk40_To_FPGA),

	 .synchro_clk(TP_synchro_clock),
	 .datain_from_serdes(DataReceivMSB_from_tracker_2),
	 .datain_from_serdes_synchro(DataReceivMSB_from_tracker_2_sync)

	 );


//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//------------- Test Data transmitted to Control Boards -------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
reg [3:0] 	test_counter4Bits;
wire	 		n_stop_test_counter;

assign n_stop_test_counter = n_rst_phaser & n_reset_all_fpga;

always @ (posedge clk40_To_FPGA or negedge n_stop_test_counter)
begin
  if (~n_stop_test_counter)
	test_counter4Bits <= 4'h0;
else
	test_counter4Bits <= test_counter4Bits +1;
end




//------------------------------------------------------------
//------------------------------------------------------------
//- RUN  - RUN  - RUN  - RUN - RUN  - RUN  - RUN  - RUN - RUN
//- RUN  - RUN  - RUN  - RUN - RUN  - RUN  - RUN  - RUN - RUN
//- RUN  - RUN  - RUN  - RUN - RUN  - RUN  - RUN  - RUN - RUN
//- RUN  - RUN  - RUN  - RUN - RUN  - RUN  - RUN  - RUN - RUN
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//-------------- clock 800 clock1600 out_sync ----------------
//------------------------------------------------------------
//------------------------------------------------------------
reg 				counter40Mhz_enable;
wire 	[5:0]		counter40Mhz;
wire 				clock800_TB;
wire	[31:0]	clock800_delayed;
wire 				clock800;
wire 	[7:0] 	clock800_shifted;
reg 				clock1600_TB;
reg				clock1600;

wire	[31:0]	clock1600periodcounter;

assign out_sync = synchro_from_TB;

//out_sync
//--------

/*assign n_rst_sync_reg 	= n_rst_phaser & !clear_bit_sync;


always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin //Clk60 or Clk125  // sync <=> start_process
  if (~n_reset_all_fpga) begin
			dff0_sync_reg[0]	<= 1'b0;
			dff1_sync_reg[0]  <= 1'b0;
			dff2_sync_reg[0]  <= 1'b0;
		  end
  else 	begin
			dff0_sync_reg[0]  <= Sync_reg[0];
			dff1_sync_reg[0]  <= dff0_sync_reg[0];
			dff2_sync_reg[0]  <= dff1_sync_reg[0];
		  end
  end

assign		sync_wire = dff1_sync_reg[0] & !dff2_sync_reg[0];

//clear_bit_register
//------------------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin
  if (~n_reset_all_fpga) begin
			out_sync		<= 1'b0;
			clear_bit_sync		<= 1'b0;
		  end
  else begin
			out_sync 			<= sync_wire;
			clear_bit_sync	 	<= out_sync;
		  end
  end
  */

//counter40Mhz_enable
//-------------------
wire n_stop_counter40Mhz;

//assign n_stop_counter40Mhz = n_rst_phaser & !endof_counter40Mhz_enable
assign n_stop_counter40Mhz = n_rst_phaser;

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser) begin
  if (~n_rst_phaser)
			counter40Mhz_enable 	<= 1'b0;
  else if(synchro_from_TB)
			counter40Mhz_enable 	<= 1'b1;
		  else;
  end

//clock800_TB
//-----------
/*Counter6bits	Counter6bits_inst (			//downcount
	.aclr ( !n_rst_phaser ),
	.clock ( clk40_To_FPGA ),
	.cnt_en ( counter40Mhz_enable ),
	.q ( counter40Mhz )
	);
*/

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)
 begin
  if(~n_rst_phaser)
   counter40Mhz <= 6'b000000;
  else if(counter40Mhz_enable == 1'b0)
   counter40Mhz <= 6'b000000;
  else
   counter40Mhz <= counter40Mhz + 1'b1;

 end


assign	clock800_TB	= counter40Mhz[4];

//clock1600_TB
//------------
always @ (posedge clock800_TB or negedge n_rst_phaser)
begin
  if (~n_rst_phaser)
			clock1600_TB	<= 1'b0;
  else
			clock1600_TB <= !clock1600_TB;
end

//clock800_delayed: to adjust the phase between the frame coming from Control Board and the local clock1600.
//----------------
Shift32cycle	Shift32cycle_inst (
	.aclr ( !n_rst_phaser ),
	.clock ( clk40_To_FPGA ),
	.enable ( 1'b1 ),
	.shiftin ( clock800_TB ),
	.q ( clock800_delayed[31:0] ),
	.shiftout (  )
	);

assign clock800 = clock800_delayed[12];


always @ (posedge clock800 or negedge n_rst_phaser) begin
  if (~n_rst_phaser)
			clock800Id_TB	<= 1'b0;
  else
			clock800Id_TB <= clock800Id_TB + 1'b1;
end


//clock1600_delayed
//-----------------
always @ (posedge clock800 or negedge n_rst_phaser) begin
  if (~n_rst_phaser)
			clock1600	<= 1'b0;
  else
			clock1600 <= !clock1600;
end

//HeaderDetectiontWindow
//----------------------
Shift8bits	Shift8bits_inst (
	.aclr ( !n_rst_phaser ),
	.clock ( clk40_To_FPGA ),
	.shiftin ( clock800 ),
	.q ( clock800_shifted )
	);

wire HeaderDetectiontWindow,TrameDetect_enable;

assign	HeaderDetectiontWindow 	= 	clock800 &	!clock800_shifted[5];
assign	TrameDetect_enable		=	counter40Mhz_enable && clock1600 && HeaderDetectiontWindow;

//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//--- TEST_LINK_CB_TB - TEST_LINK_CB_TB - TEST_LINK_CB_TB ----
//--- TEST_LINK_CB_TB - TEST_LINK_CB_TB - TEST_LINK_CB_TB ----
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
wire	[31:0]	counter40Mhz_enable_shifted;
wire	[35:0]	Test_LinkFIFO;

wire				wren_LinkFIFO_int;
reg				wren_LinkFIFO;

integer			k,i;

//counter40Mhz_enable shifted: to adjust the writing
//of the frame coming from Control Board into LinkFIFO.
//----------------------------------------------------
Shift32cycle	Shift32cycle_inst1 (
	.aclr ( !n_rst_phaser ),
	.clock ( clk40_To_FPGA ),
	.enable ( 1'b1 ),
	.shiftin ( counter40Mhz_enable ),
	.q ( counter40Mhz_enable_shifted[31:0] ),
	.shiftout (  )
	);

wire start_wren_LinkFIFO;

assign	start_wren_LinkFIFO 	= 	counter40Mhz_enable_shifted[14] & !counter40Mhz_enable_shifted[15];

//clock1600periodcounter: to adjust the end of the writing
//of the frame coming from Control Board into LinkFIFO.
//----------------------------------------------------
wire reached_clock1600period;

Counter32bits	Counter32bits_inst (
	.aclr ( !n_rst_phaser ),
	.clk_en ( counter40Mhz_enable ),
	.clock ( clock1600 ),
	.q ( clock1600periodcounter )
	);

assign reached_clock1600period = (clock1600periodcounter == 32'h0000005); // == 5 decimal	*/

//wren_LinkFIFO
//-------------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin
	if (~n_reset_all_fpga)
			wren_LinkFIFO  <= 1'b0;
	else if(reached_clock1600period)
			wren_LinkFIFO	<= 1'b0;
	else if(start_wren_LinkFIFO)
			wren_LinkFIFO	<= 1'b1;
end

//Test_LinkFIFO: To stock the frames coming from the Control Board CB3
//-------------
Test_LinkFIFO	Test_LinkFIFO_inst (		//512 x 36bits
	.aclr ( !n_rst_phaser ),
	.data ( {DataReceivLSB_from_tracker_1_sync[17:0],DataReceivMSB_from_tracker_1_sync[17:0]} ),
	.rdclk ( lpbus_clk ),
	.rdreq ( !n_read_testlinkfifo & !seqrd_Monitoring_Test_LinkFIFO[4] ),
	.wrclk ( clk40_To_FPGA ),
	.wrreq ( wren_LinkFIFO ),
	.q ( Test_LinkFIFO )
	);

reg  [4:0] 	seqrd_Monitoring_Test_LinkFIFO;	//simulated in "TRIGGER_BOARD_SeqSimul" directory.
wire			valid_seqrd_Monitoring_Test_LinkFIFO,n_init_seqrd_Monitoring_Test_LinkFIFO;

assign	valid_seqrd_Monitoring_Test_LinkFIFO	= 	!n_read_testlinkfifo;


always @ (posedge clk40_To_FPGA or negedge n_init_seqrd_Monitoring_Test_LinkFIFO) begin
	if (~n_init_seqrd_Monitoring_Test_LinkFIFO)
		begin
       seqrd_Monitoring_Test_LinkFIFO[0]	 <= 1'b0;
		 seqrd_Monitoring_Test_LinkFIFO[4:1] <= 4'hF;
		end
	else if(valid_seqrd_Monitoring_Test_LinkFIFO)
  	   begin
       seqrd_Monitoring_Test_LinkFIFO[0] <= seqrd_Monitoring_Test_LinkFIFO[4];
		 	for (k=1; k<=4; k=k+1)
				seqrd_Monitoring_Test_LinkFIFO[k] <= seqrd_Monitoring_Test_LinkFIFO[k-1] ;
		end
  end


  always@(n_read_testlinkfifo or datafrom_testlinkfifo_int)
  begin
  if(n_read_testlinkfifo == 1'b0)
	datafrom_testlinkfifo <= datafrom_testlinkfifo_int;
	else
	datafrom_testlinkfifo <= 8'h00;
  end

assign datafrom_testlinkfifo_int[7:0] = !seqrd_Monitoring_Test_LinkFIFO[0]? Test_LinkFIFO[7:0]	:8'hzz;
assign datafrom_testlinkfifo_int[7:0] = !seqrd_Monitoring_Test_LinkFIFO[1]? Test_LinkFIFO[15:8]  :8'hzz;
assign datafrom_testlinkfifo_int[7:0] = !seqrd_Monitoring_Test_LinkFIFO[2]? Test_LinkFIFO[23:16] :8'hzz;
assign datafrom_testlinkfifo_int[7:0] = !seqrd_Monitoring_Test_LinkFIFO[3]? Test_LinkFIFO[31:24] :8'hzz;
assign datafrom_testlinkfifo_int[7:0] = !seqrd_Monitoring_Test_LinkFIFO[4]? {4'h0,Test_LinkFIFO[35:32]} :8'hzz;


//------------------------------------------------------------
//------------------------------------------------------------
//- STREAMING - STREAMING - STREAMING - STREAMING - STREAMING
//- STREAMING - STREAMING - STREAMING - STREAMING - STREAMING
//- STREAMING - STREAMING - STREAMING - STREAMING - STREAMING
//- STREAMING - STREAMING - STREAMING - STREAMING - STREAMING
//------------------------------------------------------------
//------------------------------------------------------------

//------------------------------------------------------------
//------------------------------------------------------------
//------ Reception and verification of the integrity of ------
//------ the frames coming from the 3 Control Board. ---------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//One frame CB -> TB:
/* 3 x 36 bits (en 3 clock ticks):
     - START_FRAME
 * 1 x 36 bits (en 1 clock tick) :
                   - 15 bits : Clock800Id (pair)
                   -   1 bit : ERROR_SYNCHRO_FEB_FRAME
                   -   1 bit : ERROR_CLOCK800ID_FEB
                   -   2 bits : CrateID
                   - 17 bits : spare
 * 2 x 36 bits par FEB (x19):
               - 70 bits :
                    * 10 bits: Spare + Address
                    *   5 bits: HW status
                    * 55 bits: TP
                      - 1 bit (bit #54 : TP_MSB) : OR des bits #0 à #53
                      - en mode 3 fils :
                          - 36 bits (bit #0 à #35)
                          - 18 unused bits (bit #36 à #53)
                       - en mode 2 fils :
                           - 54 bits (bit #0 à #53)
                       * 2 bits: spare
*/

// from Tracker Crates
wire [14:0] clock800CB0toTB_Id,clock800CB1toTB_Id, clock800CB2toTB_Id;




streaming_dataTC streaming_dataTC_inst
(
	.DataReceivLSB_fromCB_0_(DataReceivLSB_from_tracker_0_sync) ,	// input [17:0] DataReceivLSB_fromCB_3_
	.DataReceivMSB_fromCB_0_(DataReceivMSB_from_tracker_0_sync) ,	// input [17:0] DataReceivMSB_fromCB_3_
	.DataReceivLSB_fromCB_1_(DataReceivLSB_from_tracker_1_sync) ,	// input [17:0] DataReceivLSB_fromCB_4_
	.DataReceivMSB_fromCB_1_(DataReceivMSB_from_tracker_1_sync) ,	// input [17:0] DataReceivMSB_fromCB_4_
	.DataReceivLSB_fromCB_2_(DataReceivLSB_from_tracker_2_sync) ,	// input [17:0] DataReceivLSB_fromCB_5_
	.DataReceivMSB_fromCB_2_(DataReceivMSB_from_tracker_2_sync) ,	// input [17:0] DataReceivMSB_fromCB_5_

/*
	.DataReceivLSB_fromCB_0_(TPsEmul_CB0fifo_[17:0]) ,	// input [17:0] Fifo Emulation
	.DataReceivMSB_fromCB_0_(TPsEmul_CB0fifo_[35:18]) ,	// input [17:0] DataReceivMSB_fromCB_0_
	.DataReceivLSB_fromCB_1_(TPsEmul_CB1fifo_[17:0]) ,	// input [17:0] DataReceivLSB_fromCB_1_
	.DataReceivMSB_fromCB_1_(TPsEmul_CB1fifo_[35:18]) ,	// input [17:0] DataReceivMSB_fromCB_1_
	.DataReceivLSB_fromCB_2_(TPsEmul_CB2fifo_[17:0]) ,	// input [17:0] DataReceivLSB_fromCB_2_
	.DataReceivMSB_fromCB_2_(TPsEmul_CB2fifo_[35:18]) ,	// input [17:0] DataReceivMSB_fromCB_2_ */

	.TrameDetect_enable(TrameDetect_enable) ,	//	input
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clock40
	.clock800(clock800),
	.n_rst(n_reset_all_fpga) ,						// input  n_rst
	.n_rst_phaser(n_rst_phaser) ,		// input  n_rst_phaser

	.clock800Id_TB(clock800Id_TB) ,								// output [15:0] 	clock800Id_TB
	.clock800CB0toTB_Id(clock800CB0toTB_Id) ,							// output [15:0] 	clock800CB0toTB_Id
	.clock800CB1toTB_Id(clock800CB1toTB_Id) ,							// output [15:0] 	clock800CB1toTB_Id
	.clock800CB2toTB_Id(clock800CB2toTB_Id) ,							// output [15:0] 	clock800CB2toTB_Id

	.CB_Mask_Reg(CB_Mask_Reg),
	.toogleCB0_wren_reg(toogleCB0_wren_reg) ,	// output  toogleCB0_wren_reg
	.wrregTPs_CB0(wrregTPs_CB0) ,					// output  wrregTPs_CB0
	.toogleCB1_wren_reg(toogleCB1_wren_reg) ,	// output  toogleCB1_wren_reg
	.wrregTPs_CB1(wrregTPs_CB1) ,					// output  wrregTPs_CB1
	.toogleCB2_wren_reg(toogleCB2_wren_reg) ,	// output  toogleCB2_wren_reg
	.wrregTPs_CB2(wrregTPs_CB2) ,					// output  wrregTPs_CB2

	.TPsfromCB0_(TPsfromCB0FromStreaming_) , 	// output [683:0] TPsfromCB0FromStreaming_
	.TPsfromCB1_(TPsfromCB1FromStreaming_) ,
	.TPsfromCB2_(TPsfromCB2FromStreaming_) ,

	.view_CB0_(view_CB0_),
	.view_CB1_(view_CB1_),
	.view_CB2_(view_CB2_),
	.view_error(view_error),

	.error_clock800Id_allCBtoTB(error_clock800Id_allCBtoTB),
	.ZoneBuilding_enable(ZoneBuilding_enable) ,	// output  ZoneBuilding_enable
	.projection_OK(projection_OK) ,					// output  projection_OK_sig

	.NberWordsTPsfromCB0Shifted() ,	// output [5:0] NberWordsTPsfromCB0Shifted
	.st_transactionCB0toTB() ,				// output [3:0] st_transactionCB0toTB
	.NberWordsTPsfromCB1Shifted() ,	// output [5:0] NberWordsTPsfromCB1Shifted
	.st_transactionCB1toTB() ,				// output [3:0] st_transactionCB1toTB
	.NberWordsTPsfromCB2Shifted() ,	// output [5:0] NberWordsTPsfromCB2Shifted
	.st_transactionCB2toTB() 				// output [3:0] st_transactionCB2toTB
);

//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//--- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  ---
//--- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  ---
//--- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  ---
//--- TRACKER  - TRACKER  - TRACKER  - TRACKER  - TRACKER  ---
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
TPs_ZoneBuilder TPs_ZoneBuilder_inst
(
	.TPsfromCB0_(TPsfromCB0FromStreaming_[683:0]) , 	// output [683:0] TPsfromCB0FromStreaming_
	.TPsfromCB1_(TPsfromCB1FromStreaming_[683:0]) ,
	.TPsfromCB2_(TPsfromCB2FromStreaming_[683:0]) ,

	.n_rst_phaser(n_Reset_reg[6]) ,	// input  n_rst_phaser_sig
	.lpbus_clk(lpbus_clk) ,	// input  lpbus_clk_sig
	.clock40(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.n_global_reset(n_global_reset) ,	// input  n_global_reset_sig
	.n_poweron_reset(n_poweron_reset) ,	// input  n_poweron_reset_sig

	.ZoneBuilding_enable(ZoneBuilding_enable), //input
	.projection_OK(projection_OK),
	.compute_tracker_OK(compute_tracker_OK),

	.TSZB_S0Z0_(TSZB_S0Z0_),	// output [6:0] TSZB_S0Z0_,
	.TSZB_S0Z1_(TSZB_S0Z1_),	// output [6:0] TSZB_S0Z1_,
	.TSZB_S0Z2_(TSZB_S0Z2_),	// output [6:0] TSZB_S0Z2_,
	.TSZB_S0Z3_(TSZB_S0Z3_),	// output [6:0] TSZB_S0Z3_,
	.TSZB_S0Z4_(TSZB_S0Z4_),	// output [6:0] TSZB_S0Z4_,
	.TSZB_S0Z5_(TSZB_S0Z5_),	// output [6:0] TSZB_S0Z5_,
	.TSZB_S0Z6_(TSZB_S0Z6_),	// output [6:0] TSZB_S0Z6_,
	.TSZB_S0Z7_(TSZB_S0Z7_),	// output [6:0] TSZB_S0Z7_,
	.TSZB_S0Z8_(TSZB_S0Z8_),	// output [6:0] TSZB_S0Z8_,
	.TSZB_S0Z9_(TSZB_S0Z9_),	// output [6:0] TSZB_S0Z9_,
	.TSZB_S1Z0_(TSZB_S1Z0_),	// output [6:0] TSZB_S1Z0_,
	.TSZB_S1Z1_(TSZB_S1Z1_),	// output [6:0] TSZB_S1Z1_,
	.TSZB_S1Z2_(TSZB_S1Z2_),	// output [6:0] TSZB_S1Z2_,
	.TSZB_S1Z3_(TSZB_S1Z3_),	// output [6:0] TSZB_S1Z3_,
	.TSZB_S1Z4_(TSZB_S1Z4_),	// output [6:0] TSZB_S1Z4_,
	.TSZB_S1Z5_(TSZB_S1Z5_),	// output [6:0] TSZB_S1Z5_,
	.TSZB_S1Z6_(TSZB_S1Z6_),	// output [6:0] TSZB_S1Z6_,
	.TSZB_S1Z7_(TSZB_S1Z7_),	// output [6:0] TSZB_S1Z7_,
	.TSZB_S1Z8_(TSZB_S1Z8_),	// output [6:0] TSZB_S1Z8_,
	.TSZB_S1Z9_(TSZB_S1Z9_),	// output [6:0] TSZB_S1Z9_,
	.PR_SZA_S0Z0_(PR_SZA_S0Z0_),	// output [7:0] PR_SZA_S0Z0_,
	.PR_SZB_S0Z0_(PR_SZB_S0Z0_),	// output [7:0] PR_SZB_S0Z0_,
	.PR_SZC_S0Z0_(PR_SZC_S0Z0_),	// output [7:0] PR_SZC_S0Z0_,
	.PR_SZD_S0Z0_(PR_SZD_S0Z0_),	// output [7:0] PR_SZD_S0Z0_,
	.PL_SZA_S0Z0_(PL_SZA_S0Z0_),	// output [8:0] PL_SZA_S0Z0_,
	.PL_SZB_S0Z0_(PL_SZB_S0Z0_),	// output [8:0] PL_SZB_S0Z0_,
	.PL_SZC_S0Z0_(PL_SZC_S0Z0_),	// output [8:0] PL_SZC_S0Z0_,
	.PL_SZD_S0Z0_(PL_SZD_S0Z0_),	// output [8:0] PL_SZD_S0Z0_,
	.VSZB_S0Z0_(VSZB_S0Z0_),	// output [7:0] VSZB_S0Z0_,
	.HSZB_S0Z0_(HSZB_S0Z0_),	// output [7:0] HSZB_S0Z0_,
	.PR_SZA_S0Z1_(PR_SZA_S0Z1_),	// output [7:0] PR_SZA_S0Z1_,
	.PR_SZB_S0Z1_(PR_SZB_S0Z1_),	// output [7:0] PR_SZB_S0Z1_,
	.PR_SZC_S0Z1_(PR_SZC_S0Z1_),	// output [7:0] PR_SZC_S0Z1_,
	.PR_SZD_S0Z1_(PR_SZD_S0Z1_),	// output [7:0] PR_SZD_S0Z1_,
	.PL_SZA_S0Z1_(PL_SZA_S0Z1_),	// output [8:0] PL_SZA_S0Z1_,
	.PL_SZB_S0Z1_(PL_SZB_S0Z1_),	// output [8:0] PL_SZB_S0Z1_,
	.PL_SZC_S0Z1_(PL_SZC_S0Z1_),	// output [8:0] PL_SZC_S0Z1_,
	.PL_SZD_S0Z1_(PL_SZD_S0Z1_),	// output [8:0] PL_SZD_S0Z1_,
	.VSZB_S0Z1_(VSZB_S0Z1_),	// output [7:0] VSZB_S0Z1_,
	.HSZB_S0Z1_(HSZB_S0Z1_),	// output [7:0] HSZB_S0Z1_,
	.PR_SZA_S0Z2_(PR_SZA_S0Z2_),	// output [7:0] PR_SZA_S0Z2_,
	.PR_SZB_S0Z2_(PR_SZB_S0Z2_),	// output [7:0] PR_SZB_S0Z2_,
	.PR_SZC_S0Z2_(PR_SZC_S0Z2_),	// output [7:0] PR_SZC_S0Z2_,
	.PR_SZD_S0Z2_(PR_SZD_S0Z2_),	// output [7:0] PR_SZD_S0Z2_,
	.PL_SZA_S0Z2_(PL_SZA_S0Z2_),	// output [8:0] PL_SZA_S0Z2_,
	.PL_SZB_S0Z2_(PL_SZB_S0Z2_),	// output [8:0] PL_SZB_S0Z2_,
	.PL_SZC_S0Z2_(PL_SZC_S0Z2_),	// output [8:0] PL_SZC_S0Z2_,
	.PL_SZD_S0Z2_(PL_SZD_S0Z2_),	// output [8:0] PL_SZD_S0Z2_,
	.VSZB_S0Z2_(VSZB_S0Z2_),	// output [7:0] VSZB_S0Z2_,
	.HSZB_S0Z2_(HSZB_S0Z2_),	// output [7:0] HSZB_S0Z2_,
	.PR_SZA_S0Z3_(PR_SZA_S0Z3_),	// output [7:0] PR_SZA_S0Z3_,
	.PR_SZB_S0Z3_(PR_SZB_S0Z3_),	// output [7:0] PR_SZB_S0Z3_,
	.PR_SZC_S0Z3_(PR_SZC_S0Z3_),	// output [7:0] PR_SZC_S0Z3_,
	.PR_SZD_S0Z3_(PR_SZD_S0Z3_),	// output [7:0] PR_SZD_S0Z3_,
	.PL_SZA_S0Z3_(PL_SZA_S0Z3_),	// output [8:0] PL_SZA_S0Z3_,
	.PL_SZB_S0Z3_(PL_SZB_S0Z3_),	// output [8:0] PL_SZB_S0Z3_,
	.PL_SZC_S0Z3_(PL_SZC_S0Z3_),	// output [8:0] PL_SZC_S0Z3_,
	.PL_SZD_S0Z3_(PL_SZD_S0Z3_),	// output [8:0] PL_SZD_S0Z3_,
	.VSZB_S0Z3_(VSZB_S0Z3_),	// output [7:0] VSZB_S0Z3_,
	.HSZB_S0Z3_(HSZB_S0Z3_),	// output [7:0] HSZB_S0Z3_,
	.PR_SZA_S0Z4_(PR_SZA_S0Z4_),	// output [7:0] PR_SZA_S0Z4_,
	.PR_SZB_S0Z4_(PR_SZB_S0Z4_),	// output [7:0] PR_SZB_S0Z4_,
	.PR_SZC_S0Z4_(PR_SZC_S0Z4_),	// output [7:0] PR_SZC_S0Z4_,
	.PR_SZD_S0Z4_(PR_SZD_S0Z4_),	// output [7:0] PR_SZD_S0Z4_,
	.PL_SZA_S0Z4_(PL_SZA_S0Z4_),	// output [8:0] PL_SZA_S0Z4_,
	.PL_SZB_S0Z4_(PL_SZB_S0Z4_),	// output [8:0] PL_SZB_S0Z4_,
	.PL_SZC_S0Z4_(PL_SZC_S0Z4_),	// output [8:0] PL_SZC_S0Z4_,
	.PL_SZD_S0Z4_(PL_SZD_S0Z4_),	// output [8:0] PL_SZD_S0Z4_,
	.VSZB_S0Z4_(VSZB_S0Z4_),	// output [7:0] VSZB_S0Z4_,
	.HSZB_S0Z4_(HSZB_S0Z4_),	// output [7:0] HSZB_S0Z4_,
	.PR_SZA_S0Z5_(PR_SZA_S0Z5_),	// output [7:0] PR_SZA_S0Z5_,
	.PR_SZB_S0Z5_(PR_SZB_S0Z5_),	// output [7:0] PR_SZB_S0Z5_,
	.PR_SZC_S0Z5_(PR_SZC_S0Z5_),	// output [7:0] PR_SZC_S0Z5_,
	.PR_SZD_S0Z5_(PR_SZD_S0Z5_),	// output [7:0] PR_SZD_S0Z5_,
	.PL_SZA_S0Z5_(PL_SZA_S0Z5_),	// output [8:0] PL_SZA_S0Z5_,
	.PL_SZB_S0Z5_(PL_SZB_S0Z5_),	// output [8:0] PL_SZB_S0Z5_,
	.PL_SZC_S0Z5_(PL_SZC_S0Z5_),	// output [8:0] PL_SZC_S0Z5_,
	.PL_SZD_S0Z5_(PL_SZD_S0Z5_),	// output [8:0] PL_SZD_S0Z5_,
	.VSZB_S0Z5_(VSZB_S0Z5_),	// output [7:0] VSZB_S0Z5_,
	.HSZB_S0Z5_(HSZB_S0Z5_),	// output [7:0] HSZB_S0Z5_,
	.PR_SZA_S0Z6_(PR_SZA_S0Z6_),	// output [7:0] PR_SZA_S0Z6_,
	.PR_SZB_S0Z6_(PR_SZB_S0Z6_),	// output [7:0] PR_SZB_S0Z6_,
	.PR_SZC_S0Z6_(PR_SZC_S0Z6_),	// output [7:0] PR_SZC_S0Z6_,
	.PR_SZD_S0Z6_(PR_SZD_S0Z6_),	// output [7:0] PR_SZD_S0Z6_,
	.PL_SZA_S0Z6_(PL_SZA_S0Z6_),	// output [8:0] PL_SZA_S0Z6_,
	.PL_SZB_S0Z6_(PL_SZB_S0Z6_),	// output [8:0] PL_SZB_S0Z6_,
	.PL_SZC_S0Z6_(PL_SZC_S0Z6_),	// output [8:0] PL_SZC_S0Z6_,
	.PL_SZD_S0Z6_(PL_SZD_S0Z6_),	// output [8:0] PL_SZD_S0Z6_,
	.VSZB_S0Z6_(VSZB_S0Z6_),	// output [7:0] VSZB_S0Z6_,
	.HSZB_S0Z6_(HSZB_S0Z6_),	// output [7:0] HSZB_S0Z6_,
	.PR_SZA_S0Z7_(PR_SZA_S0Z7_),	// output [7:0] PR_SZA_S0Z7_,
	.PR_SZB_S0Z7_(PR_SZB_S0Z7_),	// output [7:0] PR_SZB_S0Z7_,
	.PR_SZC_S0Z7_(PR_SZC_S0Z7_),	// output [7:0] PR_SZC_S0Z7_,
	.PR_SZD_S0Z7_(PR_SZD_S0Z7_),	// output [7:0] PR_SZD_S0Z7_,
	.PL_SZA_S0Z7_(PL_SZA_S0Z7_),	// output [8:0] PL_SZA_S0Z7_,
	.PL_SZB_S0Z7_(PL_SZB_S0Z7_),	// output [8:0] PL_SZB_S0Z7_,
	.PL_SZC_S0Z7_(PL_SZC_S0Z7_),	// output [8:0] PL_SZC_S0Z7_,
	.PL_SZD_S0Z7_(PL_SZD_S0Z7_),	// output [8:0] PL_SZD_S0Z7_,
	.VSZB_S0Z7_(VSZB_S0Z7_),	// output [7:0] VSZB_S0Z7_,
	.HSZB_S0Z7_(HSZB_S0Z7_),	// output [7:0] HSZB_S0Z7_,
	.PR_SZA_S0Z8_(PR_SZA_S0Z8_),	// output [7:0] PR_SZA_S0Z8_,
	.PR_SZB_S0Z8_(PR_SZB_S0Z8_),	// output [7:0] PR_SZB_S0Z8_,
	.PR_SZC_S0Z8_(PR_SZC_S0Z8_),	// output [7:0] PR_SZC_S0Z8_,
	.PR_SZD_S0Z8_(PR_SZD_S0Z8_),	// output [7:0] PR_SZD_S0Z8_,
	.PL_SZA_S0Z8_(PL_SZA_S0Z8_),	// output [8:0] PL_SZA_S0Z8_,
	.PL_SZB_S0Z8_(PL_SZB_S0Z8_),	// output [8:0] PL_SZB_S0Z8_,
	.PL_SZC_S0Z8_(PL_SZC_S0Z8_),	// output [8:0] PL_SZC_S0Z8_,
	.PL_SZD_S0Z8_(PL_SZD_S0Z8_),	// output [8:0] PL_SZD_S0Z8_,
	.VSZB_S0Z8_(VSZB_S0Z8_),	// output [7:0] VSZB_S0Z8_,
	.HSZB_S0Z8_(HSZB_S0Z8_),	// output [7:0] HSZB_S0Z8_,
	.PR_SZA_S0Z9_(PR_SZA_S0Z9_),	// output [7:0] PR_SZA_S0Z9_,
	.PR_SZB_S0Z9_(PR_SZB_S0Z9_),	// output [7:0] PR_SZB_S0Z9_,
	.PR_SZC_S0Z9_(PR_SZC_S0Z9_),	// output [7:0] PR_SZC_S0Z9_,
	.PR_SZD_S0Z9_(PR_SZD_S0Z9_),	// output [7:0] PR_SZD_S0Z9_,
	.PL_SZA_S0Z9_(PL_SZA_S0Z9_),	// output [8:0] PL_SZA_S0Z9_,
	.PL_SZB_S0Z9_(PL_SZB_S0Z9_),	// output [8:0] PL_SZB_S0Z9_,
	.PL_SZC_S0Z9_(PL_SZC_S0Z9_),	// output [8:0] PL_SZC_S0Z9_,
	.PL_SZD_S0Z9_(PL_SZD_S0Z9_),	// output [8:0] PL_SZD_S0Z9_,
	.VSZB_S0Z9_(VSZB_S0Z9_),	// output [7:0] VSZB_S0Z9_,
	.HSZB_S0Z9_(HSZB_S0Z9_),	// output [7:0] HSZB_S0Z9_,
	.PR_SZA_S1Z0_(PR_SZA_S1Z0_),	// output [7:0] PR_SZA_S1Z0_,
	.PR_SZB_S1Z0_(PR_SZB_S1Z0_),	// output [7:0] PR_SZB_S1Z0_,
	.PR_SZC_S1Z0_(PR_SZC_S1Z0_),	// output [7:0] PR_SZC_S1Z0_,
	.PR_SZD_S1Z0_(PR_SZD_S1Z0_),	// output [7:0] PR_SZD_S1Z0_,
	.PL_SZA_S1Z0_(PL_SZA_S1Z0_),	// output [8:0] PL_SZA_S1Z0_,
	.PL_SZB_S1Z0_(PL_SZB_S1Z0_),	// output [8:0] PL_SZB_S1Z0_,
	.PL_SZC_S1Z0_(PL_SZC_S1Z0_),	// output [8:0] PL_SZC_S1Z0_,
	.PL_SZD_S1Z0_(PL_SZD_S1Z0_),	// output [8:0] PL_SZD_S1Z0_,
	.VSZB_S1Z0_(VSZB_S1Z0_),	// output [7:0] VSZB_S1Z0_,
	.HSZB_S1Z0_(HSZB_S1Z0_),	// output [7:0] HSZB_S1Z0_,
	.PR_SZA_S1Z1_(PR_SZA_S1Z1_),	// output [7:0] PR_SZA_S1Z1_,
	.PR_SZB_S1Z1_(PR_SZB_S1Z1_),	// output [7:0] PR_SZB_S1Z1_,
	.PR_SZC_S1Z1_(PR_SZC_S1Z1_),	// output [7:0] PR_SZC_S1Z1_,
	.PR_SZD_S1Z1_(PR_SZD_S1Z1_),	// output [7:0] PR_SZD_S1Z1_,
	.PL_SZA_S1Z1_(PL_SZA_S1Z1_),	// output [8:0] PL_SZA_S1Z1_,
	.PL_SZB_S1Z1_(PL_SZB_S1Z1_),	// output [8:0] PL_SZB_S1Z1_,
	.PL_SZC_S1Z1_(PL_SZC_S1Z1_),	// output [8:0] PL_SZC_S1Z1_,
	.PL_SZD_S1Z1_(PL_SZD_S1Z1_),	// output [8:0] PL_SZD_S1Z1_,
	.VSZB_S1Z1_(VSZB_S1Z1_),	// output [7:0] VSZB_S1Z1_,
	.HSZB_S1Z1_(HSZB_S1Z1_),	// output [7:0] HSZB_S1Z1_,
	.PR_SZA_S1Z2_(PR_SZA_S1Z2_),	// output [7:0] PR_SZA_S1Z2_,
	.PR_SZB_S1Z2_(PR_SZB_S1Z2_),	// output [7:0] PR_SZB_S1Z2_,
	.PR_SZC_S1Z2_(PR_SZC_S1Z2_),	// output [7:0] PR_SZC_S1Z2_,
	.PR_SZD_S1Z2_(PR_SZD_S1Z2_),	// output [7:0] PR_SZD_S1Z2_,
	.PL_SZA_S1Z2_(PL_SZA_S1Z2_),	// output [8:0] PL_SZA_S1Z2_,
	.PL_SZB_S1Z2_(PL_SZB_S1Z2_),	// output [8:0] PL_SZB_S1Z2_,
	.PL_SZC_S1Z2_(PL_SZC_S1Z2_),	// output [8:0] PL_SZC_S1Z2_,
	.PL_SZD_S1Z2_(PL_SZD_S1Z2_),	// output [8:0] PL_SZD_S1Z2_,
	.VSZB_S1Z2_(VSZB_S1Z2_),	// output [7:0] VSZB_S1Z2_,
	.HSZB_S1Z2_(HSZB_S1Z2_),	// output [7:0] HSZB_S1Z2_,
	.PR_SZA_S1Z3_(PR_SZA_S1Z3_),	// output [7:0] PR_SZA_S1Z3_,
	.PR_SZB_S1Z3_(PR_SZB_S1Z3_),	// output [7:0] PR_SZB_S1Z3_,
	.PR_SZC_S1Z3_(PR_SZC_S1Z3_),	// output [7:0] PR_SZC_S1Z3_,
	.PR_SZD_S1Z3_(PR_SZD_S1Z3_),	// output [7:0] PR_SZD_S1Z3_,
	.PL_SZA_S1Z3_(PL_SZA_S1Z3_),	// output [8:0] PL_SZA_S1Z3_,
	.PL_SZB_S1Z3_(PL_SZB_S1Z3_),	// output [8:0] PL_SZB_S1Z3_,
	.PL_SZC_S1Z3_(PL_SZC_S1Z3_),	// output [8:0] PL_SZC_S1Z3_,
	.PL_SZD_S1Z3_(PL_SZD_S1Z3_),	// output [8:0] PL_SZD_S1Z3_,
	.VSZB_S1Z3_(VSZB_S1Z3_),	// output [7:0] VSZB_S1Z3_,
	.HSZB_S1Z3_(HSZB_S1Z3_),	// output [7:0] HSZB_S1Z3_,
	.PR_SZA_S1Z4_(PR_SZA_S1Z4_),	// output [7:0] PR_SZA_S1Z4_,
	.PR_SZB_S1Z4_(PR_SZB_S1Z4_),	// output [7:0] PR_SZB_S1Z4_,
	.PR_SZC_S1Z4_(PR_SZC_S1Z4_),	// output [7:0] PR_SZC_S1Z4_,
	.PR_SZD_S1Z4_(PR_SZD_S1Z4_),	// output [7:0] PR_SZD_S1Z4_,
	.PL_SZA_S1Z4_(PL_SZA_S1Z4_),	// output [8:0] PL_SZA_S1Z4_,
	.PL_SZB_S1Z4_(PL_SZB_S1Z4_),	// output [8:0] PL_SZB_S1Z4_,
	.PL_SZC_S1Z4_(PL_SZC_S1Z4_),	// output [8:0] PL_SZC_S1Z4_,
	.PL_SZD_S1Z4_(PL_SZD_S1Z4_),	// output [8:0] PL_SZD_S1Z4_,
	.VSZB_S1Z4_(VSZB_S1Z4_),	// output [7:0] VSZB_S1Z4_,
	.HSZB_S1Z4_(HSZB_S1Z4_),	// output [7:0] HSZB_S1Z4_,
	.PR_SZA_S1Z5_(PR_SZA_S1Z5_),	// output [7:0] PR_SZA_S1Z5_,
	.PR_SZB_S1Z5_(PR_SZB_S1Z5_),	// output [7:0] PR_SZB_S1Z5_,
	.PR_SZC_S1Z5_(PR_SZC_S1Z5_),	// output [7:0] PR_SZC_S1Z5_,
	.PR_SZD_S1Z5_(PR_SZD_S1Z5_),	// output [7:0] PR_SZD_S1Z5_,
	.PL_SZA_S1Z5_(PL_SZA_S1Z5_),	// output [8:0] PL_SZA_S1Z5_,
	.PL_SZB_S1Z5_(PL_SZB_S1Z5_),	// output [8:0] PL_SZB_S1Z5_,
	.PL_SZC_S1Z5_(PL_SZC_S1Z5_),	// output [8:0] PL_SZC_S1Z5_,
	.PL_SZD_S1Z5_(PL_SZD_S1Z5_),	// output [8:0] PL_SZD_S1Z5_,
	.VSZB_S1Z5_(VSZB_S1Z5_),	// output [7:0] VSZB_S1Z5_,
	.HSZB_S1Z5_(HSZB_S1Z5_),	// output [7:0] HSZB_S1Z5_,
	.PR_SZA_S1Z6_(PR_SZA_S1Z6_),	// output [7:0] PR_SZA_S1Z6_,
	.PR_SZB_S1Z6_(PR_SZB_S1Z6_),	// output [7:0] PR_SZB_S1Z6_,
	.PR_SZC_S1Z6_(PR_SZC_S1Z6_),	// output [7:0] PR_SZC_S1Z6_,
	.PR_SZD_S1Z6_(PR_SZD_S1Z6_),	// output [7:0] PR_SZD_S1Z6_,
	.PL_SZA_S1Z6_(PL_SZA_S1Z6_),	// output [8:0] PL_SZA_S1Z6_,
	.PL_SZB_S1Z6_(PL_SZB_S1Z6_),	// output [8:0] PL_SZB_S1Z6_,
	.PL_SZC_S1Z6_(PL_SZC_S1Z6_),	// output [8:0] PL_SZC_S1Z6_,
	.PL_SZD_S1Z6_(PL_SZD_S1Z6_),	// output [8:0] PL_SZD_S1Z6_,
	.VSZB_S1Z6_(VSZB_S1Z6_),	// output [7:0] VSZB_S1Z6_,
	.HSZB_S1Z6_(HSZB_S1Z6_),	// output [7:0] HSZB_S1Z6_,
	.PR_SZA_S1Z7_(PR_SZA_S1Z7_),	// output [7:0] PR_SZA_S1Z7_,
	.PR_SZB_S1Z7_(PR_SZB_S1Z7_),	// output [7:0] PR_SZB_S1Z7_,
	.PR_SZC_S1Z7_(PR_SZC_S1Z7_),	// output [7:0] PR_SZC_S1Z7_,
	.PR_SZD_S1Z7_(PR_SZD_S1Z7_),	// output [7:0] PR_SZD_S1Z7_,
	.PL_SZA_S1Z7_(PL_SZA_S1Z7_),	// output [8:0] PL_SZA_S1Z7_,
	.PL_SZB_S1Z7_(PL_SZB_S1Z7_),	// output [8:0] PL_SZB_S1Z7_,
	.PL_SZC_S1Z7_(PL_SZC_S1Z7_),	// output [8:0] PL_SZC_S1Z7_,
	.PL_SZD_S1Z7_(PL_SZD_S1Z7_),	// output [8:0] PL_SZD_S1Z7_,
	.VSZB_S1Z7_(VSZB_S1Z7_),	// output [7:0] VSZB_S1Z7_,
	.HSZB_S1Z7_(HSZB_S1Z7_),	// output [7:0] HSZB_S1Z7_,
	.PR_SZA_S1Z8_(PR_SZA_S1Z8_),	// output [7:0] PR_SZA_S1Z8_,
	.PR_SZB_S1Z8_(PR_SZB_S1Z8_),	// output [7:0] PR_SZB_S1Z8_,
	.PR_SZC_S1Z8_(PR_SZC_S1Z8_),	// output [7:0] PR_SZC_S1Z8_,
	.PR_SZD_S1Z8_(PR_SZD_S1Z8_),	// output [7:0] PR_SZD_S1Z8_,
	.PL_SZA_S1Z8_(PL_SZA_S1Z8_),	// output [8:0] PL_SZA_S1Z8_,
	.PL_SZB_S1Z8_(PL_SZB_S1Z8_),	// output [8:0] PL_SZB_S1Z8_,
	.PL_SZC_S1Z8_(PL_SZC_S1Z8_),	// output [8:0] PL_SZC_S1Z8_,
	.PL_SZD_S1Z8_(PL_SZD_S1Z8_),	// output [8:0] PL_SZD_S1Z8_,
	.VSZB_S1Z8_(VSZB_S1Z8_),	// output [7:0] VSZB_S1Z8_,
	.HSZB_S1Z8_(HSZB_S1Z8_),	// output [7:0] HSZB_S1Z8_,
	.PR_SZA_S1Z9_(PR_SZA_S1Z9_),	// output [7:0] PR_SZA_S1Z9_,
	.PR_SZB_S1Z9_(PR_SZB_S1Z9_),	// output [7:0] PR_SZB_S1Z9_,
	.PR_SZC_S1Z9_(PR_SZC_S1Z9_),	// output [7:0] PR_SZC_S1Z9_,
	.PR_SZD_S1Z9_(PR_SZD_S1Z9_),	// output [7:0] PR_SZD_S1Z9_,
	.PL_SZA_S1Z9_(PL_SZA_S1Z9_),	// output [8:0] PL_SZA_S1Z9_,
	.PL_SZB_S1Z9_(PL_SZB_S1Z9_),	// output [8:0] PL_SZB_S1Z9_,
	.PL_SZC_S1Z9_(PL_SZC_S1Z9_),	// output [8:0] PL_SZC_S1Z9_,
	.PL_SZD_S1Z9_(PL_SZD_S1Z9_),	// output [8:0] PL_SZD_S1Z9_,
	.VSZB_S1Z9_(VSZB_S1Z9_),	// output [7:0] VSZB_S1Z9_,
	.HSZB_S1Z9_(HSZB_S1Z9_), 	// output [7:0] HSZB_S1Z9__sig
	.S0_Zoning_Word_Pattern(S0_Zoning_Word_Pattern), // output [9:0] S0_Zoning_Word_Pattern_sig
	.S1_Zoning_Word_Pattern(S1_Zoning_Word_Pattern), // output [9:0] S1_Zoning_Word_Pattern_sig
	.S0_Zoning_Word_Near_Source(S0_Zoning_Word_Near_Source), // output [9:0] S0_Zoning_Word_Near_Source_sig
	.S1_Zoning_Word_Near_Source(S1_Zoning_Word_Near_Source) // output [9:0] S1_Zoning_Word_Near_Source_sig
);

//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//- TrackerStatus with Fifo -------- TrackerStatus with Fifo -
//- TrackerStatus with Fifo -------- TrackerStatus with Fifo -
//- TrackerStatus with Fifo -------- TrackerStatus with Fifo -
//- TrackerStatus with Fifo -------- TrackerStatus with Fifo -
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
reg dff1_projection_OK,dff2_projection_OK,dff3_projection_OK;
reg dff4_projection_OK,dff5_projection_OK,dff6_projection_OK,dff7_projection_OK,dff8_projection_OK;

always @(posedge clk40_To_FPGA or negedge n_rst_phaser ) begin
if (!n_rst_phaser) begin
			dff1_projection_OK 	<= 	1'b0;
			dff2_projection_OK 	<= 	1'b0;
			dff3_projection_OK 	<= 	1'b0;
			dff4_projection_OK 	<= 	1'b0;
			dff5_projection_OK 	<= 	1'b0;
			dff6_projection_OK 	<= 	1'b0;
			dff7_projection_OK 	<= 	1'b0;
			dff8_projection_OK 	<= 	1'b0;

			end
else 	begin
			dff1_projection_OK 	<= 	projection_OK;  // from streaming_dataTC module
			dff2_projection_OK 	<= 	dff1_projection_OK;
			dff3_projection_OK 	<= 	dff2_projection_OK;
			dff4_projection_OK 	<= 	dff3_projection_OK;  // from streaming_dataTC module
			dff5_projection_OK 	<= 	dff4_projection_OK;
			dff6_projection_OK 	<= 	dff5_projection_OK;
			dff7_projection_OK 	<= 	dff6_projection_OK;
			dff8_projection_OK 	<= 	dff7_projection_OK;

		end
end

//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------

//------------------------------------------------------------
//------------------------------------------------------------
//----- TPsEmul_CB0fifo - TPsEmul_CB1fifo - TPsEmul_CB2fifo -----
//------------------------------------------------------------
//------------------------------------------------------------
wire	[35:0]	TPsEmul_CB0fifo_,TPsEmul_CB1fifo_,TPsEmul_CB2fifo_;
wire	[31:0]	rd_FIFO_CB0,rd_FIFO_CB1,rd_FIFO_CB2;

Counter32bits	Counter32bits_inst0 (
	.aclr ( !n_rst_phaser ),
	.clk_en ( view_CB0_[8] ),		//enable_shiftTPsfromCB
	.clock ( clk40_To_FPGA ),
	.q ( rd_FIFO_CB0 )
	);

Counter32bits	Counter32bits_inst1 (
	.aclr ( !n_rst_phaser ),
	.clk_en ( view_CB1_[8] ),
	.clock ( clk40_To_FPGA ),
	.q ( rd_FIFO_CB1 )
	);

Counter32bits	Counter32bits_inst2 (
	.aclr ( !n_rst_phaser ),
	.clk_en ( view_CB2_[8] ),
	.clock ( clk40_To_FPGA ),
	.q ( rd_FIFO_CB2 )
	);

FIFO_CB0	FIFO_CB0_inst (
	.aclr (  !n_rst_phaser ),
	.address ( rd_FIFO_CB0[10:0] ),
	.clock ( clk40_To_FPGA ),
	.data ( 36'h000000000 ),
	.rden ( view_CB0_[8] ),	//enable_shiftTPsfromCB
	.wren ( 1'b0 ),
	.q (  TPsEmul_CB0fifo_  )
	);

FIFO_CB1	FIFO_CB1_inst (
	.aclr (  !n_rst_phaser ),
	.address ( rd_FIFO_CB1[10:0] ),
	.clock ( clk40_To_FPGA ),
	.data ( 36'h000000000 ),
	.rden ( view_CB1_[8] ),
	.wren ( 1'b0 ),
	.q (  TPsEmul_CB1fifo_  )
	);

FIFO_CB2	FIFO_CB2_inst (
	.aclr (  !n_rst_phaser ),
	.address ( rd_FIFO_CB2[10:0] ),
	.clock ( clk40_To_FPGA ),
	.data ( 36'h000000000 ),
	.rden ( view_CB2_[8] ),
	.wren ( 1'b0 ),
	.q (  TPsEmul_CB2fifo_  )
	);

//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//- CALORIMETER  - CALORIMETER  - CALORIMETER  - CALORIMETER -
//- CALORIMETER  - CALORIMETER  - CALORIMETER  - CALORIMETER -
//- CALORIMETER  - CALORIMETER  - CALORIMETER  - CALORIMETER -
//- CALORIMETER  - CALORIMETER  - CALORIMETER  - CALORIMETER -
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
wire	[9:0] W_ZW_S0;
wire	[5:0] sumbitsForTTM;
wire [31:0] 	CaloRecordBitset;
wire [34:0]  CaloSummaryRecordBitset;

CaloSummaryRecordBitset CaloSummaryRecordBitset_inst
(
	.enable_acquisition(enable_acquisition),
	.CaloDecision_Multiplicity(CaloDecision_Multiplicity),
	.DataReceivLSB_fromCB_0_(DataReceivfrom_calo_0_sync) ,	// input [17:0] DataReceivLSB_fromCB_0__sig
	.DataReceivLSB_fromCB_1_(DataReceivfrom_calo_1_sync) ,	// input [17:0] DataReceivLSB_fromCB_1__sig
	.DataReceivLSB_fromCB_2_(DataReceivfrom_calo_2_sync) ,	// input [17:0] DataReceivLSB_fromCB_2__sig
	.CTWsFromCB0_fromEmulFifo_(CTWsFromCB3_EmulFifo_[17:0]) ,// input [23:0] CTWsFromCB0_fromEmulFifo,CTWsFromCB1_fromEmulFifo,CTWsFromCB2_fromEmulFifo
	.CTWsFromCB1_fromEmulFifo_(CTWsFromCB4_EmulFifo_[17:0]) ,
	.CTWsFromCB2_fromEmulFifo_(CTWsFromCB5_EmulFifo_[17:0]) ,

	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.n_rst(n_reset_all_fpga) ,	// input  n_rst_sig
	.modefifoorreg(modefifoorreg) ,

	.CaloRecordBitset(CaloRecordBitset_),					//output [31:0] CaloRecordBitset
	.CaloRecordBitsetMoins1_(CaloRecordBitsetMoins1_),	//output [31:0]
	.CaloRecordBitsetMoins2_(CaloRecordBitsetMoins2_),	//output [31:0]
	.CaloRecordBitsetMoins3_(CaloRecordBitsetMoins3_),	//output [31:0]
	.CaloSummaryRecordBitset(CaloSummaryRecordBitset_) ,//output [34:0] CaloSummaryRecordBitset

	.W_ZW_S0(W_ZW_S0) ,

	.CaloDecision(CaloDecision) , 	// output  CaloDecision  <=> L1 Calo ??????????????????
	.sumbitsForTTM(sumbitsForTTM)
);

//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//- EMULATION - EMULATION - EMULATION - EMULATION - EMULATION
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------

//------------------------------------------------------------
//------------------ Multi shots emulation -------------------
//------------------ 3 Emulation FIFOS: ----------------------
//------------------------------------------------------------
//---------------- FIFO_CB3 FIFO_CB4 FIFO_CB5 ----------------
//------------------------------------------------------------
//------------------------------------------------------------
wire	read_EmulCTWsFifo;
reg	rden_EmulCTWsFifo;

wire	[31:0]	rd_FIFO_CB3,rd_FIFO_CB4,rd_FIFO_CB5;
wire	[23:0]	CTWsFromCB3_EmulFifo_,CTWsFromCB4_EmulFifo_,CTWsFromCB5_EmulFifo_;

assign	read_EmulCTWsFifo = counter40Mhz_enable; // & modefifoorreg;

//rden_Emulation_Fifo
//-------------------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin
  if (~n_reset_all_fpga)
        rden_EmulCTWsFifo  <= 1'b0;
  else
        rden_EmulCTWsFifo	<= read_EmulCTWsFifo;
end

Counter32bits	Counter32bits_inst3 (
	.aclr ( !n_rst_phaser ),
	.clk_en ( read_EmulCTWsFifo ),
	.clock ( clk40_To_FPGA ),
	.q ( rd_FIFO_CB3 )
	);

Counter32bits	Counter32bits_inst4 (
	.aclr ( !n_rst_phaser ),
	.clk_en ( read_EmulCTWsFifo ),
	.clock ( clk40_To_FPGA ),
	.q ( rd_FIFO_CB4 )
	);

Counter32bits	Counter32bits_inst5 (
	.aclr ( !n_rst_phaser ),
	.clk_en ( read_EmulCTWsFifo ),
	.clock ( clk40_To_FPGA ),
	.q ( rd_FIFO_CB5 )
	);

FIFO_CB3	FIFO_CB3_inst (			//RAM 8192 x 24bits.
	.aclr ( !n_rst_phaser ),
	.address ( rd_FIFO_CB3[12:0] ),
	.clock ( clk40_To_FPGA ),
	.data ( 24'h000000000 ),
	.rden ( rden_EmulCTWsFifo ),
	.wren ( 1'b0 ),
	.q ( CTWsFromCB3_EmulFifo_[23:0] )
	);

FIFO_CB4	FIFO_CB4_inst (
	.aclr ( !n_rst_phaser ),
	.address ( rd_FIFO_CB3[12:0] ),
	.clock ( clk40_To_FPGA ),
	.data ( 24'h000000000 ),
	.rden ( rden_EmulCTWsFifo ),
	.wren ( 1'b0 ),
	.q ( CTWsFromCB4_EmulFifo_[23:0] )
	);

FIFO_CB5	FIFO_CB5_inst (
	.aclr ( !n_rst_phaser ),
	.address ( rd_FIFO_CB3[12:0] ),
	.clock ( clk40_To_FPGA ),
	.data ( 24'h000000000 ),
	.rden ( rden_EmulCTWsFifo ),
	.wren ( 1'b0 ),
	.q ( CTWsFromCB5_EmulFifo_[23:0] )
	);


//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//-- Coincidence Trigger - Coincidence Trigger - Coincidence -
//-- Coincidence Trigger - Coincidence Trigger - Coincidence -
//-- Coincidence Trigger - Coincidence Trigger - Coincidence -
//-- Coincidence Trigger - Coincidence Trigger - Coincidence -
//------------------------------------------------------------
//------------------------------------------------------------
//------------------------------------------------------------
//L1 Calo <=> CaloDecision
//L1 Tracker

reg			dff_CaloDecision,dff1_CaloDecision;

reg [34:0] 	dff_CaloSummaryRecordBitset_;
reg [34:0] 	CaloSummaryRecordBitset_L1;

reg [7:0]	Coincidence_Window_width_reg;
reg 			Coincidence_Window;
reg [5:0]	Coincidence_Window_width_counter;
wire			Close_Coincidence_Window;
reg			dff_Close_Coincidence_Window;
//reg			Coincidence_Window_sync;

wire[19:0]	L2_Decision_Of_the_Zone;
reg			L2_Decision_int;
wire			L2_Decision;

reg [34:0] CaloSummaryRecordBitset_int;

//-----------------------------------------------------
//Side0-and-Side1
//---------------
reg	[9:0]	sum_W_ZW_S0,sum_W_ZW_S1;
reg			sum_LTO_S0,sum_LTO_S1;
reg 			HTM_S0_CSRB_multequal0,HTM_S0_CSRB_multequal1,HTM_S0_CSRB_multequal2,HTM_S0_CSRB_multsupequal3;
reg 			HTM_S1_CSRB_multequal0,HTM_S1_CSRB_multequal1,HTM_S1_CSRB_multequal2,HTM_S1_CSRB_multsupequal3;

//GVET0
//-----
reg			sum_LTO_GVETO;
reg			HTM_GVETO_CSRB_multequal0,HTM_GVETO_CSRB_multequal1,HTM_GVETO_CSRB_multequal2,HTM_GVETO_CSRB_multsupequal3;

reg   [2:0] sum_XT;
wire        sum_SScoinc;

//sum_HTM_S0
//-----------
wire [11:0] sum_HTM_S0_int;
reg [1:0] sum_HTM_S0;

sum8bits	sum8bits_inst0 (
	.data0x ( {6'b000000,CaloSummaryRecordBitset_[21:20]} ),
	.data1x ( {6'b000000,CaloSummaryRecordBitset_L1[21:20]} ),
	.data2x ( {8'h00} ),
	.data3x ( {8'h00} ),
	.data4x ( {8'h00} ),
	.data5x ( {8'h00} ),
	.data6x ( {8'h00} ),
	.data7x ( {8'h00}	),
	.result ( sum_HTM_S0_int )
	);

always @ (sum_HTM_S0_int or n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
		begin
		HTM_S0_CSRB_multequal0		<=  1'b0; HTM_S0_CSRB_multequal1		<=  1'b0;
		HTM_S0_CSRB_multequal2		<=  1'b0; HTM_S0_CSRB_multsupequal3	<=  1'b0;
		end
		else
		begin
 		HTM_S0_CSRB_multequal0		<=  sum_HTM_S0_int == 11'b00000000000;
		HTM_S0_CSRB_multequal1		<=  sum_HTM_S0_int == 11'b00000000001;
		HTM_S0_CSRB_multequal2		<=  sum_HTM_S0_int == 11'b00000000010;
		HTM_S0_CSRB_multsupequal3	<=  sum_HTM_S0_int >= 11'b00000000011;
		end
	end

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
					sum_HTM_S0	<=  2'b00;
		else if (HTM_S0_CSRB_multequal0)
					sum_HTM_S0	<=  2'b00;
		else if (HTM_S0_CSRB_multequal1)
					sum_HTM_S0	<=  2'b01;
		else if (HTM_S0_CSRB_multequal2)
					sum_HTM_S0	<=  2'b10;
		else if (HTM_S0_CSRB_multsupequal3)
					sum_HTM_S0	<=  2'b11;
		end

//sum_HTM_S1
//-----------
wire [11:0] sum_HTM_S1_int;
reg [1:0] sum_HTM_S1;

sum8bits	sum8bits_inst1 (
	.data0x ( {6'b000000,CaloSummaryRecordBitset_[23:22]} ),
	.data1x ( {6'b000000,CaloSummaryRecordBitset_L1[23:22]} ),
	.data2x ( {8'h00} ),
	.data3x ( {8'h00} ),
	.data4x ( {8'h00} ),
	.data5x ( {8'h00} ),
	.data6x ( {8'h00} ),
	.data7x ( {8'h00}	),
	.result ( sum_HTM_S1_int )
	);

always @ (sum_HTM_S1_int or n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
		begin
		HTM_S1_CSRB_multequal0		<=  1'b0; HTM_S1_CSRB_multequal1		<=  1'b0;
		HTM_S1_CSRB_multequal2		<=  1'b0; HTM_S1_CSRB_multsupequal3	<=  1'b0;
		end
		else
		begin
		HTM_S1_CSRB_multequal0		<=  sum_HTM_S1_int == 11'b00000000000;
		HTM_S1_CSRB_multequal1		<=  sum_HTM_S1_int == 11'b00000000001;
		HTM_S1_CSRB_multequal2		<=  sum_HTM_S1_int == 11'b00000000010;
		HTM_S1_CSRB_multsupequal3	<=  sum_HTM_S1_int >= 11'b00000000011;
		end
	end

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
					sum_HTM_S1	<=  2'b00;
		else if (HTM_S1_CSRB_multequal0)
					sum_HTM_S1	<=  2'b00;
		else if (HTM_S1_CSRB_multequal1)
					sum_HTM_S1	<=  2'b01;
		else if (HTM_S1_CSRB_multequal2)
					sum_HTM_S1	<=  2'b10;
		else if (HTM_S1_CSRB_multsupequal3)
					sum_HTM_S1	<=  2'b11;
		end

//sum_HTM_GVETO
//-----------
wire [11:0] sum_HTM_GVETO_int;
wire [1:0] sum_HTM_GVETO;

sum8bits	sum8bits_inst2 (
	.data0x ( {6'b000000,CaloSummaryRecordBitset_[25:24]} ),
	.data1x ( {6'b000000,CaloSummaryRecordBitset_L1[25:24]} ),
	.data2x ( {8'h00} ),
	.data3x ( {8'h00} ),
	.data4x ( {8'h00} ),
	.data5x ( {8'h00} ),
	.data6x ( {8'h00} ),
	.data7x ( {8'h00}	),
	.result ( sum_HTM_GVETO_int )
	);

always @ (sum_HTM_GVETO_int or n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
		begin
		HTM_GVETO_CSRB_multequal0		<=  1'b0; HTM_GVETO_CSRB_multequal1		<=  1'b0;
		HTM_GVETO_CSRB_multequal2		<=  1'b0; HTM_GVETO_CSRB_multsupequal3	<=  1'b0;
		end
		else
		begin
		HTM_GVETO_CSRB_multequal0		<=  sum_HTM_GVETO_int == 11'b00000000000;
		HTM_GVETO_CSRB_multequal1		<=  sum_HTM_GVETO_int == 11'b00000000001;
		HTM_GVETO_CSRB_multequal2		<=  sum_HTM_GVETO_int == 11'b00000000010;
		HTM_GVETO_CSRB_multsupequal3		<=  sum_HTM_GVETO_int >= 11'b00000000011;
		end
	end

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
					sum_HTM_GVETO	<=  2'b00;
		else if (HTM_GVETO_CSRB_multequal0)
					sum_HTM_GVETO	<=  2'b00;
		else if (HTM_GVETO_CSRB_multequal1)
					sum_HTM_GVETO	<=  2'b01;
		else if (HTM_GVETO_CSRB_multequal2)
					sum_HTM_GVETO	<=  2'b10;
		else if (HTM_GVETO_CSRB_multsupequal3)
					sum_HTM_GVETO	<=  2'b11;
		end

//Side0-and-Side1
//---------------
//sum_W_ZW_S0
//-----------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
					sum_W_ZW_S0[9:0]		<=  10'b0000000000;
		else
			for (i=0; i<10; i=i+1)
					sum_W_ZW_S0[i]	<= CaloSummaryRecordBitset_[i] |	CaloSummaryRecordBitset_L1[i];
	end

//sum_W_ZW_S1
//-----------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
					sum_W_ZW_S1[9:0]		<=  10'b0000000000;
		else
			for (i=0; i<10; i=i+1)
					sum_W_ZW_S1[i]	<= CaloSummaryRecordBitset_[i+10] |	CaloSummaryRecordBitset_L1[i+10];
	end

//sum_LTO_S0
//----------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
				sum_LTO_S0 <= 	1'b0;
		else
				sum_LTO_S0 <=	CaloSummaryRecordBitset_[26] | CaloSummaryRecordBitset_L1[26];
	end

//sum_LTO_S1
//----------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
				sum_LTO_S1 <= 	1'b0;
		else
				sum_LTO_S1 <=	CaloSummaryRecordBitset_[27] | CaloSummaryRecordBitset_L1[27];
	end

//sum_LTO_GVETO
//-------------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
				sum_LTO_GVETO <= 1'b0;

		else
				sum_LTO_GVETO <= CaloSummaryRecordBitset_[28] | CaloSummaryRecordBitset_L1[28];
	end

//sum_SScoinc
//-----------
assign sum_SScoinc = (|sum_W_ZW_S0 && !(|sum_W_ZW_S1)) || (!(|sum_W_ZW_S0) && |sum_W_ZW_S1) ? 1'b1 : 1'b0;

//sum_XT
//------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
				sum_XT <= 3'b000;

		else
			for (i=0; i<3; i=i+1)
					sum_XT[i]	<= CaloSummaryRecordBitset_[i+31] |	CaloSummaryRecordBitset_L1[i+31];
	end

//dff_CaloDecision
//----------------
wire [1:0] count;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin
  if (~n_reset_all_fpga) begin
			dff_CaloDecision	<= 1'b0;
			dff1_CaloDecision	<= 1'b0;
			end

  else 	begin
			dff_CaloDecision	<= CaloDecision;
			dff1_CaloDecision	<= dff_CaloDecision;
			end
  end

// During the Coincidence Window (retriggered) CaloSummaryBitset_L1 is updated each 4 x 25ns
L1_merge_counter	L1_merge_counter_inst (
	.aclr ( !n_reset_all_fpga ),
	.clock ( clk40_To_FPGA ),
	.cnt_en ( Coincidence_Window ),
	.q ( count )
	);

reg countequal3;

always @ (count or n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
		begin
		countequal3	<=  1'b0;
		end
		else
		begin
 		countequal3	<=  (count == 2'b11);
		end
	end

//CaloSummaryRecordBitset_L1
//--------------------------
/*always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga) begin
  if (~n_reset_all_fpga) begin
			CaloSummaryRecordBitset_L1[34:0]	<= 34'h000000000;
		  end
  else if (countequal3) begin
					CaloSummaryRecordBitset_L1[34:0]	<=  {1'b1,sum_XT[2:0],1'b1,sum_SScoinc,sum_LTO_GVETO,sum_LTO_S1,sum_LTO_S0,sum_HTM_GVETO[1:0],sum_HTM_S1[1:0],sum_HTM_S0[1:0],sum_W_ZW_S1[9:0],sum_W_ZW_S0[9:0]};
													// Calo decision = 1           TTM = 1
 		 end
  end
*/

//Coincidence_Window_width_reg
//----------------------------
// modif pour Manchester
/*
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
begin
  if (~n_reset_all_fpga) begin
			CaloSummaryRecordBitset_L1[34:0]	<= 34'h000000000;
		  end
  else if (CaloDecision == 1'b1)
			CaloSummaryRecordBitset_L1[34:0]	<= CaloSummaryRecordBitset_;

  else if(dff_Close_Coincidence_Window == 1'b1)
			CaloSummaryRecordBitset_L1[34:0]	<= 34'h000000000;
  end
*/

reg Coincidence_Window_dff;
reg CaloDecision_dff,CaloDecision_dff2;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
begin
  if (~n_reset_all_fpga) begin
	Coincidence_Window_dff 	<= 1'b0;
	CaloDecision_dff 			<= 1'b0;
	CaloDecision_dff2 		<= 1'b0;
	end
else begin
	Coincidence_Window_dff  <= Coincidence_Window;
	CaloDecision_dff 			<= CaloDecision;
	CaloDecision_dff2 		<= CaloDecision_dff;
	end
end


wire overflow_HTM_S0, overflow_HTM_S1, overflow_HTM_GVETO;
wire [1:0]result_sum_HTM_S0;
wire [1:0]result_sum_HTM_S1;
wire [1:0]result_sum_HTM_GVETO;

sum_2bits	m_sum_2bits_HTM_S0 (
	.clock (clk40_To_FPGA),
	.dataa ( CaloSummaryRecordBitset_L1[21:20] ),
	.datab ( CaloSummaryRecordBitset_[21:20] ),
	.overflow (overflow_HTM_S0 ),
	.result ( result_sum_HTM_S0 )
	);

sum_2bits	m_sum_2bits_HTM_S1 (
	.clock (clk40_To_FPGA),
	.dataa ( CaloSummaryRecordBitset_L1[23:22] ),
	.datab ( CaloSummaryRecordBitset_[23:22] ),
	.overflow (overflow_HTM_S1 ),
	.result ( result_sum_HTM_S1 )
	);

	sum_2bits	m_sum_2bits_HTM_GVETO (
	.clock (clk40_To_FPGA),
	.dataa ( CaloSummaryRecordBitset_L1[25:24] ),
	.datab ( CaloSummaryRecordBitset_[25:24]),
	.overflow (overflow_HTM_GVETO ),
	.result ( result_sum_HTM_GVETO)
	);

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
begin
  if (~n_reset_all_fpga) begin
			CaloSummaryRecordBitset_L1[34:0]	<= 34'h000000000;
		  end
  else if (Coincidence_Window == 1'b1 && Coincidence_Window_dff == 1'b0) // début coincidence window on fige l'état de CaloSummaryRecordBitset_
			CaloSummaryRecordBitset_L1[34:0]	<= CaloSummaryRecordBitset_;
  else if(dff_Close_Coincidence_Window == 1'b1) // fin de coincidence window on reset CaloSummaryRecordBitset_L1
			CaloSummaryRecordBitset_L1[34:0]	<= 34'h000000000;
  else if( Coincidence_Window == 1'b1) // mise à jour de CaloSummaryRecordBitset_L1 pendant toute la durée d'ouverture de la Coincidence_window
    begin
	    CaloSummaryRecordBitset_L1[19:0] <= CaloSummaryRecordBitset_L1[19:0] | CaloSummaryRecordBitset_[19:0];
		 CaloSummaryRecordBitset_L1[34:26] <= CaloSummaryRecordBitset_L1[34:26] | CaloSummaryRecordBitset_[34:26];

		 if(CaloDecision_dff == 1'b1 && CaloDecision_dff2 == 1'b0) // On met à jour les multiplicités au moment de la prise de Décision Calo avec un retard d'un coup d'horloge pour être sûr que les sommes sont déjà bonnes
		 begin
			CaloSummaryRecordBitset_L1[21:20] <= {result_sum_HTM_S0[1]|overflow_HTM_S0, result_sum_HTM_S0[0]|overflow_HTM_S0}; // HTM_S0

			CaloSummaryRecordBitset_L1[23:22] <= {result_sum_HTM_S1[1]|overflow_HTM_S1, result_sum_HTM_S1[0]|overflow_HTM_S1}; // HTM_S1

			CaloSummaryRecordBitset_L1[25:24] <= {result_sum_HTM_GVETO[1]|overflow_HTM_GVETO, result_sum_HTM_GVETO[0]|overflow_HTM_GVETO}; // HTM_GVETO

		 end


	 end
  end


always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)
	begin
		if (!n_rst_phaser)
			Coincidence_Window		<=  1'b0;
		else 	if(dff_Close_Coincidence_Window == 1'b1)	// to add a setup register for calo multiplicity threshold.
			Coincidence_Window		<=  1'b0;
		else 	if(CaloDecision == 1'b1)	// to add a setup register for calo multiplicity threshold.
			Coincidence_Window		<=  1'b1;
	end

//Coincidence_Window_width_counter
//--------------------------------
//init_counter
//------------
wire init_counter;

assign init_counter = dff_Close_Coincidence_Window | (Coincidence_Window & CaloDecision);

always @(posedge clock1600 or negedge n_reset_all_fpga or posedge init_counter)	begin
    if (~n_reset_all_fpga)
			Coincidence_Window_width_counter[5:0] = 6'b000000;
		else if (init_counter)
			Coincidence_Window_width_counter[5:0] = 6'b000000;
		else if (Coincidence_Window)
			Coincidence_Window_width_counter[5:0] =  Coincidence_Window_width_counter[5:0] + 1'b1;
		else
			Coincidence_Window_width_counter[5:0] =  Coincidence_Window_width_counter[5:0];
end

assign Close_Coincidence_Window = (Coincidence_Window_width_counter[5:0] == Coincidence_Window_width_reg[5:0]);

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
			dff_Close_Coincidence_Window		<= 	1'b0;
	else
			dff_Close_Coincidence_Window		<= 	Close_Coincidence_Window;
end


//------------------------ processing CARACO Decision ----------------------------
//--------------------------------------------------------------------------------
wire [19:0]	CARACO_Decision_Of_the_Zone;

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst0
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z0_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1({CaloSummaryRecordBitset_L1[1:0],1'b0}) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[0]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst1
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z1_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[2:0]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[1]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst2
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z2_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[3:1]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[2]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst3
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z3_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[4:2]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[3]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst4
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z4_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[5:3]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[4]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst5
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z5_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[6:4]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[5]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst6
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z6_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[7:5]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[6]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst7
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z7_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[8:6]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[7]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst8
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z8_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[9:7]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[8]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst9
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S0Z9_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1({1'b0,CaloSummaryRecordBitset_L1[9:8]}) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[9]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

//S1
//--
compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst10
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z0_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1({CaloSummaryRecordBitset_L1[11:10],1'b0}) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[10]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst11
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z1_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[12:10]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[11]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst12
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z2_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[13:11]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[12]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst13
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z3_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[14:12]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[13]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst14
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z4_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[15:13]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[14]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst15
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z5_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[16:14]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[15]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst16
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z6_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[17:15]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[16]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst17
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z7_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[18:16]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[17]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst18
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z8_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1(CaloSummaryRecordBitset_L1[19:17]) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[18]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

compute_CARACO_Decision_Of_One_Zone compute_CARACO_Decision_Of_One_Zone_inst19
(
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA_sig
	.rst_phaser(!n_rst_phaser) ,	// input  rst_phaser_sig
	.TSZB_SZ_(TSZB_S1Z9_[4:2]) ,	// input [2:0] TSZB_SZ__sig
	.CaloSummaryRecordBitset_L1({1'b0,CaloSummaryRecordBitset_L1[19:18]}) ,	// input [2:0] CaloSummaryRecordBitset_L1_sig
	.Coincidence_Window(Coincidence_Window) ,	// input  Coincidence_Window_sig
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK_sig
	.CARACO_Decision_Of_the_Zone(CARACO_Decision_Of_the_Zone[19]) 	// output  CARACO_Decision_Of_the_Zone_sig
);

wire	CARACO_Decision_int;
reg	CARACO_Decision,dff1_CARACO_Decision,dff2_CARACO_Decision,dff3_CARACO_Decision;

assign CARACO_Decision_int = |CARACO_Decision_Of_the_Zone[19:0];

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
	begin
			CARACO_Decision		<= 	1'b0;
			dff1_CARACO_Decision	<= 	1'b0;
			dff2_CARACO_Decision	<= 	1'b0;
			dff3_CARACO_Decision	<= 	1'b0;
	end
	else
	begin
			CARACO_Decision		<= 	CARACO_Decision_int;
			dff1_CARACO_Decision	<= 	CARACO_Decision;
			dff2_CARACO_Decision	<= 	dff1_CARACO_Decision;
			dff3_CARACO_Decision	<= 	dff2_CARACO_Decision;
	end
end

//CARACO_Decision_Gate
//--------------------
reg	CARACO_Decision_Gate;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga or posedge dff_Close_Coincidence_Window)
begin
  if (~n_reset_all_fpga)
			CARACO_Decision_Gate <= 1'b0;
  else if (dff_Close_Coincidence_Window)
			CARACO_Decision_Gate <= 1'b0;
  else if (CARACO_Decision)
			CARACO_Decision_Gate <= 1'b1;
end


//----------------------- Previous Event Record (PER) ----------------------------
//--------------------------------------------------------------------------------
//1 PER
//------
// memorizing all the next value every end of CARACO_Decision_Gate
//----------------------------------------------------------------
/*
wire [34:0] CaloSummaryRecordBitset_L1;

wire [9:0] S0_Zoning_Word_Pattern,S1_Zoning_Word_Pattern;
wire [9:0] S0_Zoning_Word_Near_Source,S1_Zoning_Word_Near_Source;

wire [6:0] TSZB_S0Z0_,TSZB_S0Z1_,TSZB_S0Z2_,TSZB_S0Z3_,TSZB_S0Z4_,TSZB_S0Z5_,
			  TSZB_S0Z6_,TSZB_S0Z7_,TSZB_S0Z8_,TSZB_S0Z9_,TSZB_S1Z0_,TSZB_S1Z1_,
			  TSZB_S1Z2_,TSZB_S1Z3_,TSZB_S1Z4_,TSZB_S1Z5_,TSZB_S1Z6_,TSZB_S1Z7_,
			  TSZB_S1Z8_,TSZB_S1Z9_;
*/
reg	dff_CARACO_Decision_Gate;

wire	memo_PER_int;
reg	memo_PER;

wire	[9:0] PER_Gate;
wire	[3:0] sel_PER_tracker;

// end of CARACO_decision_Gate
//----------------------------
always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
begin
  if (~n_reset_all_fpga)
			dff_CARACO_Decision_Gate <= 1'b0;
  else
			dff_CARACO_Decision_Gate <= CARACO_Decision_Gate;
end

assign memo_PER_int = !CARACO_Decision_Gate & dff_CARACO_Decision_Gate ;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
begin
  if (~n_reset_all_fpga)
			memo_PER <= 1'b0;
  else
			memo_PER <= memo_PER_int;
end

wire   [31:0]  PER_trigger_ID_APE;


APE APE_inst
(
	.TSZB_S0Z0_(TSZB_S0Z0_) ,	// input [2:0] TSZB_S0Z0_
	.TSZB_S0Z1_(TSZB_S0Z1_) ,	// input [2:0] TSZB_S0Z1_
	.TSZB_S0Z2_(TSZB_S0Z2_) ,	// input [2:0] TSZB_S0Z2_
	.TSZB_S0Z3_(TSZB_S0Z3_) ,	// input [2:0] TSZB_S0Z3_
	.TSZB_S0Z4_(TSZB_S0Z4_) ,	// input [2:0] TSZB_S0Z4_
	.TSZB_S0Z5_(TSZB_S0Z5_) ,	// input [2:0] TSZB_S0Z5_
	.TSZB_S0Z6_(TSZB_S0Z6_) ,	// input [2:0] TSZB_S0Z6_
	.TSZB_S0Z7_(TSZB_S0Z7_) ,	// input [2:0] TSZB_S0Z7_
	.TSZB_S0Z8_(TSZB_S0Z8_) ,	// input [2:0] TSZB_S0Z8_
	.TSZB_S0Z9_(TSZB_S0Z9_) ,	// input [2:0] TSZB_S0Z9_
	.TSZB_S1Z0_(TSZB_S1Z0_) ,	// input [2:0] TSZB_S1Z0_
	.TSZB_S1Z1_(TSZB_S1Z1_) ,	// input [2:0] TSZB_S1Z1_
	.TSZB_S1Z2_(TSZB_S1Z2_) ,	// input [2:0] TSZB_S1Z2_
	.TSZB_S1Z3_(TSZB_S1Z3_) ,	// input [2:0] TSZB_S1Z3_
	.TSZB_S1Z4_(TSZB_S1Z4_) ,	// input [2:0] TSZB_S1Z4_
	.TSZB_S1Z5_(TSZB_S1Z5_) ,	// input [2:0] TSZB_S1Z5_
	.TSZB_S1Z6_(TSZB_S1Z6_) ,	// input [2:0] TSZB_S1Z6_
	.TSZB_S1Z7_(TSZB_S1Z7_) ,	// input [2:0] TSZB_S1Z7_
	.TSZB_S1Z8_(TSZB_S1Z8_) ,	// input [2:0] TSZB_S1Z8_
	.TSZB_S1Z9_(TSZB_S1Z9_) ,	// input [2:0] TSZB_S1Z9_
	.CARACO_Decision(CARACO_Decision),
	.CARACO_Decision_Gate(CARACO_Decision_Gate) ,
	.compute_tracker_OK(compute_tracker_OK) ,	// input  compute_tracker_OK
	.memo_PER(memo_PER) ,	// input  memo_PER
	.clk40_To_FPGA(clk40_To_FPGA) ,	// input  clk40_To_FPGA
	.clock1600(clock1600),
	.n_rst(n_reset_all_fpga) ,	// input  n_rst
	.n_rst_phaser(n_rst_phaser) ,	// input  n_rst_phaser
	.n_rst_OK(n_rst_OK) ,        	// input  n_rst_OK
	.PER_Gate(PER_Gate) ,
	.Trigger_ID(Trigger_ID),
	.sel_PER_tracker(sel_PER_tracker),
	.APE_Decision(APE_Decision), 	// output  APE_Decision_sig
	.DAVE_Decision(DAVE_Decision), // output  DAVE_Decision_sig
	.PER_trigger_ID_APE(PER_trigger_ID_APE) // ouput PER_trigger_ID_APE
);

wire disable_CARACO, disable_APE, disable_DAVE;
wire L2_is_Ext_Trig;

assign disable_CARACO = SetUp_reg[1];
assign disable_APE = SetUp_reg[2];
assign disable_DAVE = SetUp_reg[3];

wire [2:0]CaloDecision_Multiplicity;

assign CaloDecision_Multiplicity[2:0]= SetUp_reg[6:4];

assign L1_is_Ext_Trig = SetUp_reg[7];
assign L2_is_Ext_Trig = SetUp_reg[8];

wire DAQ_Debug_Mode;

assign DAQ_Debug_Mode = SetUp_reg[9];


/*always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
			L2_Decision		<= 	1'b0;
	else if( enable_acquisition == 1'b1)
			L2_Decision		<= 	(CARACO_Decision && !disable_CARACO) | (APE_Decision && !disable_APE) | (DAVE_Decision && !disable_DAVE);
end
*/


reg 	dff_L2_Decision_int;


always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
			L2_Decision_int		<= 	1'b0;
	else if( enable_acquisition == 1'b1)
			L2_Decision_int		<= (L2_is_Ext_Trig)? external_trig : ((CARACO_Decision && !disable_CARACO) | (APE_Decision && !disable_APE) | (DAVE_Decision && !disable_DAVE));
	else
			L2_Decision_int		<=  1'b0;
	end


always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)
	begin
		if (!n_reset_all_fpga)
			dff_L2_Decision_int		<=  1'b0;
		else
			dff_L2_Decision_int		<=  L2_Decision_int;
		end

// L2 Decision dure un coup d'horloge de 40MHz
reg dff_L2_Decision;

assign L2_Decision = L2_Decision_int & !dff_L2_Decision_int;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
			dff_L2_Decision		<= 	1'b0;
	else
			dff_L2_Decision		<= L2_Decision;
	end


 /* //L2_Gate
//-------
reg L2_Gate;

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)	begin
	if (~n_rst_phaser)
			L2_Gate		<= 	1'b0;
	else	if(L2_Decision == 1'b1)
			L2_Gate		<= 	1'b1;
	else if( (dff_Close_Coincidence_Window == 1'b1) || (Coincidence_Window == 1'b0))
			L2_Gate		<= 	1'b0;

end

*/

//-------------------------------------------------------------
//Aout 2018  Orsay Thierry
//-------------------------------------------------------------
//L2_Gate
//-------
reg L2_Gate;

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)	begin
	if (~n_rst_phaser)
			L2_Gate		<= 	1'b0;
	else	if(L2_Decision == 1'b1)		//CARACO or APE or DAVE
			L2_Gate		<= 	1'b1;
	else if(notL2_memo)		// trou de L2_Decision
			L2_Gate		<= 	1'b0;

end
//-------------------------------------------------------------
//-------------------------------------------------------------
//-------------------------------------------------------------



//L2_scan_window
//--------------
reg	L2_scan_window;
reg	dff_L2_scan_window;
wire 	end_of_scan;
reg	dff_end_of_scan,dff1_end_of_scan;
reg  dff_clock1600;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
		dff_clock1600 <= 1'b0;
	else
	   dff_clock1600 <= clock1600;
end


always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
			L2_scan_window		<= 	1'b0;
	else	if (!clock1600 && dff_clock1600)
			L2_scan_window		<= 	1'b0;
	else	if(compute_tracker_OK)
			L2_scan_window		<= 	1'b1;
end

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
			dff_L2_scan_window	<= 	1'b0;
	else
			dff_L2_scan_window	<= 	L2_scan_window;
end

assign end_of_scan =	dff_L2_scan_window & !L2_scan_window;


always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga) begin
			dff_end_of_scan		<= 	1'b0;
			dff1_end_of_scan		<= 	1'b0;
			end
	else	begin
			dff_end_of_scan		<= 	end_of_scan;
			dff1_end_of_scan		<= 	dff_end_of_scan;
			end
end

//L2_detected (L2_decision extended to the end of L2 scan window)
//---------------------------------------------------------------
reg 		L2_detected;
wire		n_rst_L2_detected;
reg		L2_memo,notL2_memo;
wire		n_rst_L2_memo,n_rst_notL2_memo;
reg		dff_notL2_memo,dff1_notL2_memo,dff2_notL2_memo;

assign	n_rst_L2_detected = !dff_end_of_scan  & n_reset_all_fpga;

always @ (posedge clk40_To_FPGA or negedge n_rst_L2_detected)	begin		//caraco or APE or DAVE
	if (~n_rst_L2_detected)
			L2_detected <= 1'b0;
	else	if(L2_Decision)
			L2_detected <= 1'b1;
end

assign 	n_rst_L2_memo = n_reset_all_fpga & !dff2_notL2_memo;

always @ (posedge clk40_To_FPGA or negedge n_rst_L2_memo)	begin
	if (~n_rst_L2_memo)
			L2_memo 	<= 1'b0;
	else	if (L2_Gate & L2_detected & end_of_scan )
			L2_memo <= 	1'b1;
end

assign 	n_rst_notL2_memo = !L2_detected & n_reset_all_fpga;



always @ (posedge clk40_To_FPGA or negedge n_rst_notL2_memo)	begin
	if (~n_rst_notL2_memo)
			notL2_memo 	<= 1'b0;
	else	if (L2_Gate & !L2_detected & end_of_scan )
			notL2_memo <= 	1'b1;
end

always @ (posedge clk40_To_FPGA or negedge n_rst_notL2_memo)	begin
	if (~n_rst_notL2_memo) 	begin
			dff_notL2_memo 	<= 1'b0;
			dff1_notL2_memo 	<= 1'b0;
			dff2_notL2_memo 	<= 1'b0;
			end
	else	begin
			dff_notL2_memo <= 	notL2_memo;
			dff1_notL2_memo 	<= dff_notL2_memo;
			dff2_notL2_memo 	<= dff1_notL2_memo ;
			end
end

// fin récupération thierry

reg L2_Gate_dff;

always @ (posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
	if (~n_reset_all_fpga)
		L2_Gate_dff		<= 	1'b0;
	else
		L2_Gate_dff   <= L2_Gate;

end

//Trigger_ID
//----------
reg	[31:0]	Trigger_ID;

always @(posedge clk40_To_FPGA or negedge n_rst_phaser)	begin
    if (~n_rst_phaser)
			Trigger_ID[31:0] <= 31'h00000000;
		else if (L2_Gate == 1'b1 & L2_Gate_dff == 1'b0)
			Trigger_ID[31:0] <=  Trigger_ID[31:0] + 1'b1;
		else
			Trigger_ID[31:0] <=  Trigger_ID[31:0];
end

reg L2_decision_for_CB; // for commissionning Manchester

always @(posedge clk40_To_FPGA or negedge n_rst_phaser)	begin
    if (~n_rst_phaser)
			L2_decision_for_CB <= 1'b0;
		else if (L2_Gate == 1'b1 & L2_Gate_dff == 1'b0)
			L2_decision_for_CB  <= 1'b1;
		else
			L2_decision_for_CB <= 1'b0;
end

///////////////////////////////////
// attention à clocker sur front descendant pour le sérialiseur


always @(posedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
    if (~n_reset_all_fpga) begin
			DataTransto_CB_0_int <=  18'h00000;
			DataTransto_CB_1_int <=  18'h00000;
			DataTransto_CB_2_int <=  18'h00000;
			DataTransto_CB_3_int <=  18'h00000;
			DataTransto_CB_4_int <=  18'h00000;
			DataTransto_CB_5_int <=  18'h00000;
			end
		else begin
			DataTransto_CB_0_int <=  {sync_out_to_all_systems, 10'h0,L1_Calo,L2_decision_for_CB,Trigger_ID[4:0]};
			DataTransto_CB_1_int <=  {sync_out_to_all_systems, 10'h0,L1_Calo,L2_decision_for_CB,Trigger_ID[4:0]};
			DataTransto_CB_2_int <=  {sync_out_to_all_systems, 10'h0,L1_Calo,L2_decision_for_CB,Trigger_ID[4:0]};
			DataTransto_CB_3_int <=  {sync_out_to_all_systems, 10'h0,L1_Calo,L2_decision_for_CB,Trigger_ID[4:0]};
			DataTransto_CB_4_int <=  {sync_out_to_all_systems, 10'h0,L1_Calo,L2_decision_for_CB,Trigger_ID[4:0]};
			DataTransto_CB_5_int <=  {sync_out_to_all_systems, 10'h0,L1_Calo,L2_decision_for_CB,Trigger_ID[4:0]};
			end
	end



always @(negedge clk40_To_FPGA or negedge n_reset_all_fpga)	begin
    if (~n_reset_all_fpga) begin
			DataTransto_CB_0_ <=  18'h00000;
			DataTransto_CB_1_ <=  18'h00000;
			DataTransto_CB_2_ <=  18'h00000;
			DataTransto_CB_3_ <=  18'h00000;
			DataTransto_CB_4_ <=  18'h00000;
			DataTransto_CB_5_ <=  18'h00000;
			end
		else begin
			DataTransto_CB_0_  <=  DataTransto_CB_0_int;
			DataTransto_CB_1_  <=  DataTransto_CB_1_int;
			DataTransto_CB_2_  <=  DataTransto_CB_2_int;
			DataTransto_CB_3_  <=  DataTransto_CB_3_int;
			DataTransto_CB_4_  <=  DataTransto_CB_4_int;
			DataTransto_CB_5_  <=  DataTransto_CB_5_int;
			end
	end

wire error, L1_Calo, L2_Tracker;

assign error = error_clock800Id_allCBtoTB;

assign L1_Calo = 	L1_is_Ext_Trig? (external_trig && enable_acquisition) : CaloDecision;

assign L2_Tracker = L2_Decision;


//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//---- Event Buffer:used to transmit information to the DAQ depending on L2 ------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//Stamps																	1 x 128bits
//------
reg [31:0] 	dff_Trigger_ID; //32bits
reg [31:0]	dff_clock1600periodcounter; //32bits

//Whole Matrice														3 x 684bits <=> 3x (7words of 128bits) used in Eventbuffer
//-------------
reg [683:0]	dff_TPsfromCB0FromStreaming_;			//19 x 36bits
reg [683:0]	dff_TPsfromCB1FromStreaming_;			//19 x 36bits
reg [683:0]	dff_TPsfromCB2FromStreaming_;			//19 x 36bits

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)	begin
	if (~n_rst_phaser) begin
			dff_Trigger_ID						<= 	32'h00000000;
			dff_clock1600periodcounter		<= 	32'h00000000;
			dff_TPsfromCB0FromStreaming_	<= 	684'h00000000;			//19 x 36bits
			dff_TPsfromCB1FromStreaming_	<= 	684'h00000000;			//19 x 36bits
			dff_TPsfromCB2FromStreaming_	<= 	684'h00000000;			//19 x 36bits
				end
//else	if (notL2_memo & L2_Decision )	begin
	//jihane 21/11/2022
	else	if (L2_Decision )	begin
			dff_Trigger_ID						<= 	Trigger_ID;
			dff_clock1600periodcounter		<= 	clock1600periodcounter;
			dff_TPsfromCB0FromStreaming_	<= 	TPsfromCB0FromStreaming_;			//19 x 36bits
			dff_TPsfromCB1FromStreaming_	<= 	TPsfromCB1FromStreaming_;			//19 x 36bits
			dff_TPsfromCB2FromStreaming_	<= 	TPsfromCB2FromStreaming_;			//19 x 36bits
			end
end

//Tracker
//-------
//20 zones's projections		20 words of 128bit used in Eventbuffer
//----------------------
reg [31:0] 	dff_PR_S0Z0,dff_PR_S0Z1,dff_PR_S0Z2,dff_PR_S0Z3,dff_PR_S0Z4,dff_PR_S0Z5,dff_PR_S0Z6,dff_PR_S0Z7,dff_PR_S0Z8,dff_PR_S0Z9;
reg [63:0] 	dff_PL_S0Z0,dff_PL_S0Z1,dff_PL_S0Z2,dff_PL_S0Z3,dff_PL_S0Z4,dff_PL_S0Z5,dff_PL_S0Z6,dff_PL_S0Z7,dff_PL_S0Z8,dff_PL_S0Z9;
reg [23:0]	dff_VSZB_HSZB_TSZB_S0Z0,dff_VSZB_HSZB_TSZB_S0Z1,dff_VSZB_HSZB_TSZB_S0Z2,dff_VSZB_HSZB_TSZB_S0Z3,dff_VSZB_HSZB_TSZB_S0Z4,
				dff_VSZB_HSZB_TSZB_S0Z5,dff_VSZB_HSZB_TSZB_S0Z6,dff_VSZB_HSZB_TSZB_S0Z7,dff_VSZB_HSZB_TSZB_S0Z8,dff_VSZB_HSZB_TSZB_S0Z9;

reg [31:0] 	dff_PR_S1Z0,dff_PR_S1Z1,dff_PR_S1Z2,dff_PR_S1Z3,dff_PR_S1Z4,dff_PR_S1Z5,dff_PR_S1Z6,dff_PR_S1Z7,dff_PR_S1Z8,dff_PR_S1Z9;
reg [63:0] 	dff_PL_S1Z0,dff_PL_S1Z1,dff_PL_S1Z2,dff_PL_S1Z3,dff_PL_S1Z4,dff_PL_S1Z5,dff_PL_S1Z6,dff_PL_S1Z7,dff_PL_S1Z8,dff_PL_S1Z9;
reg [23:0]	dff_VSZB_HSZB_TSZB_S1Z0,dff_VSZB_HSZB_TSZB_S1Z1,dff_VSZB_HSZB_TSZB_S1Z2,dff_VSZB_HSZB_TSZB_S1Z3,dff_VSZB_HSZB_TSZB_S1Z4,
				dff_VSZB_HSZB_TSZB_S1Z5,dff_VSZB_HSZB_TSZB_S1Z6,dff_VSZB_HSZB_TSZB_S1Z7,dff_VSZB_HSZB_TSZB_S1Z8,dff_VSZB_HSZB_TSZB_S1Z9;

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)	begin
	if (~n_rst_phaser) begin
			dff_PR_S0Z0 <= 32'h00000000;dff_PL_S0Z0 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z0 <= 24'h000000;
			dff_PR_S0Z1 <= 32'h00000000;dff_PL_S0Z1 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z1 <= 24'h000000;
			dff_PR_S0Z2 <= 32'h00000000;dff_PL_S0Z2 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z2 <= 24'h000000;
			dff_PR_S0Z3 <= 32'h00000000;dff_PL_S0Z3 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z3 <= 24'h000000;
			dff_PR_S0Z4 <= 32'h00000000;dff_PL_S0Z4 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z4 <= 24'h000000;
			dff_PR_S0Z5 <= 32'h00000000;dff_PL_S0Z5 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z5 <= 24'h000000;
			dff_PR_S0Z6 <= 32'h00000000;dff_PL_S0Z6 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z6 <= 24'h000000;
			dff_PR_S0Z7 <= 32'h00000000;dff_PL_S0Z7 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z7 <= 24'h000000;
			dff_PR_S0Z8 <= 32'h00000000;dff_PL_S0Z8 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z8 <= 24'h000000;
			dff_PR_S0Z9 <= 32'h00000000;dff_PL_S0Z9 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S0Z9 <= 24'h000000;
			dff_PR_S1Z0 <= 32'h00000000;dff_PL_S1Z0 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z0 <= 24'h000000;
			dff_PR_S1Z1 <= 32'h00000000;dff_PL_S1Z1 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z1 <= 24'h000000;
			dff_PR_S1Z2 <= 32'h00000000;dff_PL_S1Z2 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z2 <= 24'h000000;
			dff_PR_S1Z3 <= 32'h00000000;dff_PL_S1Z3 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z3 <= 24'h000000;
			dff_PR_S1Z4 <= 32'h00000000;dff_PL_S1Z4 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z4 <= 24'h000000;
			dff_PR_S1Z5 <= 32'h00000000;dff_PL_S1Z5 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z5 <= 24'h000000;
			dff_PR_S1Z6 <= 32'h00000000;dff_PL_S1Z6 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z6 <= 24'h000000;
			dff_PR_S1Z7 <= 32'h00000000;dff_PL_S1Z7 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z7 <= 24'h000000;
			dff_PR_S1Z8 <= 32'h00000000;dff_PL_S1Z8 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z8 <= 24'h000000;
			dff_PR_S1Z9 <= 32'h00000000;dff_PL_S1Z9 <= 64'h0000000000;dff_VSZB_HSZB_TSZB_S1Z9 <= 24'h000000;
			end
	//else	if (notL2_memo & L2_Decision )	begin
	//jihane 21/11/2022
	else	if (L2_Decision )	begin
			dff_PR_S0Z0[31:0]			<= 	{PR_SZA_S0Z0_,PR_SZB_S0Z0_,PR_SZC_S0Z0_,PR_SZD_S0Z0_};	//32bits
			dff_PL_S0Z0[63:0]					<= 	{7'b0000000,PL_SZA_S0Z0_[8],PL_SZA_S0Z0_[7:0],7'b0000000,PL_SZB_S0Z0_[8],PL_SZB_S0Z0_[7:0],
													 7'b0000000,PL_SZC_S0Z0_[8],PL_SZC_S0Z0_[7:0],7'b0000000,PL_SZD_S0Z0_[8],PL_SZD_S0Z0_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z0[23:0]	<= 	{VSZB_S0Z0_[7:0],HSZB_S0Z0_[7:0],1'b0,TSZB_S0Z0_[6:0]};	//24bits

			dff_PR_S0Z1					<= 	{PR_SZA_S0Z1_,PR_SZB_S0Z1_,PR_SZC_S0Z1_,PR_SZD_S0Z1_};	//32bits
			dff_PL_S0Z1					<= 	{7'b0000000,PL_SZA_S0Z1_[8],PL_SZA_S0Z1_[7:0],7'b0000000,PL_SZB_S0Z1_[8],PL_SZB_S0Z1_[7:0],
													 7'b0000000,PL_SZC_S0Z1_[8],PL_SZC_S0Z1_[7:0],7'b0000000,PL_SZD_S0Z1_[8],PL_SZD_S0Z1_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z1	<= 	{VSZB_S0Z1_[7:0],HSZB_S0Z1_[7:0],1'b0,TSZB_S0Z1_[6:0]};	//24bits

			dff_PR_S0Z2					<= 	{PR_SZA_S0Z2_,PR_SZB_S0Z2_,PR_SZC_S0Z2_,PR_SZD_S0Z2_};	//32bits
			dff_PL_S0Z2					<= 	{7'b0000000,PL_SZA_S0Z2_[8],PL_SZA_S0Z2_[7:0],7'b0000000,PL_SZB_S0Z2_[8],PL_SZB_S0Z2_[7:0],
													 7'b0000000,PL_SZC_S0Z2_[8],PL_SZC_S0Z2_[7:0],7'b0000000,PL_SZD_S0Z2_[8],PL_SZD_S0Z2_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z2	<= 	{VSZB_S0Z2_[7:0],HSZB_S0Z2_[7:0],1'b0,TSZB_S0Z2_[6:0]};	//24bits

			dff_PR_S0Z3					<= 	{PR_SZA_S0Z3_,PR_SZB_S0Z3_,PR_SZC_S0Z3_,PR_SZD_S0Z3_};	//32bits
			dff_PL_S0Z3					<= 	{7'b0000000,PL_SZA_S0Z3_[8],PL_SZA_S0Z3_[7:0],7'b0000000,PL_SZB_S0Z3_[8],PL_SZB_S0Z3_[7:0],
													 7'b0000000,PL_SZC_S0Z3_[8],PL_SZC_S0Z3_[7:0],7'b0000000,PL_SZD_S0Z3_[8],PL_SZD_S0Z3_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z3	<= 	{VSZB_S0Z3_[7:0],HSZB_S0Z3_[7:0],1'b0,TSZB_S0Z3_[6:0]};//24bits

			dff_PR_S0Z4					<= 	{PR_SZA_S0Z4_,PR_SZB_S0Z4_,PR_SZC_S0Z4_,PR_SZD_S0Z4_};	//32bits
			dff_PL_S0Z4					<= 	{7'b0000000,PL_SZA_S0Z4_[8],PL_SZA_S0Z4_[7:0],7'b0000000,PL_SZB_S0Z4_[8],PL_SZB_S0Z4_[7:0],
													 7'b0000000,PL_SZC_S0Z4_[8],PL_SZC_S0Z4_[7:0],7'b0000000,PL_SZD_S0Z4_[8],PL_SZD_S0Z4_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z4	<= 	{VSZB_S0Z4_[7:0],HSZB_S0Z4_[7:0],1'b0,TSZB_S0Z4_[6:0]};	//24bits

			dff_PR_S0Z5					<= 	{PR_SZA_S0Z5_,PR_SZB_S0Z5_,PR_SZC_S0Z5_,PR_SZD_S0Z5_};	//32bits
			dff_PL_S0Z5					<= 	{7'b0000000,PL_SZA_S0Z5_[8],PL_SZA_S0Z5_[7:0],7'b0000000,PL_SZB_S0Z5_[8],PL_SZB_S0Z5_[7:0],
													 7'b0000000,PL_SZC_S0Z5_[8],PL_SZC_S0Z5_[7:0],7'b0000000,PL_SZD_S0Z5_[8],PL_SZD_S0Z5_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z5	<= 	{VSZB_S0Z5_[7:0],HSZB_S0Z5_[7:0],1'b0,TSZB_S0Z5_[6:0]};	//24bits

			dff_PR_S0Z6					<= 	{PR_SZA_S0Z6_,PR_SZB_S0Z6_,PR_SZC_S0Z6_,PR_SZD_S0Z6_};	//32bits
			dff_PL_S0Z6					<= 	{7'b0000000,PL_SZA_S0Z6_[8],PL_SZA_S0Z6_[7:0],7'b0000000,PL_SZB_S0Z6_[8],PL_SZB_S0Z6_[7:0],
													 7'b0000000,PL_SZC_S0Z6_[8],PL_SZC_S0Z6_[7:0],7'b0000000,PL_SZD_S0Z6_[8],PL_SZD_S0Z6_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z6	<= 	{VSZB_S0Z6_[7:0],HSZB_S0Z6_[7:0],1'b0,TSZB_S0Z6_[6:0]};	//24bits

			dff_PR_S0Z7					<= 	{PR_SZA_S0Z7_,PR_SZB_S0Z7_,PR_SZC_S0Z7_,PR_SZD_S0Z7_};	//32bits
			dff_PL_S0Z7					<= 	{7'b0000000,PL_SZA_S0Z7_[8],PL_SZA_S0Z7_[7:0],7'b0000000,PL_SZB_S0Z7_[8],PL_SZB_S0Z7_[7:0],
													 7'b0000000,PL_SZC_S0Z7_[8],PL_SZC_S0Z7_[7:0],7'b0000000,PL_SZD_S0Z7_[8],PL_SZD_S0Z7_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z7	<= 	{VSZB_S0Z7_[7:0],HSZB_S0Z7_[7:0],1'b0,TSZB_S0Z7_[6:0]};	//24bits

			dff_PR_S0Z8					<= 	{PR_SZA_S0Z8_,PR_SZB_S0Z8_,PR_SZC_S0Z8_,PR_SZD_S0Z8_};	//32bits
			dff_PL_S0Z8					<= 	{7'b0000000,PL_SZA_S0Z8_[8],PL_SZA_S0Z8_[7:0],7'b0000000,PL_SZB_S0Z8_[8],PL_SZB_S0Z8_[7:0],
													 7'b0000000,PL_SZC_S0Z8_[8],PL_SZC_S0Z8_[7:0],7'b0000000,PL_SZD_S0Z8_[8],PL_SZD_S0Z8_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z8	<= 	{VSZB_S0Z8_[7:0],HSZB_S0Z8_[7:0],1'b0,TSZB_S0Z8_[6:0]};	//24bits

			dff_PR_S0Z9					<= 	{PR_SZA_S0Z9_,PR_SZB_S0Z9_,PR_SZC_S0Z9_,PR_SZD_S0Z9_};	//32bits
			dff_PL_S0Z9					<= 	{7'b0000000,PL_SZA_S0Z9_[8],PL_SZA_S0Z9_[7:0],7'b0000000,PL_SZB_S0Z9_[8],PL_SZB_S0Z9_[7:0],
													 7'b0000000,PL_SZC_S0Z9_[8],PL_SZC_S0Z9_[7:0],7'b0000000,PL_SZD_S0Z9_[8],PL_SZD_S0Z9_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S0Z9	<= 	{VSZB_S0Z9_[7:0],HSZB_S0Z9_[7:0],1'b0,TSZB_S0Z9_[6:0]};	//24bits

			dff_PR_S1Z0					<= 	{PR_SZA_S1Z0_,PR_SZB_S1Z0_,PR_SZC_S1Z0_,PR_SZD_S1Z0_};	//32bits
			dff_PL_S1Z0					<= 	{7'b0000000,PL_SZA_S1Z0_[8],PL_SZA_S1Z0_[7:0],7'b0000000,PL_SZB_S1Z0_[8],PL_SZB_S1Z0_[7:0],
													 7'b0000000,PL_SZC_S1Z0_[8],PL_SZC_S1Z0_[7:0],7'b0000000,PL_SZD_S1Z0_[8],PL_SZD_S1Z0_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z0	<= 	{VSZB_S1Z0_[7:0],HSZB_S1Z0_[7:0],1'b0,TSZB_S1Z0_[6:0]};	//24bits

			dff_PR_S1Z1					<= 	{PR_SZA_S1Z1_,PR_SZB_S1Z1_,PR_SZC_S1Z1_,PR_SZD_S1Z1_};	//32bits
			dff_PL_S1Z1					<= 	{7'b0000000,PL_SZA_S1Z1_[8],PL_SZA_S1Z1_[7:0],7'b0000000,PL_SZB_S1Z1_[8],PL_SZB_S1Z1_[7:0],
													 7'b0000000,PL_SZC_S1Z1_[8],PL_SZC_S1Z1_[7:0],7'b0000000,PL_SZD_S1Z1_[8],PL_SZD_S1Z1_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z1	<= 	{VSZB_S1Z1_[7:0],HSZB_S1Z1_[7:0],1'b0,TSZB_S1Z1_[6:0]};	//24bits

			dff_PR_S1Z2					<= 	{PR_SZA_S1Z2_,PR_SZB_S1Z2_,PR_SZC_S1Z2_,PR_SZD_S1Z2_};	//32bits
			dff_PL_S1Z2					<= 	{7'b0000000,PL_SZA_S1Z2_[8],PL_SZA_S1Z2_[7:0],7'b0000000,PL_SZB_S1Z2_[8],PL_SZB_S1Z2_[7:0],
													 7'b0000000,PL_SZC_S1Z2_[8],PL_SZC_S1Z2_[7:0],7'b0000000,PL_SZD_S1Z2_[8],PL_SZD_S1Z2_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z2	<= 	{VSZB_S1Z2_[7:0],HSZB_S1Z2_[7:0],1'b0,TSZB_S1Z2_[6:0]};	//24bits

			dff_PR_S1Z3					<= 	{PR_SZA_S1Z3_,PR_SZB_S1Z3_,PR_SZC_S1Z3_,PR_SZD_S1Z3_};	//32bits
			dff_PL_S1Z3					<= 	{7'b0000000,PL_SZA_S1Z3_[8],PL_SZA_S1Z3_[7:0],7'b0000000,PL_SZB_S1Z3_[8],PL_SZB_S1Z3_[7:0],
													 7'b0000000,PL_SZC_S1Z3_[8],PL_SZC_S1Z3_[7:0],7'b0000000,PL_SZD_S1Z3_[8],PL_SZD_S1Z3_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z3	<= 	{VSZB_S1Z3_[7:0],HSZB_S1Z3_[7:0],1'b0,TSZB_S1Z3_[6:0]};	//24bits

			dff_PR_S1Z4					<= 	{PR_SZA_S1Z4_,PR_SZB_S1Z4_,PR_SZC_S1Z4_,PR_SZD_S1Z4_};	//32bits
			dff_PL_S1Z4					<= 	{7'b0000000,PL_SZA_S1Z4_[8],PL_SZA_S1Z4_[7:0],7'b0000000,PL_SZB_S1Z4_[8],PL_SZB_S1Z4_[7:0],
													 7'b0000000,PL_SZC_S1Z4_[8],PL_SZC_S1Z4_[7:0],7'b0000000,PL_SZD_S1Z4_[8],PL_SZD_S1Z4_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z4	<= 	{VSZB_S1Z4_[7:0],HSZB_S1Z4_[7:0],1'b0,TSZB_S1Z4_[6:0]};	//24bits

			dff_PR_S1Z5					<= 	{PR_SZA_S1Z5_,PR_SZB_S1Z5_,PR_SZC_S1Z5_,PR_SZD_S1Z5_};	//32bits
			dff_PL_S1Z5					<= 	{7'b0000000,PL_SZA_S1Z5_[8],PL_SZA_S1Z5_[7:0],7'b0000000,PL_SZB_S1Z5_[8],PL_SZB_S1Z5_[7:0],
													 7'b0000000,PL_SZC_S1Z5_[8],PL_SZC_S1Z5_[7:0],7'b0000000,PL_SZD_S1Z5_[8],PL_SZD_S1Z5_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z5	<= 	{VSZB_S1Z5_[7:0],HSZB_S1Z5_[7:0],1'b0,TSZB_S1Z5_[6:0]};	//24bits

			dff_PR_S1Z6					<= 	{PR_SZA_S1Z6_,PR_SZB_S1Z6_,PR_SZC_S1Z6_,PR_SZD_S1Z6_};	//32bits
			dff_PL_S1Z6					<= 	{7'b0000000,PL_SZA_S1Z6_[8],PL_SZA_S1Z6_[7:0],7'b0000000,PL_SZB_S1Z6_[8],PL_SZB_S1Z6_[7:0],
													 7'b0000000,PL_SZC_S1Z6_[8],PL_SZC_S1Z6_[7:0],7'b0000000,PL_SZD_S1Z6_[8],PL_SZD_S1Z6_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z6	<= 	{VSZB_S1Z6_[7:0],HSZB_S1Z6_[7:0],1'b0,TSZB_S1Z6_[6:0]};	//24bits

			dff_PR_S1Z7					<= 	{PR_SZA_S1Z7_,PR_SZB_S1Z7_,PR_SZC_S1Z7_,PR_SZD_S1Z7_};	//32bits
			dff_PL_S1Z7					<= 	{7'b0000000,PL_SZA_S1Z7_[8],PL_SZA_S1Z7_[7:0],7'b0000000,PL_SZB_S1Z7_[8],PL_SZB_S1Z7_[7:0],
													 7'b0000000,PL_SZC_S1Z7_[8],PL_SZC_S1Z7_[7:0],7'b0000000,PL_SZD_S1Z7_[8],PL_SZD_S1Z7_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z7	<= 	{VSZB_S1Z7_[7:0],HSZB_S1Z7_[7:0],1'b0,TSZB_S1Z7_[6:0]};	//24bits

			dff_PR_S1Z8					<= 	{PR_SZA_S1Z8_,PR_SZB_S1Z8_,PR_SZC_S1Z8_,PR_SZD_S1Z8_};	//32bits
			dff_PL_S1Z8					<= 	{7'b0000000,PL_SZA_S1Z8_[8],PL_SZA_S1Z8_[7:0],7'b0000000,PL_SZB_S1Z8_[8],PL_SZB_S1Z8_[7:0],
													 7'b0000000,PL_SZC_S1Z8_[8],PL_SZC_S1Z8_[7:0],7'b0000000,PL_SZD_S1Z8_[8],PL_SZD_S1Z8_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z8	<= 	{VSZB_S1Z8_[7:0],HSZB_S1Z8_[7:0],1'b0,TSZB_S1Z8_[6:0]};	//24bits

			dff_PR_S1Z9					<= 	{PR_SZA_S1Z9_,PR_SZB_S1Z9_,PR_SZC_S1Z9_,PR_SZD_S1Z9_};	//32bits
			dff_PL_S1Z9					<= 	{7'b0000000,PL_SZA_S1Z9_[8],PL_SZA_S1Z9_[7:0],7'b0000000,PL_SZB_S1Z9_[8],PL_SZB_S1Z9_[7:0],
													 7'b0000000,PL_SZC_S1Z9_[8],PL_SZC_S1Z9_[7:0],7'b0000000,PL_SZD_S1Z9_[8],PL_SZD_S1Z9_[7:0]};		//64bits
			dff_VSZB_HSZB_TSZB_S1Z9	<= 	{VSZB_S1Z9_[7:0],HSZB_S1Z9_[7:0],1'b0,TSZB_S1Z9_[6:0]};	//24bits
			end
	end

// last word Tracker												1 word
//------------------
reg [63:0]	dff_Zoning_Word;

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)
	begin
	if (~n_rst_phaser)
			dff_Zoning_Word			<= 	64'h0000000000;
//else	if (notL2_memo & L2_Decision )	begin
	//jihane 21/11/2022
	else	if (L2_Decision )
			dff_Zoning_Word			<= 	{7'b0000000,S1_Zoning_Word_Near_Source[8],S1_Zoning_Word_Near_Source[7:0],7'b0000000,S1_Zoning_Word_Pattern[8],S1_Zoning_Word_Pattern[7:0], // error here should be 10 bits each Zoning_Word
	 									 7'b0000000,S0_Zoning_Word_Near_Source[8],S0_Zoning_Word_Near_Source[7:0],7'b0000000,S0_Zoning_Word_Pattern[8],S0_Zoning_Word_Pattern[7:0]};


			dff_Zoning_Word			<= 	{6'b0000000,S1_Zoning_Word_Near_Source[9:8],S1_Zoning_Word_Near_Source[7:0],6'b0000000,S1_Zoning_Word_Pattern[9:8],S1_Zoning_Word_Pattern[7:0], // error here should be 10 bits each Zoning_Word
	 									 6'b0000000,S0_Zoning_Word_Near_Source[9:8],S0_Zoning_Word_Near_Source[7:0],6'b0000000,S0_Zoning_Word_Pattern[9:8],S0_Zoning_Word_Pattern[7:0]};
	end

//-----------
//Calorimeter														1 word
//-----------
reg [39:0]	dff_calorimeter;
reg		CARACO_Decision_OK,APE_Decision_OK,DAVE_Decision_OK;
wire		n_rst_OK;

assign	n_rst_OK = n_rst_phaser & !endofcount_enable;

always @ (posedge clk40_To_FPGA or negedge n_rst_OK)	begin
	if (~n_rst_OK)
			CARACO_Decision_OK	<= 	1'b0;
	else	if (L2_scan_window & CARACO_Decision)
			CARACO_Decision_OK	<= 	1'b1;
end

always @ (posedge clk40_To_FPGA or negedge n_rst_OK)	begin
	if (~n_rst_OK)
			APE_Decision_OK	<= 	1'b0;
	else	if (L2_scan_window & APE_Decision)
			APE_Decision_OK	<= 	1'b1;
end

always @ (posedge clk40_To_FPGA or negedge n_rst_OK)	begin
	if (~n_rst_OK)
			DAVE_Decision_OK	<= 	1'b0;
	else	if (L2_scan_window & DAVE_Decision)
			DAVE_Decision_OK	<= 	1'b1;
end

always @ (posedge clk40_To_FPGA or negedge n_rst_phaser)	begin
	if (~n_rst_phaser)
			dff_calorimeter	<= 	40'h0000000000;
	//else	if (notL2_memo & L2_Decision )	begin
	//jihane 21/11/2022
	else	if (L2_Decision )
			dff_calorimeter	<= 	{5'b00,CaloSummaryRecordBitset_L1[34:0]}; 		//Jihane
end

//Bilan Status for one L2_Decision 38 words (128bits)



//--------------------------------------------------------------------------------
//---- Event Buffer:used to transmit information to the DAQ depending on L2 ------
//--------------------------------------------------------------------------------
reg				dff1_L2_OK,dff2_L2_OK;
wire	[7:0] 	counterEventbuffer;
wire 				n_stop_counterEventbuffer,endofcount_enable;
wire				wren_eventbuffer;
wire	[127:0]	in_wren_eventbuffer;
wire				on_userdata_Eventbuffer;
wire				almost_empty,almost_full,empty,full;

wire [16:0] rdusedw;
wire [12:0] wrusedw;

reg   eventBuffer_almostfull;

//wren_trackerstatus_ingate_Fifo          // Coincidence window fermée
//------------------------------
Eventbuffer	Eventbuffer_inst (			//64 x 128bits
	.aclr ( !n_reset_all_fpga ),
	.data ( in_wren_eventbuffer[127:0]),
	.rdclk ( lpbus_clk ),
	.rdreq ( !n_read_eventbuffer ), //à changer
	.wrclk ( clk40_To_FPGA ),
	.wrreq ( wren_eventbuffer),
	.q (datafrom_eventbuffer[7:0]),
	.rdempty ( rdempty ),
	.rdusedw ( rdusedw ),
	.wrfull ( wrfull ),
	.wrusedw ( wrusedw )
	);


always @(posedge clk40_To_FPGA or negedge n_reset_all_fpga ) begin
if (!n_reset_all_fpga) begin
			eventBuffer_almostfull	<= 	1'b0;
						end
else 	if(wrusedw >= 13'h0F00)
			eventBuffer_almostfull	<= 	1'b1;
else
	eventBuffer_almostfull	<= 	1'b0;
end


reg read_req_from_eventbuffer;

always @(posedge clk40_To_FPGA or negedge n_reset_all_fpga ) begin
if (!n_reset_all_fpga)
			read_req_from_eventbuffer	<= 	1'b0;

else if(sel_readout_for_eventbuffer == 1'b0 && dff_sel_readout_for_eventbuffer == 1'b1)
			read_req_from_eventbuffer	<= 	1'b0;
else 	if(sel_readout_for_eventbuffer == 1'b0 && wrusedw >= 13'h005)
			read_req_from_eventbuffer	<= 	1'b1;
end

reg 	dff_sel_readout_for_eventbuffer;


always @(posedge clk40_To_FPGA or negedge n_reset_all_fpga ) begin
if (!n_reset_all_fpga)
	dff_sel_readout_for_eventbuffer	<= 	1'b0;
else
	dff_sel_readout_for_eventbuffer  <= sel_readout_for_eventbuffer;

end


//-------------------------------------------------------------
//Aout 2018  Orsay Thierry
//-------------------------------------------------------------

always @(posedge clk40_To_FPGA or negedge n_rst_phaser ) begin
if (!n_rst_phaser) begin
			dff1_L2_OK 	<= 	1'b0;
			dff2_L2_OK 	<= 	1'b0;
						end
else 	begin
			dff1_L2_OK 	<= 	notL2_memo  & L2_Decision & (Coincidence_Window == 1'b0) ;
			dff2_L2_OK 	<= 	dff1_L2_OK;
		end
end

assign n_stop_counterEventbuffer = n_rst_phaser & !endofcount_enable;

always @ (posedge clk40_To_FPGA or negedge n_stop_counterEventbuffer) begin
  if (~n_stop_counterEventbuffer)
			wren_eventbuffer 	<= 1'b0;
  else if(dff_L2_Decision && eventBuffer_almostfull == 1'b0) // on ne commence pas l'écriture d'un évènement si l'event buffer est almost full.
			wren_eventbuffer 	<= 1'b1;
		  else;
  end



//counterEventbuffer
//------------------
counters8bits	counters8bits_inst (
	.aclr ( !n_stop_counterEventbuffer ),
	.clock ( clk40_To_FPGA ),
	.cnt_en ( wren_eventbuffer ),
	.q ( counterEventbuffer )
	);

wire dataSize_in_words = (DAQ_Debug_Mode)? 8'h27 : 8'h13; // == 39 decimal ou 18
assign endofcount_enable = (counterEventbuffer == dataSize_in_words);

//input Eventbuffer
//-----------------
wire	[7:0]		subaddress_evtbuffer,Nbwords_LSB,Nbwords_MSB;
wire  [31:0] HeaderDatas;
wire	[31:0]	TrailerDatas;



assign Nbwords_LSB = (DAQ_Debug_Mode)? `DEBUG_DATA_SIZE_LSB : `DAQ_DATA_SIZE_LSB;
assign Nbwords_MSB = (DAQ_Debug_Mode)? `DEBUG_DATA_SIZE_MSB : `DAQ_DATA_SIZE_MSB;

assign subaddress_evtbuffer = 8'h01;



//  HEADER AND TRAILER DATA TO PUT
assign HeaderDatas = 32'hAABBCCDD;
assign TrailerDatas = 32'hCCDDEEFF;


//Header :

// Jihane : 21/11/2022
// Gestion du almost full de la fifo EventBuffer.
// changer la mémorisation des données

//------
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h00) ? {72'h00,HeaderDatas[31:0], // not needed in my parsing, only needed by Jihane for her SW protocol subaddress_evtbuffer[7:0], Nbwords_MSB[7:0], Nbwords_LSB[7:0]}	:8'hzz;

//Stamps
//------
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h01) ? {29'h00,DAVE_Decision_OK,APE_Decision_OK,CARACO_Decision_OK,PER_trigger_ID_APE[31:0],dff_clock1600periodcounter[31:0],dff_Trigger_ID[31:0]} :8'hzz;

//Whole matrice pure Tracker


// Rajouter ces informations

/* wire [6:0] TSZB_S0Z0_,TSZB_S0Z1_,TSZB_S0Z2_,TSZB_S0Z3_,TSZB_S0Z4_,TSZB_S0Z5_,
			  TSZB_S0Z6_,TSZB_S0Z7_,TSZB_S0Z8_,TSZB_S0Z9_,TSZB_S1Z0_,TSZB_S1Z1_,
			  TSZB_S1Z2_,TSZB_S1Z3_,TSZB_S1Z4_,TSZB_S1Z5_,TSZB_S1Z6_,TSZB_S1Z7_,
			  TSZB_S1Z8_,TSZB_S1Z9_; */

//-------------                                                                                                                                                                                                                            Rows number, 2 rows == 1 FEB
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h02) ? {1'b0, TSZB_S0Z0_[6:0],4'b0  ,dff_TPsfromCB0FromStreaming_[107:72], 4'b0,dff_TPsfromCB0FromStreaming_[71:36], 4'b0,dff_TPsfromCB0FromStreaming_[35:0]}:128'hzz;     ///5-4-3-2-1-0]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h03) ? {1'b0, TSZB_S0Z1_[6:0],4'b0  ,dff_TPsfromCB0FromStreaming_[215:180],4'b0,dff_TPsfromCB0FromStreaming_[179:144],4'b0,dff_TPsfromCB0FromStreaming_[143:108]}:128'hzz; //[11-10-9-8-7-6]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h04) ? {1'b0, TSZB_S0Z2_[6:0],4'b0  ,dff_TPsfromCB0FromStreaming_[323:288],4'b0,dff_TPsfromCB0FromStreaming_[287:252],4'b0,dff_TPsfromCB0FromStreaming_[251:216]}:128'hzz; //[17-16-15-14-13-12]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h05) ? {1'b0, TSZB_S0Z3_[6:0],4'b0  ,dff_TPsfromCB0FromStreaming_[431:396],4'b0,dff_TPsfromCB0FromStreaming_[395:360],4'b0,dff_TPsfromCB0FromStreaming_[359:324]}:128'hzz; //[23-22-21-20-19-18]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h06) ? {1'b0, TSZB_S0Z4_[6:0],4'b0  ,dff_TPsfromCB0FromStreaming_[539:504],4'b0,dff_TPsfromCB0FromStreaming_[503:468],4'b0,dff_TPsfromCB0FromStreaming_[467:432]}:128'hzz; //[29-28-27-26-25-24]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h07) ? {1'b0, TSZB_S0Z5_[6:0],4'b0  ,dff_TPsfromCB0FromStreaming_[647:612],4'b0,dff_TPsfromCB0FromStreaming_[611:576],4'b0,dff_TPsfromCB0FromStreaming_[575:540]}:128'hzz; //[35-34-33-32-31-30]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h08) ? {1'b0, TSZB_S0Z6_[6:0],84'h00,dff_TPsfromCB0FromStreaming_[683:648]}:128'hzz;                                                                                       //[37-36]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h09) ? {1'b0, TSZB_S0Z7_[6:0],4'b0  ,dff_TPsfromCB1FromStreaming_[107:72], 4'b0,dff_TPsfromCB1FromStreaming_[71:36], 4'b0,dff_TPsfromCB1FromStreaming_[35:0]}:128'hzz;     //[43-42-41-40-39-38]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h0A) ? {1'b0, TSZB_S0Z8_[6:0],4'b0  ,dff_TPsfromCB1FromStreaming_[215:180],4'b0,dff_TPsfromCB1FromStreaming_[179:144],4'b0,dff_TPsfromCB1FromStreaming_[143:108]}:128'hzz; //[49-48-47-46-45-44]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h0B) ? {1'b0, TSZB_S0Z9_[6:0],4'b0  ,dff_TPsfromCB1FromStreaming_[323:288],4'b0,dff_TPsfromCB1FromStreaming_[287:252],4'b0,dff_TPsfromCB1FromStreaming_[251:216]}:128'hzz; //[55-54-53-52-51-50]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h0C) ? {1'b0, TSZB_S1Z0_[6:0],4'b0  ,dff_TPsfromCB1FromStreaming_[431:396],4'b0,dff_TPsfromCB1FromStreaming_[395:360],4'b0,dff_TPsfromCB1FromStreaming_[359:324]}:128'hzz; //[60-59-58-57-XX-56]! Warning row 56
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h0D) ? {1'b0, TSZB_S1Z1_[6:0],4'b0  ,dff_TPsfromCB1FromStreaming_[539:504],4'b0,dff_TPsfromCB1FromStreaming_[503:468],4'b0,dff_TPsfromCB1FromStreaming_[467:432]}:128'hzz; //[66-65-64-63-62-61]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h0E) ? {1'b0, TSZB_S1Z2_[6:0],4'b0  ,dff_TPsfromCB1FromStreaming_[647:612],4'b0,dff_TPsfromCB1FromStreaming_[611:576],4'b0,dff_TPsfromCB1FromStreaming_[575:540]}:128'hzz; //[72-71-70-69-68-67]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h0F) ? {1'b0, TSZB_S1Z3_[6:0],84'h00,dff_TPsfromCB1FromStreaming_[683:648]}:128'hzz;                                                                                       //[74-73]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h10) ? {1'b0, TSZB_S1Z4_[6:0],4'b0  ,dff_TPsfromCB2FromStreaming_[107:72], 4'b0,dff_TPsfromCB2FromStreaming_[71:36], 4'b0,dff_TPsfromCB2FromStreaming_[35:0]}:128'hzz;     //[80-79-78-77-76-75]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h11) ? {1'b0, TSZB_S1Z5_[6:0],4'b0  ,dff_TPsfromCB2FromStreaming_[215:180],4'b0,dff_TPsfromCB2FromStreaming_[179:144],4'b0,dff_TPsfromCB2FromStreaming_[143:108]}:128'hzz; //[86-85-84-83-82-81]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h12) ? {1'b0, TSZB_S1Z6_[6:0],4'b0  ,dff_TPsfromCB2FromStreaming_[323:288],4'b0,dff_TPsfromCB2FromStreaming_[287:252],4'b0,dff_TPsfromCB2FromStreaming_[251:216]}:128'hzz; //[92-91-90-89-88-87]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h13) ? {1'b0, TSZB_S1Z7_[6:0],4'b0  ,dff_TPsfromCB2FromStreaming_[431:396],4'b0,dff_TPsfromCB2FromStreaming_[395:360],4'b0,dff_TPsfromCB2FromStreaming_[359:324]}:128'hzz; //[98-97-96-95-94-93]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h14) ? {1'b0, TSZB_S1Z8_[6:0],4'b0  ,dff_TPsfromCB2FromStreaming_[539:504],4'b0,dff_TPsfromCB2FromStreaming_[503:468],4'b0,dff_TPsfromCB2FromStreaming_[467:432]}:128'hzz; //[104-103-102-101-100-99]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h15) ? {1'b0, TSZB_S1Z9_[6:0],4'b0  ,dff_TPsfromCB2FromStreaming_[647:612],4'b0,dff_TPsfromCB2FromStreaming_[611:576],4'b0,dff_TPsfromCB2FromStreaming_[575:540]}:128'hzz; //[110-109-108-107-106-105]
assign in_wren_eventbuffer[127:0] = (counterEventbuffer == 8'h16) ? {88'h00,4'h0,dff_TPsfromCB2FromStreaming_[683:648]}:128'hzz;                                                                                                        //[112-111]



// START for DEBUG

//Tracker
//-------
//20 zones's projections
//----------------------
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h17) ?  {8'h00,dff_PR_S0Z0,dff_PL_S0Z0,dff_VSZB_HSZB_TSZB_S0Z0}:128'hzz;	//32,64,24
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h18) ?  {8'h00,dff_PR_S0Z1,dff_PL_S0Z1,dff_VSZB_HSZB_TSZB_S0Z1}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h19) ?  {8'h00,dff_PR_S0Z2,dff_PL_S0Z2,dff_VSZB_HSZB_TSZB_S0Z2}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h20) ?  {8'h00,dff_PR_S0Z3,dff_PL_S0Z3,dff_VSZB_HSZB_TSZB_S0Z3}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h21) ?  {8'h00,dff_PR_S0Z4,dff_PL_S0Z4,dff_VSZB_HSZB_TSZB_S0Z4}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h22) ?  {8'h00,dff_PR_S0Z5,dff_PL_S0Z5,dff_VSZB_HSZB_TSZB_S0Z5}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h23) ?  {8'h00,dff_PR_S0Z6,dff_PL_S0Z6,dff_VSZB_HSZB_TSZB_S0Z6}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h24) ?  {8'h00,dff_PR_S0Z7,dff_PL_S0Z7,dff_VSZB_HSZB_TSZB_S0Z7}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h25) ?  {8'h00,dff_PR_S0Z8,dff_PL_S0Z8,dff_VSZB_HSZB_TSZB_S0Z8}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h26) ?  {8'h00,dff_PR_S0Z9,dff_PL_S0Z9,dff_VSZB_HSZB_TSZB_S0Z9}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h27) ?  {8'h00,dff_PR_S1Z0,dff_PL_S1Z0,dff_VSZB_HSZB_TSZB_S1Z0}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h28) ?  {8'h00,dff_PR_S1Z1,dff_PL_S1Z1,dff_VSZB_HSZB_TSZB_S1Z1}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h29) ?  {8'h00,dff_PR_S1Z2,dff_PL_S1Z2,dff_VSZB_HSZB_TSZB_S1Z2}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h30) ? {8'h00,dff_PR_S1Z3,dff_PL_S1Z3,dff_VSZB_HSZB_TSZB_S1Z3}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h31) ? {8'h00,dff_PR_S1Z4,dff_PL_S1Z4,dff_VSZB_HSZB_TSZB_S1Z4}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h32) ? {8'h00,dff_PR_S1Z5,dff_PL_S1Z5,dff_VSZB_HSZB_TSZB_S1Z5}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h33) ? {8'h00,dff_PR_S1Z6,dff_PL_S1Z6,dff_VSZB_HSZB_TSZB_S1Z6}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h34) ? {8'h00,dff_PR_S1Z7,dff_PL_S1Z7,dff_VSZB_HSZB_TSZB_S1Z7}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h35) ? {8'h00,dff_PR_S1Z8,dff_PL_S1Z8,dff_VSZB_HSZB_TSZB_S1Z8}:128'hzz;
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h36) ? {8'h00,dff_PR_S1Z9,dff_PL_S1Z9,dff_VSZB_HSZB_TSZB_S1Z9}:128'hzz;

// END OF DEBUG

// last word Tracker
//------------------
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h37) ?{64'h00,dff_Zoning_Word[63:0]}: 128'hZZ;

//---------------------------
//Calorimeter	& TrailerDatas
//---------------------------
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b1 && counterEventbuffer == 8'h38) ?{56'h00, TrailerDatas[31:0],dff_calorimeter[39:0]}: 128'hZZ;


// cas non debug // same data but shifted in the table
// last word Tracker
//------------------
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b0 && counterEventbuffer == 8'h17) ?{64'h00,dff_Zoning_Word[63:0]}: 128'hZZ;

//---------------------------
//Calorimeter	& TrailerDatas
//---------------------------
assign in_wren_eventbuffer[127:0] = (DAQ_Debug_Mode == 1'b0 && counterEventbuffer == 8'h18) ?{TrailerDatas[31:0], 56'h00,dff_calorimeter[39:0]}: 128'hZZ;


endmodule


//-----------------------------------------------------------------------//
//-                       FIN                                           -//
2//-----------------------------------------------------------------------//
