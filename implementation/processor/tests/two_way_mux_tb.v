//2 way Mux Testing
`timescale 1 ns/1 ps

module two_way_mux_tb();

//Inputs
reg clk;
reg reset;
reg [15:0] in1;
reg [15:0] in2;
reg [0] op;

//Outputs
wire [15:0] out;

parameter HALF_PERIOD = 50;
integer cycle_counter = 0;
integer counter = 0;
integer failures = 0;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
    end
end


REG
two_way_mux UUT (
    .clk(clk),
    .reset(reset),
    .in1(in1),
    .in2(in2)
    .op(op),
    .out(out)
);


initial begin
    dir = 0;
    rst = 1;
    #(100*HALF_PERIOD);
    rst = 0;
	 //-----TEST 1-----
    OP = 0;
	 IN0 = 0000000000000000;
	 IN1 = 0000000000000001;
	 if (out != 0000000000000000) begin
            failures = failures + 1;
            $display("Test 1 Failed output = %d, expecting = %d", output, 0000000000000000);
        end
	 //-----TEST 2-----
    OP = 1;
	 IN0 = 0000000000000000;
	 IN1 = 0000000000000001;
	 if (out != 0000000000000001) begin
            failures = failures + 1;
            $display("Test 2 Failed output = %d, expecting = %d", output, 0000000000000001);
        end
    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;
end


endmodule
