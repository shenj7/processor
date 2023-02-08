//test for imm gen
`timescale 1 ns/1 ps

module tb_counter();

//Inputs
reg clk;
reg reset;
reg [15:0] inst;

//Outputs
wire [15:0] imm;

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


IMM_GEN UUT (
    .clock(clk),
    .reset(rst),
    .instr(inst)
);


initial begin
    dir = 0;
    rst = 1;
    #(100*HALF_PERIOD);
    rst = 0;

    $display("Testing immgen")

    //-----TEST 1-----
    //Testing shift by 1 
    $display("Testing shift by 1.");
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


    //-----TEST 2-----
    //Testing shift by 8
    $display("Testing.shift by 8");

    
    //-----TEST 3-----
    //Testing sign extend positive
    $display("Testing sign extend positive numbers");
    

    //-----TEST 4-----
    //Testing sign extend negative
    $display("Testing sign extend on negative numbers");


    //-----TEST 5-----
    //Testing sign extend and shift left
    $display("Testing sign extend and shift by 1");


    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end


endmodule
