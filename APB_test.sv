
class APB_basic_test extends uvm_test;

  `uvm_component_utils(APB_basic_test)

	APB_env 				env;
	APB_basic_sequence 		rand_seq;
	APB_Write_seq 			Write_seq;
	APB_W_B2B_seq 			Write_seq_B2B;

	APB_Read_seq			Read_seq;
	
	APB_R_B2B_seq			Read_seq_B2B;
	Write_read_seq			W_R_seq;
  
  
  
  
  
  
  
   function new(string name ="APB_basic_test", uvm_component parent);
		super.new(name,parent);
		`uvm_info("APB_basic_test","inside constructor !",UVM_HIGH)
   endfunction:new



   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("APB_basic_test","build_phase !",UVM_HIGH)
		
		
		env=APB_env::type_id::create ("env",this);// now test contains  env
		Write_seq = APB_Write_seq::type_id::create ("Write_seq");
		rand_seq = APB_basic_sequence::type_id::create ("rand_seq");
		Write_seq_B2B = APB_W_B2B_seq::type_id::create ("Write_seq_B2B");
		Read_seq = APB_Read_seq::type_id::create ("Read_seq");
		Read_seq_B2B = APB_R_B2B_seq::type_id::create ("Read_seq_B2B");
		W_R_seq = Write_read_seq::type_id::create ("W_R_seq");
		
	endfunction:build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("APB_basic_test","connect_phase !",UVM_HIGH)
	endfunction:connect_phase
	
  //-----------run_phase------------
	task  run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("APB_basic_test","run_phase !",UVM_HIGH)
      
		phase.raise_objection(this);
		//start sequences
		Write_seq.start(env.apb_agent.m_seqr);
		rand_seq.start(env.apb_agent.m_seqr);
		Write_seq_B2B.start(env.apb_agent.m_seqr);
		Read_seq.start(env.apb_agent.m_seqr);
		Read_seq_B2B.start(env.apb_agent.m_seqr);
		W_R_seq.start(env.apb_agent.m_seqr);
		phase.drop_objection(this);
    
    endtask:run_phase
	

endclass : APB_basic_test
