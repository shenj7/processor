//testing for small register
`timescale 1 ns/1 ps

module small_reg_component_tb();

//Inputs
reg clock;
reg reset;
reg write;
reg [3:0] in;

//Outputs
wire [3:0] out;

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


small_reg_component UUT (
    .clock(clock),
    .reset(reset),
    .write(write),
    .in(in),
    .out(out)
);


initial begin
    reset = 1;
    #(100*HALF_PERIOD);
    reset = 0;

    //-----TEST 1-----
    //$display("Testing small reg reset");
    reset = 1; 
    #(2*HALF_PERIOD);
    reset = 1;
    write = 0;
    in = 16'b0110;
    #(2*HALF_PERIOD);
    begin
        expected = 16'b0000; 
        if (out != expected) begin
            failures = failures + 1;
            //$display("%t (Small reg reset) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);


    //-----TEST 2-----
    //$display("Testing small reg");
    reset = 1; 
    #(2*HALF_PERIOD);
    reset = 0;
    write = 1;
    in = 4'b1111;
    #(2*HALF_PERIOD);
    begin
        expected = 4'b1111; 
        if (out != expected) begin
            failures = failures + 1;
            //$display("%t (Small Reg) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);

     //-----TEST 3-----
    //$display("Testing small reg write");
    reset = 1; 
    #(2*HALF_PERIOD);
    reset = 0;
    write = 0;
    in = 4'b1111;
    #(2*HALF_PERIOD);
    begin
        expected = 4'b0000; 
        if (out != expected) begin
            failures = failures + 1;
            //$display("%t (Small Reg write) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);


    //$display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end


endmodule
