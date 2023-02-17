module proc_tb();

//inputs
reg rst;
reg clk;
reg [15:0] IN;

//outputs
wire [15:0]  OUT;

load_store UUT (
    .rst(rst),
    .read_in(IN),
    .write_out(OUT),
    .clock(clk)
);

parameter HALF_PERIOD = 50;
integer cycle_counter = 0;
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


//block to run the clock

initial begin
    rst = 1;
    #(2*HALF_PERIOD);
//test 1
    rst = 0;
    IN = 16'h13b0;
    expected = 16'h000b;
    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 1");
    end
    @(OUT != 0);
    #(2*HALF_PERIOD);

    rst = 1;
    #(2*HALF_PERIOD);

//test 2
    rst = 0;
    IN = 16'h1234;
    expected = 16'h0003;

    if (OUT != expected) begin
        failures = failures + 1;
        $display(":( 2");
    end

    @(OUT != 0);
    #(2*HALF_PERIOD);

    $stop;
end
endmodule
