//ALU test
module alu_component_tb();

//Inputs
reg reset;
reg [3:0] inst_id;
reg [15:0] in0;
reg [15:0] in1;
reg clk;

//Outputs
wire [15:0] out;
wire zero;
wire pos;

parameter HALF_PERIOD = 50;
integer failures = 0;
integer expected = 0;

initial begin
 forever begin
     #(HALF_PERIOD);
      clk = ~clk;
    end
end


alu_component UUT (
    .reset(reset),
    .inst_id(inst_id),
    .in0(in0),
    .in1(in1),
    .zero(zero),
    .pos(pos),
    .out(out)
);


initial begin
    reset = 1;
    #(100*HALF_PERIOD);
    reset = 0;

    $display("Testing ALU");

    //-----TEST 1-----
    $display("Testing ALU addition");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b0000;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    
    expected = 16'b0000000000000010;
    if (out != expected) begin
        failures = failures + 1;
        $display("%t (Addition) Output = %d, expecting %d", $time, out, expected);
    end
    
    #(100*HALF_PERIOD);

//-----TEST 2-----
    $display("Testing ALU addition");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b0100;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000010;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Addition) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);

//-----TEST 3-----
    $display("Testing ALU addition");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b0110;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000010;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Addition) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);

//-----TEST 4-----
    $display("Testing ALU addition");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b1000;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000010;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Addition) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);

//-----TEST 5-----
    $display("Testing ALU addition");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b1001;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000010;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Addition) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);
//-----TEST 6-----
    $display("Testing ALU addition");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b1010;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000010;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Addition) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);

//-----TEST 7-----
    $display("Testing ALU addition");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b1011;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000010;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Addition) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);

//-----TEST 8-----
    $display("Testing ALU subtraction");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b0001;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000000;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (subtraction) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);
    //-----TEST 9-----
    $display("Testing ALU subtraction");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b0010;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000000;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (subtraction) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);
    //-----TEST 10-----
    $display("Testing ALU subtraction");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b0011;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000000;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (subtraction) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);
    //-----TEST 11-----
    $display("Testing ALU subtraction");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b0101;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000000;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (subtraction) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);
    //-----TEST 12-----
    $display("Testing ALU subtraction");
    reset = 1; //reset ALU before testing
    #(2*HALF_PERIOD);
    reset = 0;
    inst_id = 4'b1100;
    in0 = 16'b0000000000000001;
    in1 = 16'b0000000000000001;
    begin
        expected = 16'b0000000000000000;
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (subtraction) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);

    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end


endmodule

