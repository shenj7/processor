// // Quartus Prime Verilog Template
// // Single port RAM with single read/write address 

// module memory 
// #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=9)
// (
// 	input [(DATA_WIDTH-1):0] data,
// 	input [(ADDR_WIDTH-1):0] addr,
// 	input we, clk,
// 	output [(DATA_WIDTH-1):0] q
// );

// 	// Declare the RAM variable
// 	reg [DATA_WIDTH-1:0] ram[0:2**ADDR_WIDTH-1];

// 	// Variable to hold the registered read address
// 	reg [ADDR_WIDTH-1:0] addr_reg;
	
// 	initial begin
// 		$readmemh("memory.txt", ram);
// 	end

// 	always @ (posedge clk)
// 	begin
// 		// Write
// 		if (we) begin
// 			if (<spec mem address) begin //do this in wrapper, also make sure to keep track of offsets
// 				q = input; //wont work, need to make sep wrapper for inst mem and data mem
// 			end else begin
// 			ram[addr<<1] <= data;
// 			end
// 		end

// 		addr_reg <= addr;
// 	end

// 	// Continuous assignment implies read returns NEW data.
// 	// This is the natural behavior of the TriMatrix memory
// 	// blocks in Single Port mode.  
// 	assign q = ram[addr_reg];

// endmodule
