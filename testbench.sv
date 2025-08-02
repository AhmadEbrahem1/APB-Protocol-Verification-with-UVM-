
//this project is nothing but binding interface and asssertions check
//searc reset handlig
//set interface asssertions



//vseq,
//mon,cov,scb
//more scenarios
`timescale 1ns/1ns
module testbench;

	
    import apb_pkg ::*;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	
	// Clock and Reset
	bit PCLK;

	// Generate 5ns clock (period = 10ns, 100MHz)
	always #5 PCLK = ~PCLK;
	
	
	// Instantiate interface
	APB_Master_intf intf (PCLK);  // Connects PCLK
	
	// DUT Instantiation
	APB_Protocol dut (
		.PCLK               (PCLK),
		.PRESETn            (intf.PRESETn),
		.transfer           (intf.transfer),
		.READ_WRITE         (intf.READ_WRITE),
		.apb_write_paddr    (intf.apb_write_paddr),
		.apb_write_data     (intf.apb_write_data),
		.apb_read_paddr     (intf.apb_read_paddr),
		.PSLVERR            (intf.PSLVERR),
		.PPREADY_out        (intf.PPREADY_out),
		.apb_read_data_out  (intf.apb_read_data_out)
	);
	
	APB_assertions APB_assertions_inst_DUT1(
	.PCLK(PCLK),
	.PRESETn(dut.PRESETn),
	.PSEL(dut.dut1.PSEL),
	.PENABLE(dut.dut1.PENABLE),
	.PWRITE(dut.dut1.PWRITE),
	.transfer(dut.transfer),
	.PADDR(dut.dut1.PADDR),
	.PWDATA(dut.dut1.PWDATA),
	.PRDATA(dut.dut1.PRDATA1),
	.PREADY(dut.dut1.PREADY),
	.PSLVERR(dut.PSLVERR)
	
	);
	
	APB_assertions APB_assertions_inst_DUT2(
	.PCLK(PCLK),
	.PRESETn(dut.PRESETn),
	.PSEL(dut.dut2.PSEL),
	.PENABLE(dut.dut2.PENABLE),
	.PWRITE(dut.dut2.PWRITE),
	.transfer(dut.transfer),
	.PADDR(dut.dut2.PADDR),
	.PWDATA(dut.dut2.PWDATA),
	.PRDATA(dut.dut2.PRDATA1),
	.PREADY(dut.dut2.PREADY),
	.PSLVERR(dut.PSLVERR)
	
	);
	
	initial
	begin
		$dumpfile("wave.vcd");   // creates VCD file
		$dumpvars();       // dumps all variables under module `top`
	end

	// Set Interface Config
	initial begin
		uvm_config_db#(virtual APB_Master_intf)::set(null, "*", "vif", intf);
		// Apply Reset
		intf.PRESETn = 0;
		#20ns;
		intf.PRESETn = 1;
	end
	initial begin
		run_test("APB_basic_test");
	end

	// Run UVM Test
	initial begin
		#20000000;
		`uvm_info("testbenc","END OF CLOCK !!!! ",UVM_LOW);
		$stop();
	end




endmodule