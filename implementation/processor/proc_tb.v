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
    #(2*HALF_PERIOD);
//test 1
    rst = 0;
    IN = 16'h13b0;
    expected = 16'h000b;
    counter = counter + 1;
    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 1");
    end
    $display("out: %d, expected: %d", OUT, expected);
    $display("stinky poopy");
    // @(OUT != 0);
    #(2*HALF_PERIOD);

    rst = 1;
    #(2*HALF_PERIOD);

//test 2
    rst = 0;
    IN = 16'h1234;
    expected = 16'h0003;
    counter = counter + 1;

    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 2");
    end

    // @(OUT != 0);
    #(2*HALF_PERIOD);
    rst = 1;
    #(2*HALF_PERIOD);

//test 3
    rst = 0;
    IN = 16'h1234;
    expected = 16'h0003;
    counter = counter + 1;

    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 2");
    end

    // @(OUT != 0);
    #(2*HALF_PERIOD);
    rst = 1;
    #(2*HALF_PERIOD);
    $stop;


//test 4
    rst = 0;
    IN = 16'h1234;
    expected = 16'h0003;
    counter = counter + 1;

    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 2");
    end

    // @(OUT != 0);
    #(2*HALF_PERIOD);
    rst = 1;
    #(2*HALF_PERIOD);
end
endmodule
