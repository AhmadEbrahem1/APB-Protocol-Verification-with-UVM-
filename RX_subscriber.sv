`uvm_analysis_imp_decl(_PORT_A)
`uvm_analysis_imp_decl(_PORT_B)
`uvm_analysis_imp_decl(_PORT_C)
`uvm_analysis_imp_decl(_PORT_C1)

class APB_subscriber  extends uvm_component;
  

	RX_sequence_item sequence_item_c1;
	
	uvm_analysis_imp_PORT_A #(RX_sequence_item, APB_subscriber) analysis_imp_A;
	uvm_analysis_imp_PORT_B #(RX_sequence_item, APB_subscriber) analysis_imp_B;
	uvm_analysis_imp_PORT_C #(RX_sequence_item, APB_subscriber) analysis_imp_C;
    uvm_analysis_imp_PORT_C1 #(RX_sequence_item, APB_subscriber) analysis_imp_C1;
	RX_sequence_item sequence_item_cl_passive;
	RX_sequence_item sequence_item_dl_passive;
	RX_sequence_item sequence_item_d2_passive;

  
  // Factory Registration
  `uvm_component_utils(APB_subscriber)
  

    
  
  covergroup clock_lane (input string inst_name);
        option.per_instance = 1;
        option.name = inst_name;
        
        RST: coverpoint sequence_item_c1.RST {
            bins bin_1[] = {0, 1};
            bins bin_2 = (0 => 1); 
            bins bin_3 = (1 => 0); 
        }
        ENABLE: coverpoint sequence_item_c1.ENABLE;
        Dp_CLK: coverpoint sequence_item_c1.Dp_CLK;
        Dn_CLK: coverpoint sequence_item_c1.Dn_CLK;
  
    endgroup : clock_lane
/*
    // Data lane escape mode coverage
    covergroup Data_Lane_1 (input string inst_name);
        option.per_instance = 1;
        option.name = inst_name;
        
		
		 Dp: coverpoint sequence_item_D1.Dp {
            bins bin_1 = (1 => 0);
        }
        Dn: coverpoint sequence_item_D1.Dn {
            bins bin_1 = (0 => 1);
        }

        RST_c: coverpoint sequence_item_D1.RST;
        
        dp_dn: cross sequence_item_D1.Dp, sequence_item_D1.Dn, RST_c {
            bins bin_0 = binsof(RST_c) intersect {0};
        }

        sync_pattern: coverpoint sequence_item_D1.sync_pattern {
            bins sync_T = {5'b11101}; 
            bins sync_T_1e[] = {5'b01101, 5'b10101, 5'b11001, 5'b11111, 5'b11100};
            bins sync_F = {[0:12], [14:20], [22:24], 26, 27, 30};
        }

        
        Entry_Command: coverpoint sequence_item_D1.Entry_Command { 
            bins Entry_Command_T[] = {8'b11100001, 8'b00011110, 8'b10011111, 8'b11011110, 8'b01100010, 8'b01011101, 8'b00100001, 8'b10100000};
            bins Entry_Command_F = {[0:29], 31, 32, [34:92], [94:97], [99:158], [161:221], 223, 224, [226:255]};
        }
		
    endgroup : Data_Lane_1

    // High Speed coverage
    covergroup Data_Lane_2 (input string inst_name);
        option.per_instance = 1;
        option.name = inst_name;
        
		 Dp: coverpoint sequence_item_D2.Dp {
            bins bin_1 = (1 => 0);
        }
        Dn: coverpoint sequence_item_D2.Dn {
            bins bin_1 = (0 => 1);
        }

        RST_c: coverpoint sequence_item_D2.RST;
        
        dp_dn: cross sequence_item_D2.Dp, sequence_item_D2.Dn, RST_c {
            bins bin_0 = binsof(RST_c) intersect {0};
        }

        sync_pattern: coverpoint sequence_item_D2.sync_pattern {
            bins sync_T = {5'b11101}; 
            bins sync_T_1e[] = {5'b01101, 5'b10101, 5'b11001, 5'b11111, 5'b11100};
            bins sync_F = {[0:12], [14:20], [22:24], 26, 27, 30};
        }

        
        Entry_Command: coverpoint sequence_item_D2.Entry_Command { 
            bins Entry_Command_T[] = {8'b11100001, 8'b00011110, 8'b10011111, 8'b11011110, 8'b01100010, 8'b01011101, 8'b00100001, 8'b10100000};
            bins Entry_Command_F = {[0:29], 31, 32, [34:92], [94:97], [99:158], [161:221], 223, 224, [226:255]};
        }
        		
    endgroup : Data_Lane_2

*/
  covergroup clock_lane_passive (input string inst_name);
        option.per_instance = 1;
        option.name = inst_name;
        
        // Output span coverage
        Stopstate_clk: coverpoint sequence_item_cl_passive.Stopstate_clk;
        RxUlpsClkNot: coverpoint sequence_item_cl_passive.RxUlpsClkNot;
        UlpsActiveNot: coverpoint sequence_item_cl_passive.UlpsActiveNot;
        RxClkActiveHS: coverpoint sequence_item_cl_passive.RxClkActiveHS;
        error_seqence: coverpoint sequence_item_cl_passive.error_seqence {bins bin0 = {0};}
    endgroup : clock_lane_passive

    // Data lane escape mode coverage
    covergroup Data_Lane_1_passive (input string inst_name);
        option.per_instance = 1;
        option.name = inst_name;
        
		
        Stopstate_data: coverpoint sequence_item_dl_passive.Stopstate_data;
		
        //ESC
        RxValidEsc: coverpoint sequence_item_dl_passive.RxValidEsc;
        RxLpdtEsc: coverpoint sequence_item_dl_passive.RxLpdtEsc;
        RxUlpsEsc: coverpoint sequence_item_dl_passive.RxUlpsEsc;
        RxTriggerEsc: coverpoint sequence_item_dl_passive.RxTriggerEsc{bins bin_0 [] = {'b0000, 'b1000, 'b0001 };}
        Error_sig: coverpoint sequence_item_dl_passive.Error_sig{bins bin0 = {0};}
		//HS
        RxValidHS: coverpoint sequence_item_dl_passive.RxValidHS;
        RxActiveHS: coverpoint sequence_item_dl_passive.RxActiveHS;
        SOT_SYNC_ERROR: coverpoint sequence_item_dl_passive.SOT_SYNC_ERROR{bins bin0 = {0};}
        SOT_ERROR: coverpoint sequence_item_dl_passive.SOT_ERROR{bins bin0 = {0};}
		
    endgroup : Data_Lane_1_passive

    // High Speed coverage
    covergroup Data_Lane_2_passive (input string inst_name);
        option.per_instance = 1;
        option.name = inst_name;
     
        Stopstate_data: coverpoint sequence_item_d2_passive.Stopstate_data;
		
        //ESC
         RxValidEsc: coverpoint sequence_item_dl_passive.RxValidEsc;
        RxLpdtEsc: coverpoint sequence_item_dl_passive.RxLpdtEsc;
        RxUlpsEsc: coverpoint sequence_item_dl_passive.RxUlpsEsc;
        RxTriggerEsc: coverpoint sequence_item_dl_passive.RxTriggerEsc{bins bin_0 [] = {'b0000, 'b1000, 'b0001 };}
        Error_sig: coverpoint sequence_item_dl_passive.Error_sig{bins bin0 = {0};}
		//HS
        RxValidHS: coverpoint sequence_item_dl_passive.RxValidHS;
        RxActiveHS: coverpoint sequence_item_dl_passive.RxActiveHS;
        SOT_SYNC_ERROR: coverpoint sequence_item_dl_passive.SOT_SYNC_ERROR{bins bin0 = {0};}
        SOT_ERROR: coverpoint sequence_item_dl_passive.SOT_ERROR{bins bin0 = {0};}
		
    endgroup : Data_Lane_2_passive

   //UVM Phases
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    `uvm_info ("Subscriber" ,"We_Are_Now_In_Subscriber_Build_Phase",UVM_NONE)
		sequence_item_c1 = RX_sequence_item::type_id::create("sequence_item_c1");
		
		sequence_item_cl_passive = RX_sequence_item::type_id::create("sequence_item_cl_passive");
		sequence_item_dl_passive = RX_sequence_item::type_id::create("sequence_item_dl_passive");
		sequence_item_d2_passive = RX_sequence_item::type_id::create("sequence_item_d2_passive");
    endfunction
    
  function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
    `uvm_info ("Subscriber" ,"We_Are_Now_In_Subscriber_Connect_Phase",UVM_NONE)
    endfunction


    function new (string name = "APB_subscriber", uvm_component parent = null); 
        super.new(name, parent);
        clock_lane = new("Clock_Lane");
		clock_lane_passive = new("clock_lane_passive");
        Data_Lane_1_passive = new("Data_Lane_1_passive");
        Data_Lane_2_passive = new("Data_Lane_2_passive");
		analysis_imp_A = new("analysis_imp_A", this);
		analysis_imp_B = new("analysis_imp_B", this);
		analysis_imp_C = new("analysis_imp_C", this);
		analysis_imp_C1 = new("analysis_imp_C1", this);
	
    endfunction

 
	     
  task run_phase(uvm_phase phase);
      super.run_phase(phase);
    `uvm_info ("Subscriber" ,"We_Are_Now_In_Subscriber_Run_Phase",UVM_NONE)
	
    endtask
  
  	 

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("clock_lane Coverage is %f", clock_lane.get_coverage()), UVM_NONE)
		`uvm_info(get_full_name(), $sformatf("clock_lane_passive Coverage is %f", clock_lane_passive.get_coverage()), UVM_NONE)
        `uvm_info(get_type_name(), $sformatf("Data_Lane_1_passive Coverage is %f", Data_Lane_1_passive.get_coverage()), UVM_NONE)
		`uvm_info(get_full_name(), $sformatf("Data_Lane_2_passive Coverage is %f", Data_Lane_2_passive.get_coverage()), UVM_NONE)
		
    endfunction
	
	
	 virtual function void write_PORT_A (RX_sequence_item t);
	 sequence_item_dl_passive = t ;
    Data_Lane_1_passive.sample();
	endfunction
  
  
  virtual function void write_PORT_B (RX_sequence_item t);
    sequence_item_d2_passive = t ;
	Data_Lane_2_passive.sample();

	
  endfunction
	
	
 virtual function void write_PORT_C (RX_sequence_item t);
    sequence_item_cl_passive = t ;
	clock_lane_passive.sample();
  endfunction
  
   virtual function void write_PORT_C1 (RX_sequence_item t);
	 sequence_item_c1 = t ;
    clock_lane.sample();
  endfunction



endclass

/// coverage report -detail