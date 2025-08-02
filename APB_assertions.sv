`timescale 1ns/1ns

interface APB_assertions (
	input bit 	PCLK, PRESETn,

    input logic PSEL, PENABLE, PWRITE, transfer,
    input logic [7:0] PADDR, PWDATA,
    input logic [7:0] PRDATA,
	input logic PREADY, PSLVERR
);

	sequence end_transfer;
		(PENABLE==0 && PREADY==0 && PSLVERR==0) ;
	endsequence

	sequence setup_phase;
		($rose(PSEL) && PENABLE==0);
	endsequence

	sequence acces_phase;
		(PSEL==1 && PENABLE==1 && PREADY==0);
	endsequence

	property valid_signals_at_select_p;
		@(posedge PCLK) disable iff (!PRESETn)
		$rose(PSEL) |-> ( !$isunknown(PADDR) && !$isunknown(PWRITE) && !$isunknown(PWDATA) ) throughout (PSEL==1);		
	endproperty

	valid_signals_at_select_a: assert property (valid_signals_at_select_p)
		else $error("invalid signal appears !!");

	valid_signals_at_select_cov: cover property (valid_signals_at_select_p);

	property stable_before_enable_assert_p;
	@(posedge PCLK) disable iff (!PRESETn )
		setup_phase |=> ( $stable(PADDR) &&  
		                  $stable(PWDATA) && 
		                  $stable(PWRITE) && 
		                  $stable(PSEL)  ) 
		              until (PREADY==1);	
		
	endproperty
	
	stable_before_enable_assert_a: assert property (stable_before_enable_assert_p)
		else $error("stable_before_enable_assert_p failed !!");

	stable_before_enable_assert_cov: cover property (stable_before_enable_assert_p);
	 
	property stable_till_transfer_complete_p;
		@(posedge PCLK) disable iff (!PRESETn || !PSEL)
		acces_phase |=> ( $stable(PADDR) &&  
		                  $stable(PWDATA) && 
		                  $stable(PWRITE) && 
		                  $stable(PSEL) && 
		                  $stable(PENABLE) ) 
		              until (PREADY==1) ;		
	endproperty

	stable_till_transfer_complete_a: assert property (stable_till_transfer_complete_p)
		else $error("invalid signal appears !!");

	stable_till_transfer_complete_cov: cover property (stable_till_transfer_complete_p);

	

	property APB_sequence_flow_p;
		@(posedge PCLK) disable iff (!PRESETn || !PSEL)
		((PSEL) && PENABLE==0) |=> acces_phase ##1 $rose(PREADY)[->1] ##1 end_transfer;
	endproperty

	APB_sequence_flow_a: assert property (APB_sequence_flow_p)
		else $error("APB sequence flow violation");

	APB_sequence_flow_cov: cover property (APB_sequence_flow_p);
	
	property No_B2B_transfer_p;
		@(posedge PCLK) disable iff (!PRESETn)
		($fell(PENABLE) && !transfer) |=> !(PSEL) and end_transfer;
	endproperty

	No_B2B_transfer_a: assert property (No_B2B_transfer_p)
		else $error("No B2B transfer failed");

	No_B2B_transfer_cov: cover property (No_B2B_transfer_p);
	
	
	
	
	property error_check;
		@(posedge PCLK) disable iff (!PRESETn)
		$rose(PSLVERR) && PENABLE && PREADY &&  PSEL |=> end_transfer;
	endproperty

	error_check_a: assert property (error_check)
		else $error("PSLVERR error sequence failed");

	error_check_cov: cover property (error_check);


	property low_if_no_PENABLE;
		@(posedge PCLK) disable iff (!PRESETn)
		!PENABLE |-> end_transfer;
	endproperty

	low_if_no_PENABLE_a: assert property (low_if_no_PENABLE)
		else $error("end_transfer not low when PENABLE is 0");

	low_if_no_PENABLE_cov: cover property (low_if_no_PENABLE);

endinterface


//complete assert
//constraints
//complete test cclass


//rst aware and config class