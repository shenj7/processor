`timescale 1 ns/1 ps

module tb_counter();

//Inputs
reg rst;
reg clk;
wire signed [1:0] OP;
wire signed [15:0] IN0;
wire signed [15:0] IN1;
wire signed [15:0] IN2;
wire signed [15:0] IN3;

//Outputs
wire signed [15:0] out;

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


four_way_mux_component UUT (
    .clock(clk),
	 .in0(IN0),
	 .in1(IN1),
	 .in2(IN2),
	 .in3(IN3),
	 .op(OP),
	 .reset(rst),
	 .out(out)
);


initial begin
    dir = 0;
    rst = 1;
    #(100*HALF_PERIOD);
    rst = 0;
	 //-----TEST 1-----
    OP = 00;
	 IN0 = 0000000000000000;
	 IN1 = 0000000000000001;
	 IN2 = 0000000000000010;
	 IN2 = 0000000000000011;
	 if (out != 0000000000000000) begin
            failures = failures + 1;
            $display("Test 1 Failed output = %d, expecting = %d", output, 0000000000000000);
        end
	 //-----TEST 2-----
    OP = 01;
	 IN0 = 0000000000000000;
	 IN1 = 0000000000000001;
	 IN2 = 0000000000000010;
	 IN2 = 0000000000000011;
	 if (out != 0000000000000001) begin
            failures = failures + 1;
            $display("Test 2 Failed output = %d, expecting = %d", output, 0000000000000001);
        end
	 //-----TEST 3-----
    OP = 10;
	 IN0 = 0000000000000000;
	 IN1 = 0000000000000001;
	 IN2 = 0000000000000010;
	 IN2 = 0000000000000011;
	 if (out != 0000000000000010) begin
            failures = failures + 1;
            $display("Test 2 Failed output = %d, expecting = %d", output, 0000000000000010);
        end
	 //-----TEST 4-----
    OP = 11;
	 IN0 = 0000000000000000;
	 IN1 = 0000000000000001;
	 IN2 = 0000000000000010;
	 IN2 = 0000000000000011;
	 if (out != 0000000000000011) begin
            failures = failures + 1;
            $display("Test 2 Failed output = %d, expecting = %d", output, 0000000000000011);
        end
    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;
end


endmodule