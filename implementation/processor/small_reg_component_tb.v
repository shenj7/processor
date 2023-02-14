//testing for small register
`timescale 1 ns/1 ps

module small_reg_tb();

//Inputs
reg clk;
reg reset;
reg write;
reg [3:0] in;

//Outputs
wire [3:0] out;

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


small_reg_component UUT (
    .clk(clk),
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
    $display("Testing small reg reset");
    reset = 1; 
    #(2*HALF_PERIOD);
    reset <= 1;
    write <= 0;
    clk <= 1;
    in = 4'b0110;
    begin
        expected = 4'b0000; 
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Small Reg reset) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);


    //-----TEST 2-----
    $display("Testing small reg");
    reset = 1; 
    #(2*HALF_PERIOD);
    reset <= 0;
    write <= 1;
    clk <= 1;
    in = 4'b1111;
    begin
        expected = 4'b1111; 
        if (out != expected) begin
            failures = failures + 1;
            $display("%t (Small Reg) Output = %d, expecting %d", $time, out, expected);
        end
    end
    #(100*HALF_PERIOD);


    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end


endmodule
