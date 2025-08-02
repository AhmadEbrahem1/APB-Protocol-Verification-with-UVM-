
class APB_sequencer extends uvm_sequencer  #(APB_sequence_item) ;

  `uvm_component_utils(APB_sequencer)



  function new(string name ="APB_sequencer", uvm_component parent) ;
   
		super.new(name,parent);
		`uvm_info("APB_sequencer","inside constructor !",UVM_HIGH)
   endfunction:new



   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("APB_sequencer","build_phase !",UVM_HIGH)

	endfunction:build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("APB_sequencer","connect_phase !",UVM_HIGH)

	endfunction:connect_phase

endclass : APB_sequencer
