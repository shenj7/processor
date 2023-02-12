////test for imm gen
//`timescale 1 ns/1 ps
//
//module tb_counter();
//
////Inputs
//reg clk;
//reg reset;
//reg [15:0] inst;
//
////Outputs
//wire [15:0] imm;
//
//parameter HALF_PERIOD = 50;
//integer failures = 0;
//integer expected = 0;
//
//initial begin
//    clk = 0;
//    forever begin
//        #(HALF_PERIOD);
//        clk = ~clk;
//    end
//end
//
//
//imm_gen_component UUT (
//    .clock(clk),
//    .reset(reset),
//    .inst(inst),
//    .out(imm)
//);
//
//
//initial begin
//    dir = 0;
//    rst = 1;
//    #(100*HALF_PERIOD);
//    rst = 0;
//
//    $display("Testing immgen")
//
//    //-----TEST 1-----
//    //Testing shift by 1 
//    $display("Testing shift by 1.");
//    rst = 1; //reset imm gen before testing
//    #(2*HALF_PERIOD);
//    rst = 0;
//    inst = 1001011010010110; //whatever instruction we want to test
//    begin
//        expected = 0000000000010110; //whatever is expected
//        if (out != expected) begin
//            failures = failures + 1;
//            $display("%t (Shift by 1) Output = %d, expecting %d" $time, out, expected);
//        end
//    end
//    #(100*HALF_PERIOD);
//
//
//    //-----TEST 2-----
//    //Testing shift by 8
//    $display("Testing.shift by 8");
//    rst = 1; //reset imm gen before testing
//    #(2*HALF_PERIOD);
//    rst = 0;
//    inst = 0100101101100101; //whatever instruction we want to test
//    begin
//        expected = 0100101100000000; //whatever is expected
//        if (out != expected) begin
//            failures = failures + 1;
//            $display("%t (Shift by 8) Output = %d, expecting %d" $time, out, expected);
//        end
//    end
//    #(100*HALF_PERIOD);
//
//    
//    //-----TEST 3-----
//    //Testing sign extend positive
//    $display("Testing sign extend positive numbers");
//    rst = 1; //reset imm gen before testing
//    #(2*HALF_PERIOD);
//    rst = 0;
//    inst = 0010010111111000; //whatever instruction we want to test
//    begin
//        expected = 0000000000100101; //whatever is expected
//        if (out != expected) begin
//            failures = failures + 1;
//            $display("%t (Sign extend positive) Output = %d, expecting %d" $time, out, expected);
//        end
//    end
//    #(100*HALF_PERIOD);
//    
//
//    //-----TEST 4-----
//    //Testing sign extend negative
//    $display("Testing sign extend on negative numbers");
//    rst = 1; //reset imm gen before testing
//    #(2*HALF_PERIOD);
//    rst = 0;
//    inst = 1111001101011001; //whatever instruction we want to test
//    begin
//        expected = 1111111111110011; //whatever is expected
//        if (out != expected) begin
//            failures = failures + 1;
//            $display("%t (Sign extend negative) Output = %d, expecting %d" $time, out, expected);
//        end
//    end
//    #(100*HALF_PERIOD);
//
//
//
//
//    $display("TESTS COMPLETE. \n Failures = %d", failures);
//    $stop;
//
//end
//
//
//endmodule
