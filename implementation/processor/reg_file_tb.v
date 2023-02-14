//test for imm gen
`timescale 1 ns/1 ps

module reg_file_tb();

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
integer expected = 0;
integer rst = 0;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
    end
end


Counter_E UUT (
    .direction(dir),
    .reset(rst),
    .CLK(clk),
    .dout(out)
);


initial begin
    reset = 1;
    #(100*HALF_PERIOD);
    reset = 0;

    $display("Testing reg file");
	 rs1 = 0000;
	 rs2 = 0001;
	 
    //-----TEST 1-----
    //Testing put 5 into reg1
    $display("Testing put 5 into reg1.");
    rst = 1; //reset imm gen before testing
    #(2*HALF_PERIOD);
    rst = 0;
    rd = 0000; //whatever rd we want to test
	 writedata = 0000000000000101; //whatever writedata we want to test
    begin
        expected = 0000000000000101; //whatever is expected
        if (reg1 != expected) begin
            failures = failures + 1;
            $display("%t (put 5 into reg1) Output = %d, expecting %d", $time, reg1, expected);
        end
    end
    #(100*HALF_PERIOD);
	 
	 //-----TEST 2-----
    //Testing put 5 into reg2
    $display("Testing put 5 into reg2.");
    rst = 1; //reset imm gen before testing
    #(2*HALF_PERIOD);
    rst = 0;
    rd = 0001; //whatever rd we want to test
	 writedata = 0000000000000101; //whatever writedata we want to test
    begin
        expected = 0000000000000101; //whatever is expected
        if (reg2 != expected) begin
            failures = failures + 1;
            $display("%t (put 5 into reg2) Output = %d, expecting %d", $time, reg2, expected);
        end
    end
    #(100*HALF_PERIOD);
	 
	 //-----TEST 3-----
    //Testing put 7 into reg1
    $display("Testing put 7 into reg1.");
    rst = 1; //reset imm gen before testing
    #(2*HALF_PERIOD);
    rst = 0;
    rd = 0000; //whatever rd we want to test
	 writedata = 0000000000000111; //whatever writedata we want to test
    begin
        expected = 0000000000000111; //whatever is expected
        if (reg1 != expected) begin
            failures = failures + 1;
            $display("%t (put 5 into reg1) Output = %d, expecting %d", $time, reg1, expected);
        end
    end
    #(100*HALF_PERIOD);
	 
	 //-----TEST 4-----
    //Testing put 7 into reg2
    $display("Testing put 7 into reg2.");
    rst = 1; //reset imm gen before testing
    #(2*HALF_PERIOD);
    rst = 0;
    rd = 0001; //whatever rd we want to test
	 writedata = 0000000000000111; //whatever writedata we want to test
    begin
        expected = 0000000000000111; //whatever is expected
        if (reg2 != expected) begin
            failures = failures + 1;
            $display("%t (put 5 into reg2) Output = %d, expecting %d", $time, reg2, expected);
        end
    end
    #(100*HALF_PERIOD);

    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end


endmodule
