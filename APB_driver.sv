class APB_driver extends uvm_driver #(APB_sequence_item);
  `uvm_component_utils(APB_driver)

  virtual APB_Master_intf vif;
  APB_sequence_item item;

  function new(string name = "APB_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("APB_driver", "inside constructor !", UVM_HIGH)
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("APB_driver", "build_phase !", UVM_HIGH)
    if (!(uvm_config_db #(virtual APB_Master_intf)::get(this, "*", "vif", vif)))
      `uvm_error("APB_driver", "failed to get vif from DB!!")
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("APB_driver", "connect_phase !", UVM_HIGH)
  endfunction : connect_phase

  task reset_phase(uvm_phase phase);
    vif.transfer        = 0;
    vif.READ_WRITE      = 0;
    vif.apb_write_paddr = 0;
    vif.apb_write_data  = 0;
    vif.apb_read_paddr  = 0;
  endtask

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("APB_driver", "run_phase !", UVM_HIGH)
    forever begin
		wait (vif.PRESETn == 1);
		seq_item_port.get_next_item(item);
		drive(item);
		//item.print();
		seq_item_port.item_done();
		`uvm_info("DRIVER", "DONE driving", UVM_LOW)
    end
  endtask : run_phase

  task drive(APB_sequence_item item);
    if (item.valid_drive == 1)
      valid_driver(item);
    else
      invalid_driver(item);
  endtask : drive

  task valid_driver(APB_sequence_item item);
    @(posedge vif.PCLK);
	`uvm_info("DRIVER got: ", item.convert2string(), UVM_LOW)
    vif.cb1.transfer        <= item.transfer;
    vif.cb1.READ_WRITE      <= item.READ_WRITE;
    vif.cb1.apb_write_paddr <= item.apb_write_paddr;
    vif.cb1.apb_write_data  <= item.apb_write_data;
    vif.cb1.apb_read_paddr  <= item.apb_read_paddr;

    if (item.transfer) begin
      //wait (vif.cb1.PPREADY_out==1);
		while(vif.cb1.PPREADY_out!=1)
			@(posedge vif.PCLK);
		
		if (item.is_B2B) begin
		// get next tx instantly with no delays
		`uvm_info("DRV"," wait for PREADY done ",UVM_LOW)
	
		end else begin
		// wait till next clk before next tx
		vif.cb1.transfer <= 0;
		`uvm_info("DRV"," w777777777777777777777777777 ",UVM_LOW)
		end
    end else begin
      // do nothing and get next tx
	  `uvm_info("DRV","No wait for PREADY",UVM_LOW)
    end
  endtask : valid_driver

  task invalid_driver(APB_sequence_item item);
    @(posedge vif.PCLK);
    vif.cb1.transfer        <= item.transfer;
    vif.cb1.READ_WRITE      <= item.READ_WRITE;
    vif.cb1.apb_write_paddr <= item.apb_write_paddr;
    vif.cb1.apb_write_data  <= item.apb_write_data;
    vif.cb1.apb_read_paddr  <= item.apb_read_paddr;
  endtask : invalid_driver
endclass : APB_driver
