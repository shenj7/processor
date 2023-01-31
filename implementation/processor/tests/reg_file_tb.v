//test for imm gen
`timescale 1 ns/1 ps

module tb_counter();

//Inputs
reg clk;
reg reset;
reg [3:0] rs1;
reg [3:0] rs2;
reg [3:0] rd;
reg [15:0] writedata;

//Outputs
wire [15:0] reg1;
wire [15:0] reg2;

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
Counter_E UUT (
    .direction(dir),
    .reset(rst),
    .CLK(clk),
    .dout(out)
);


initial begin
    dir = 0;
    rst = 1;
    #(100*HALF_PERIOD);
    rst = 0;

    $display("Testing reg file")

    //-----TEST 1-----
    //Testing counting up 
    $display("Testing counting up.");
    rst = 1;
    counter = 0;
    cycle_counter = 0;
    #(2*HALF_PERIOD);
    rst = 0;
    dir = 0; //we are testing counting up
    repeat (40) begin
        #(2*HALF_PERIOD);
        counter = counter + 1;
        if (cycle_counter == 31)
            counter = -32;
        cycle_counter = cycle_counter + 1;
        if (out != counter) begin
            failures = failures + 1;
            $display("%t (COUNT UP) Error at cycle %d, output = %d, expecting = %d", $time, cycle_counter, out, counter);
        end
    end
    #(100*HALF_PERIOD);


    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end


endmodule
