 module proc_tb();

//inputs
reg rst;
reg clk;
reg [15:0] IN;

//outputs
wire [15:0]  OUT;

parameter HALF_PERIOD = 50;
integer counter = 0;
integer failures = 0;
reg [15:0] expected;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
        counter = counter + 1;
    end
end

load_store UUT (
    .clock(clk),
    .read_in(IN),
    .rst(rst),    
    .write_out(OUT)    
);


//block to run the clock

initial begin
    rst = 1;
    #(10*HALF_PERIOD);
//test 1
    rst = 0;
    counter = 0;
    IN = 16'h13b0;
    expected = 16'h000b;
    @(OUT != 0);
    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 1");
    end
    $display("cycles for %d: %d", IN, counter);
    //$display("out: %d, expected: %d", OUT, expected);
    //$display("stinky poopy");
    #(2*HALF_PERIOD);
    rst = 1;
    #(2*HALF_PERIOD);
    // $stop;

//test 2
    rst = 0;
    counter = 0;
    IN = 16'h0906;
    expected = 16'h000d;
    @(OUT != 0);
    if (OUT != expected) begin
        failures = failures + 1;
    end
    $display("cycles for %d: %d", IN, counter);
    //$display("out: %d, expected: %d", OUT, expected);
    //$display("stinky poopy");
    #(2*HALF_PERIOD);
    rst = 1;
    #(2*HALF_PERIOD);
    // $stop;

// //test 3
    rst = 0;
    counter = 0;
    IN = 16'h754e;
    expected = 16'h0011;
    @(OUT != 0);
    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 1");
    end
    $display("cycles for %d: %d", IN, counter);
    //$display("out: %d, expected: %d", OUT, expected);
    //$display("stinky poopy");
    #(2*HALF_PERIOD);
    rst = 1;
    #(2*HALF_PERIOD);
    $stop;


// //test 4
//     rst = 0;
//     IN = 16'h1234;
//     expected = 16'h0003;
//     counter = counter + 1;

//     if (OUT != expected) begin
//         failures = failures + 1;
//         //$display(":( 2");
//     end

//     @(OUT != 0);
//     #(2*HALF_PERIOD);
//     rst = 1;
//     #(2*HALF_PERIOD);
end
endmodule
