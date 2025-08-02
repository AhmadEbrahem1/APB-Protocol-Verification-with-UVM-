
class alu_scoreboard extends uvm_monitor;

  `uvm_component_utils(alu_scoreboard)


  alu_sequence_item transactions[$];
  uvm_analysis_imp #(alu_sequence_item,alu_scoreboard) scb_analysis_imp;
  
   function new(string name ="alu_scoreboard", uvm_component parent);
   
		super.new(name,parent);
     scb_analysis_imp=new("scb_analysis_imp",this);
		`uvm_info("alu_scoreboard","inside constructor !",UVM_HIGH)
   endfunction:new


		//---------build_phase----------------

   function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("alu_scoreboard","build_phase !",UVM_HIGH)
		
	endfunction:build_phase
  
  
  
  
			//---------connect_phase----------------

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("alu_scoreboard","connect_phase !",UVM_HIGH)

	endfunction:connect_phase
	//---------run_phase----------------
	task  run_phase(uvm_phase phase);
		super.run_phase(phase);
     
		`uvm_info("alu_scoreboard","run_phase !",UVM_HIGH)
      
      
      forever  
        begin
           alu_sequence_item curr_tx;
		//logic
          wait(transactions.size() !=0);
          curr_tx=transactions.pop_front(); //FIFO
          compare(curr_tx);
        end
      
      
	endtask:run_phase
	
  function  void write (alu_sequence_item item);
    transactions.push_back(item);
  endfunction: write
  
  
  
  task compare(alu_sequence_item curr_tx);
    logic [7:0] actual, expected ;
    actual=curr_tx.ALU_OUT;
	$sformatf("HEREEEEE");
    case(curr_tx.ALU_SEL)
      	'd0:
          begin
            expected=curr_tx.A+curr_tx.B;
          end
        'd1:
          begin
            expected=curr_tx.A-curr_tx.B;
          end
        'd2:
          begin
            expected=curr_tx.A*curr_tx.B;
          end
        'd3: 
          begin
            expected=curr_tx.A/curr_tx.B;
          end
        default:
      	begin
        expected =0 ;
      	end
    endcase
    
    if(expected==actual )
      `uvm_info("COMAPRE",$sformatf("SUCCEEDED! "),UVM_LOW)
      else
        `uvm_error("COMAPRE",$sformatf("ERROR ! actual = %0d but expected = %0d ",actual,expected))

  endtask : compare
endclass : alu_scoreboard
