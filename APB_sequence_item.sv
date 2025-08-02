class APB_sequence_item extends uvm_sequence_item;

	rand logic transfer, READ_WRITE;
	rand logic [8:0] apb_write_paddr, apb_read_paddr;
	rand logic [7:0] apb_write_data;
	logic PSLVERR, PPREADY_out;
	logic [7:0] apb_read_data_out;
	
	rand slave_select_e slave_select;
	rand bit is_B2B, valid_drive;

   
  function new(string name = "alu_sequence_item");
    super.new(name);
  endfunction : new

  constraint addr_select_c {
    if (slave_select == slave2) {
      apb_write_paddr[8] == 1;
      apb_read_paddr[8] == 1;
    } else {
      apb_write_paddr[8] == 1;
      apb_read_paddr[8] == 1;
    }
  }

  constraint MEM_SIZE {
    apb_write_paddr[7:0] inside {[0:63]};
    apb_read_paddr[7:0] inside {[0:63]};
	
	apb_write_paddr[7:0] dist { 8'h00 := 20, 'd63 := 20, [1:62] := 60 };
	apb_read_paddr[7:0]  dist { 8'h00 := 20, 'd63 := 20, [1:62] := 60 };
  }
	
// Make write data 0x00 or 0xFF in 40% of cases
  constraint WRITE_DATA_DIST {
    apb_write_data dist { 8'h00 := 20, 8'hFF := 20, [1:254] := 60 };
  }
  constraint c_is_b2b     { is_B2B     dist { 1 := 70, 0 := 30 }; }
  constraint c_transfer   { transfer   dist { 1 := 90, 0 := 10 }; }
  constraint c_read_write { READ_WRITE dist { 1 := 50, 0 := 50 }; }
  constraint c_slave_select { slave_select dist { slave1 := 50, slave1 := 50 }; }




	function string convert2string();
		return $sformatf("transfer=%0b, READ_WRITE=%0b, apb_write_paddr=0x%0h, apb_read_paddr=0x%0h, apb_write_data=0x%0h, slave_select=%s, is_B2B=%0b, valid_drive=%0b",
                   transfer, READ_WRITE, apb_write_paddr[7:0], apb_read_paddr[7:0], apb_write_data, slave_select.name(), is_B2B, valid_drive);
	endfunction

  `uvm_object_utils_begin(APB_sequence_item)
    `uvm_field_int(transfer,          UVM_ALL_ON)
    `uvm_field_int(READ_WRITE,        UVM_ALL_ON)
    `uvm_field_int(apb_write_paddr,   UVM_ALL_ON)
    `uvm_field_int(apb_write_data,    UVM_ALL_ON)
    `uvm_field_int(apb_read_paddr,    UVM_ALL_ON)
    `uvm_field_int(PSLVERR,           UVM_ALL_ON)
    `uvm_field_int(PPREADY_out,       UVM_ALL_ON)
    `uvm_field_int(apb_read_data_out, UVM_ALL_ON)
    `uvm_field_enum(slave_select_e, slave_select, UVM_ALL_ON)
    `uvm_field_int(is_B2B,            UVM_ALL_ON)
    `uvm_field_int(valid_drive,       UVM_ALL_ON)
  `uvm_object_utils_end

endclass : APB_sequence_item
