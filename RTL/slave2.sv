module slave2 (
    input        PCLK,
    input        PRESETn,
    input        PSEL,
    input        PENABLE,
    input        PWRITE,
    input  [7:0] PADDR,
    input  [7:0] PWDATA,
    output [7:0] PRDATA1,
    output reg   PREADY
);

    reg [7:0] mem [0:63];
    reg [7:0] reg_addr;
    reg [1:0] wait_count;
    reg       active_transfer;
	integer i;
    assign PRDATA1 = mem[reg_addr];

    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PREADY <= 0;
            wait_count <= 0;
            active_transfer <= 0;
			reg_addr <=0;
			for ( i = 0; i < 64; i=i+1) 
				mem[i] <= 0;

        end else if (PSEL && PENABLE && !PREADY) begin
            // Wait cycles before ready
            if (wait_count == 2) begin
                PREADY <= 1;
                active_transfer <= 1;
            end else begin
                wait_count <= wait_count + 1;
                PREADY <= 0;
            end
        end else if (PREADY && active_transfer) begin
            // Perform read or write
            if (PWRITE)
                mem[PADDR] <= PWDATA;
            else
                reg_addr <= PADDR;

            // Finish transaction
            PREADY <= 0;
            wait_count <= 0;
            active_transfer <= 0;
        end else begin
            PREADY <= 0;
        end
    end

endmodule
