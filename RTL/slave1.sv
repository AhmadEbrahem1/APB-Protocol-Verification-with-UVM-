////////////////////////////////////////////////
//
// Name:   Shubhi Agrawal
// Design: APB2 Protocol Slave-1
// Date:   13-06-2021
//
///////////////////////////////////////////////


module slave1(
         input PCLK,PRESETn,
         input PSEL,PENABLE,PWRITE,
         input [7:0]PADDR,PWDATA,
        output [7:0]PRDATA1,
        output reg PREADY );
    
     reg [7:0]reg_addr;
     reg [7:0] mem [0:63];
	integer i;
    assign PRDATA1 =  mem[reg_addr];
	
	
	
	
	
    always @(*)
       begin
	   reg_addr=0;
        if(!PRESETn) begin
            PREADY = 0;
			reg_addr=0;
			for ( i = 0; i < 64; i=i+1) 
				mem[i] = 0;

		end	
        else
	  if(PSEL && !PENABLE && !PWRITE)
	     begin PREADY = 0; end
	         
	  else if(PSEL && PENABLE && !PWRITE)
	     begin  PREADY = 1;
                    reg_addr =  PADDR; 
	       end
          else if(PSEL && !PENABLE && PWRITE)
	     begin  PREADY = 0; end

	  else if(PSEL && PENABLE && PWRITE)
	     begin  PREADY = 1;
	            mem[PADDR] = PWDATA; end

           else PREADY = 0;
        end
    endmodule
        
