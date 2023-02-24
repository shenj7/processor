// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module inst_mem_component 
// #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=9)
(
	input [15:0] addr,
	input clock,
	output [15:0] out
);

	// Declare the RAM variable
	reg [15:0] ram[0:2**8];

	// Variable to hold the registered read address
	reg [8:0] addr_reg;
	
	initial begin
		$readmemh("inst_mem.txt", ram);
	end

	always @ (posedge clock)
	begin
		addr_reg <= addr[9:1]; //since byte address vs word address
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign out = ram[addr_reg];

endmodule
