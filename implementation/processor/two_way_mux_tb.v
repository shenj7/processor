//2 way Mux Testing
`timescale 1 ns/1 ps

module two_way_mux_tb();

//Inputs
reg clk;
reg reset;
reg [15:0] in0;
reg [15:0] in1;
reg op;

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

two_way_mux_component UUT (
    .reset(reset),
    .in0(in0),
    .in1(in1),
    .op(op),
    .out(out)
);


initial begin
    reset = 1;
    #(100*HALF_PERIOD);
    reset = 0;
    //-----TEST 1-----
    op = 0;
    in0 = 0000000000000000;
    in1 = 0000000000000001;
    if (out != 0000000000000000) begin
        failures = failures + 1;
        $display("Test 1 Failed output = %d, expecting = %d", out, 0000000000000000);
    end
    //------TEST 2-----
    op = 1;
    in0 = 0000000000000000;
    in1 = 0000000000000001;
    if (out != 0000000000000001) begin
        failures = failures + 1;
        $display("Test 2 Failed output = %d, expecting = %d", out, 0000000000000001);
    end
    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;
end

endmodule
