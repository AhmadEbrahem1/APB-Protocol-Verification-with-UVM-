class APB_basic_sequence extends uvm_sequence #(APB_sequence_item);
  `uvm_object_utils(APB_basic_sequence)
  APB_sequence_item item;
  slave_select_e slav_sel;
  logic [7:0] address;
  int loop_count;

  function new(string name="APB_basic_sequence");
    super.new(name);
    `uvm_info("APB_basic_sequence","inside constructor",UVM_LOW)
    loop_count=5;
  endfunction : new

  virtual task body();
    `uvm_info("APB_basic_sequence","inside the body_task",UVM_LOW)
    for (int i = 0; i < loop_count; i++) begin
      item = APB_sequence_item::type_id::create("item");
      start_item(item);
      assert(item.randomize() with { valid_drive == 1; is_B2B == 0; });
      finish_item(item);
      `uvm_info("APB_basic_sequence", $sformatf("Iteration %0d completed for basic sequence", i+1), UVM_LOW)
    end
  endtask : body
endclass : APB_basic_sequence

class APB_Write_seq extends APB_basic_sequence;
  `uvm_object_utils(APB_Write_seq)

  function new(string name="APB_Write_seq");
    super.new(name);
    `uvm_info("APB_Write_seq","inside constructor",UVM_LOW)
    loop_count=5;
  endfunction : new

  virtual task body();
    `uvm_info("APB_Write_seq","inside the body_task",UVM_LOW)
    for (int i = 0; i < loop_count; i++) begin
      item = APB_sequence_item::type_id::create("item");
      start_item(item);
      assert(item.randomize() with {
        transfer == 1; READ_WRITE == 0; is_B2B == 0; valid_drive == 1;
      });
      finish_item(item);
      `uvm_info("APB_Write_seq", $sformatf("Iteration %0d completed for write sequence", i+1), UVM_LOW)
    end
  endtask : body
endclass : APB_Write_seq

class APB_W_B2B_seq extends APB_basic_sequence;
  `uvm_object_utils(APB_W_B2B_seq)

  function new(string name="APB_W_B2B_seq");
    super.new(name);
    `uvm_info("APB_W_B2B_seq","inside constructor",UVM_LOW)
    loop_count=5;
  endfunction : new

  virtual task body();
    `uvm_info("APB_W_B2B_seq","inside the body_task",UVM_LOW)
    for (int i = 0; i < loop_count-1; i++) begin
      item = APB_sequence_item::type_id::create("item");
      start_item(item);
      assert(item.randomize() with {
        transfer == 1; READ_WRITE == 0; is_B2B == 1; valid_drive == 1;
      });
      finish_item(item);
      `uvm_info("APB_W_B2B_seq", $sformatf("Iteration %0d completed for write B2B sequence", i+1), UVM_LOW)
    end

    item = APB_sequence_item::type_id::create("item");
    start_item(item);
    assert(item.randomize() with { transfer == 1; READ_WRITE == 0; is_B2B == 0; });
    finish_item(item);
    `uvm_info("APB_W_B2B_seq", "Last transaction completed for write B2B sequence", UVM_LOW)
  endtask : body
endclass : APB_W_B2B_seq

class APB_Read_seq extends APB_basic_sequence;
  `uvm_object_utils(APB_Read_seq)

  function new(string name="APB_Read_seq");
    super.new(name);
    `uvm_info("APB_Read_seq","inside constructor",UVM_LOW)
    loop_count=5;
  endfunction : new

  virtual task body();
    `uvm_info("APB_Read_seq","inside the body_task",UVM_LOW)
    for (int i = 0; i < loop_count; i++) begin
      item = APB_sequence_item::type_id::create("item");
      start_item(item);
      assert(item.randomize() with {
        transfer == 1; READ_WRITE == 1; is_B2B == 0; valid_drive == 1;
      });
      finish_item(item);
      `uvm_info("APB_Read_seq", $sformatf("Iteration %0d completed for read sequence", i+1), UVM_LOW)
    end
  endtask : body
endclass : APB_Read_seq

class APB_R_B2B_seq extends APB_basic_sequence;
  `uvm_object_utils(APB_R_B2B_seq)

  function new(string name="APB_R_B2B_seq");
    super.new(name);
    `uvm_info("APB_R_B2B_seq","inside constructor",UVM_LOW)
    loop_count=5;
  endfunction : new

  virtual task body();
    `uvm_info("APB_R_B2B_seq","inside the body_task",UVM_LOW)
    for (int i = 0; i < loop_count-1; i++) begin
      item = APB_sequence_item::type_id::create("item");
      start_item(item);
      assert(item.randomize() with {
        transfer == 1; READ_WRITE == 1; is_B2B == 1; valid_drive == 1;
      });
      finish_item(item);
      `uvm_info("APB_R_B2B_seq", $sformatf("Iteration %0d completed for read B2B sequence", i+1), UVM_LOW)
    end

    item = APB_sequence_item::type_id::create("item");
    start_item(item);
    assert(item.randomize() with { transfer == 1; READ_WRITE == 1; is_B2B == 0; });
    finish_item(item);
    `uvm_info("APB_R_B2B_seq", "Last transaction completed for read B2B sequence", UVM_LOW)
  endtask : body
endclass : APB_R_B2B_seq

class Write_read_seq extends APB_basic_sequence;
  `uvm_object_utils(Write_read_seq)

  function new(string name="Write_read_seq");
    super.new(name);
    `uvm_info("Write_read_seq","inside constructor",UVM_LOW)
    loop_count = 5;
  endfunction : new

  virtual task body();
    `uvm_info("Write_read_seq","inside the body_task",UVM_LOW)
    for (int i = 0; i < loop_count; i++) begin
		item = APB_sequence_item::type_id::create("item");
		start_item(item);
		assert(item.randomize() with {
		transfer == 1; READ_WRITE == 0; is_B2B == 1; valid_drive == 1;
		});
		finish_item(item);
	
		slav_sel = item.slave_select;
		address = item.apb_write_paddr[7:0];
		item = APB_sequence_item::type_id::create("item");
		start_item(item);
		assert(item.randomize() with {
		transfer == 1; READ_WRITE == 1; is_B2B == 0;
		slave_select == slav_sel;
		apb_read_paddr[7:0] == address;
		});
		finish_item(item);
		`uvm_info("Write_read_seq", $sformatf("Iteration %0d completed for write-read sequence", i+1), UVM_LOW)
    end
  endtask : body
endclass : Write_read_seq

//error_sequence
//bad_drive_seq




/*git hub
cv
eman siemens 
اافشخ بعت للكل
vcs -seq -config-rst ag






*/