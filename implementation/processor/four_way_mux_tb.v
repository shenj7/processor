//4 way mux test
`timescale 1 ns/1 ps

module four_way_mux_tb();

//Inputs
reg rst;
reg clk;
reg [1:0] OP;
reg [15:0] IN0;
reg [15:0] IN1;
reg [15:0] IN2;
reg [15:0] IN3;

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


four_way_mux_component UUT (
    .in0(IN0),
    .in1(IN1),
    .in2(IN2),
    .in3(IN3),
    .op(OP),
    .reset(rst),
    .out(out)
);


initial begin
    rst = 1;
    #(100*HALF_PERIOD);
    rst = 0;
    //-----TEST 1-----
    OP = 2'b00;
    IN0 = 16'b0000000000000000;
    IN1 = 16'b0000000000000001;
    IN2 = 16'b0000000000000010;
    IN3 = 16'b0000000000000011;
    if (out != 16'b0000000000000000) begin
        failures = failures + 1;
        //$display("Test 1 Failed output = %d, expecting = %d", out, 0000000000000000);
    end
    //-----TEST 2-----
    OP = 2'b01;
    IN0 = 16'b0000000000000000;
    IN1 = 16'b0000000000000001;
    IN2 = 16'b0000000000000010;
    IN3 = 16'b0000000000000011;
    if (out != 16'b0000000000000001) begin
        failures = failures + 1;
        //$display("Test 2 Failed output = %d, expecting = %d", out, 0000000000000001);
    end
    //-----TEST 3-----
    OP = 2'b10;
    IN0 = 16'b0000000000000000;
    IN1 = 16'b0000000000000001;
    IN2 = 16'b0000000000000010;
    IN3 = 16'b0000000000000011;
    if (out != 16'b0000000000000010) begin
        failures = failures + 1;
        //$display("Test 2 Failed output = %d, expecting = %d", out, 0000000000000010);
    end
    //-----TEST 4-----
    OP = 2'b11;
    IN0 = 16'b0000000000000000;
    IN1 = 16'b0000000000000001;
    IN2 = 16'b0000000000000010;
    IN3 = 16'b0000000000000011;
    if (out != 16'b0000000000000011) begin
        failures = failures + 1;
        //$display("Test 2 Failed output = %d, expecting = %d", out, 0000000000000011);
    end
    //$display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;
end


endmodule
