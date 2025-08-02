
class APB_env extends uvm_env;

  `uvm_component_utils(APB_env)
APB_agent apb_agent;
//APB_scoreboard scb;
  

   function new(string name ="APB_env", uvm_component parent);
   
		super.new(name,parent);
		`uvm_info("APB_env","inside constructor !",UVM_HIGH)
   endfunction:new



   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("APB_env","build_phase !",UVM_HIGH)
     apb_agent	= APB_agent ::type_id::create ("apb_agent",this);
     //scb = APB_scoreboard::type_id::create ("scb",this);
     
     
     
	endfunction:build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
      
		//apb_agent.m_monitor.monitor_analysis_port.connect(scb.scb_analysis_imp);
		`uvm_info("APB_env","connect_phase !",UVM_HIGH)

	endfunction:connect_phase
	
	task  run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("APB_env","run_phase !",UVM_HIGH)
		//logic
	endtask:run_phase
	

endclass : APB_env
