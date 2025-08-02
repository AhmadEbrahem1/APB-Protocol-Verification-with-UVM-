
class alu_monitor extends uvm_monitor;

  `uvm_component_utils(alu_monitor)
	virtual alu_if vif;	
 alu_sequence_item  item;

  
  uvm_analysis_port #(alu_sequence_item ) monitor_analysis_port;
  
  
   function new(string name ="alu_monitor", uvm_component parent);
   
     super.new(name,parent);  
     monitor_analysis_port = new ("monitor_analysis_port",this);
		`uvm_info("alu_monitor","inside constructor !",UVM_HIGH)
   endfunction:new



   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("alu_monitor","build_phase !",UVM_HIGH)
		
     if(! (uvm_config_db #(virtual alu_if ) :: get (this,"*","vif",vif) ))
		begin
			`uvm_error("alu_monitor","failed to get vif drom DB!!") // takes 2 arguments
		end
		
	endfunction:build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("alu_monitor","connect_phase !",UVM_HIGH)

	endfunction:connect_phase
	
	task  run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("alu_monitor","run_phase !",UVM_HIGH)
      
      
      forever  
        begin
		//logic
       	item=alu_sequence_item::type_id::create ("item");
    	 wait (!vif.reset );
          @(posedge vif.clock );
         item.A= vif.A;
          item.B= vif.B;
          item.ALU_SEL= vif.ALU_SEL;
          //sample oputs   
          
           @(posedge vif.clock );
          item.ALU_OUT= vif.ALU_OUT;
          item.Carry_out= vif.Carry_out;
          //send to scb
          
          monitor_analysis_port.write(item);
          
          
        end
      
      
	endtask:run_phase
	

endclass : alu_monitor
