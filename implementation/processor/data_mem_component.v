// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module memory 
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=9)
(
	input [(DATA_WIDTH-1):0] writedata,
	input [(ADDR_WIDTH-1):0] addr,
	input write, clk,
	input [15:0] read_in,
	output [(DATA_WIDTH-1):0] out
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[0:2**ADDR_WIDTH-1];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;
	
	initial begin
		$readmemh("data_mem.txt", ram);
	end

	always @ (posedge clk)
	begin
		// Write
		if (write)
			ram[addr] <= writedata;

		addr_reg <= addr-4'h03ff;
		if (addr = *special*) begin
			out = read_in;
		end
		else begin
			out = ram[adrr_reg >>1];
		end
	end
endmodule
