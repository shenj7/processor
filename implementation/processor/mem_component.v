// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module mem_component 
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] writedata,
	input [15:0] addr,
	input read,
	input write, clk, reset,
	input [15:0] read_in,
	output reg [15:0] write_out,
	output reg [(DATA_WIDTH-1):0] out
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[0:2**ADDR_WIDTH-1];

	// // Variable to hold the registered read address
	// reg [ADDR_WIDTH-1:0] addr_reg;
	
	initial begin
		$readmemh("mem.txt", ram);
		write_out <= 0;
	end

	always @(posedge ~clk)
	begin
		// addr_reg = addr-4'h0280; //could also change to 2ff
		//$display("data mem reading %d", addr_reg);
		// Write
		if (write) begin
			if (addr != 16'h1420) begin
				ram[addr[10:1]] = writedata;
			end
			else begin
				write_out <= writedata;
			end
		end
	end

	always @(posedge clk)
	begin
		if (reset) begin
			write_out = 16'h0000;
		end else if (read) begin
			if (addr != 16'h1420) begin
				out = ram[addr[10:1]];
			end
			else begin
				// $display("plz dont come here");
				out <= read_in;
			end
		end
	end
endmodule
