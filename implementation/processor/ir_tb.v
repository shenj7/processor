//Testing the instruction register
`timescale 1 ns/1 ps
 module ir_component_tb();

 //inputs
 reg clock;
 reg [15:0] in1;
 reg reset;

 //outputs
 wire [3:0] rs1;
 wire [3:0] rs2;
 wire [3:0] rd;

parameter HALF_PERIOD = 50;
integer failures = 0;
integer expected = 0;

 initial begin
    clock = 0;
    forever begin
        #(HALF_PERIOD);
        clock = ~clock;
    end
 end

 ir_component UUT(
    .clock(clock),
    .in1(in1),
    .reset(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd)
 );

 initial begin
    reset = 1;
    #(100*HALF_PERIOD);
    reset = 0;

    $display("Testing Instruction Reg");

    //-----TEST 1-----
    $display("Testing rs2.");
    reset = 1; //reset 
    #(2*HALF_PERIOD);
    reset = 0;
    in1 = 16'b1111111111111111;
    $display(in1[15:12]);
    expected = 4'b1111; 
    if (rs2 != expected) begin
         failures = failures + 1;
        $display("%t (rs2) Output = %d, expecting %d", $time, rs2, expected);
    end
    #(100*HALF_PERIOD);
    
    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;
end



 endmodule
