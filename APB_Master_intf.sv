`timescale 1ns/1ns

interface APB_Master_intf(input bit PCLK);

	
	
	logic PRESETn,transfer,READ_WRITE;
	logic [8:0] apb_write_paddr;
	logic [7:0]apb_write_data;
	logic [8:0] apb_read_paddr;
	
	
	
	logic  PSLVERR,PPREADY_out;
	logic  [7:0] apb_read_data_out;
	
	
	
	
	
	
	
	
	
	clocking cb1 @(posedge PCLK);
		default input #0.5ns output #0.5ns;

		input  PSLVERR, apb_read_data_out,PPREADY_out;
		output transfer, READ_WRITE, apb_write_paddr, apb_write_data, apb_read_paddr;
	endclocking



endinterface:APB_Master_intf
