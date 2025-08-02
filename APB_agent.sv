
class APB_agent extends uvm_agent;

	`uvm_component_utils(APB_agent)
	APB_driver m_driver;
	//APB_monitor m_monitor;
	APB_sequencer m_seqr;
	//APB_subscriber m_subsciber;

   function new(string name ="APB_agent", uvm_component parent);
   
		super.new(name,parent);
		`uvm_info("APB_agent","inside constructor !",UVM_HIGH)
   endfunction:new



   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("APB_agent","build_phase !",UVM_HIGH)
    m_driver	= 	APB_driver 		::type_id::create ("m_driver",this);
    //m_monitor	= 	APB_monitor 	::type_id::create ("m_monitor",this);
    m_seqr		= 	APB_sequencer 	::type_id::create ("m_seqr",this);
	//m_subsciber =	APB_subscriber 	::type_id::create ("m_subsciber",this);
    endfunction:build_phase
  
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("APB_agent","connect_phase !",UVM_HIGH)
      m_driver.seq_item_port.connect(m_seqr.seq_item_export);
	  //m_monitor.monitor_analysis_port.connect(m_subsciber.analysis_imp_A);	
	endfunction:connect_phase
	
	task  run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("APB_agent","run_phase !",UVM_HIGH)
		//logic
	endtask:run_phase
	

endclass : APB_agent
