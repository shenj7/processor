// //integration tests
// `timescale 1 ns/1 ps

// module fetch_cycle_tb();

// //inputs
// input [15:0] pc;
// input pcwrite;
// input clk;
// input rst;


// //outputs
// output reg [15:0] ir;
// output reg [15:0] currpc;

// wire [15:0] ir;
// wire [15:0] newpc;

// parameter HALF_PERIOD = 50;
// integer failures = 0;
// integer expected = 0;

// initial begin
//     clk = 0;
//     forever begin
//         #(HALF_PERIOD);
//         clk = ~clk;
//     end
// end

// fetch_cycle UUT(
//     .pc(pc),
//     .pcwrite(pcwrite),
//     .clk(clk),
//     .rst(rst)
// );


// endmodule