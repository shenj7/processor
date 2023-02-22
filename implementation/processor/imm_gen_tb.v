//test for imm gen
`timescale 1 ns/1 ps

module imm_gen_tb();

//Inputs
reg clk;
reg reset;
reg [15:0] inst;

//Outputs
wire [15:0] out;

parameter HALF_PERIOD = 50;
integer failures = 0;
integer expected = 0;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
    end
end


imm_gen_component UUT (
    .clock(clk),
    .reset(reset),
    .inst(inst),
    .out(out)
);


initial begin
    reset = 1;
    #(100*HALF_PERIOD);
    reset = 0;

    //$display("Testing immgen");

    //-----TEST 1-----
    //Testing shift by 1 
    //$display("Testing shift by 1.");
    reset = 1; 
    #(2*HALF_PERIOD);
    reset = 0;
    inst = 16'b1001011010010110; 
    begin
        expected = {{8{inst[16]}},inst[15:8]} << 1; 
        if (out != expected) begin
            failures = failures + 1;
            //$display("%t (Shift by 1) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);


   
    
    //$display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end


endmodule
