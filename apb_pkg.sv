package apb_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"


	typedef enum {slave1,slave2} slave_select_e;
	`include "APB_sequence_item.sv"
	`include "APB_sequencer.sv"

	`include "APB_sequence.sv"
	`include "APB_driver.sv"
	//`include "apb_monitor.sv"
	`include "APB_agent.sv"
	//`include "apb_scoreboard.sv"
	`include "APB_env.sv"
	`include "APB_test.sv"
endpackage:apb_pkg
