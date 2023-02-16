//integration tests
`timescale 1 ns/1 ps

module decode_cycle_tb();

//inputs
reg rst;
reg [15:0] ir;
reg [15:0] pc;
reg clk;
reg [15:0] writedata;
reg regwrite;


//outputs
wire [15:0] pcout;
wire [15:0] a;
wire [15:0] b;
wire [3:0] rdout;
wire [15:0] imm;

wire [3:0] rs1;
wire [3:0] rs2;
wire [3:0] rd;

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

decode_cycle UUT(
    .rst(rst),
    .ir(ir),
    .pc(pc),
    .clk(clk),
    .writedata(writedata),
    .regwrite(regwrite),
    .pcout(pcout),
    .a(a),
    .b(b),
    .rdout(rdout),
    .imm(imm)
);

initial begin
    rst = 1;
    #(100*HALF_PERIOD);
    rst = 0;

    //-----TEST 1-----
    $display("Testing decode cycle");
    rst = 1; 
    #(2*HALF_PERIOD);
    rst = 0;
   //add op= 0
   //rd = 0110
   //rs1 = 0001
   //rs2 = 0010
    ir = 16'b0010000101100000;
    pc = 16'b0000000000000000;
    writedata = 16'b0000000000000000;
    regwrite = 1;

    #(2*HALF_PERIOD);
    begin
        expected = 4'b0001; 
        if (a != expected) begin
            failures = failures + 1;
            $display("%t (decode rs1) Output = %d, expecting %d", $time, a, expected);
        end
    end
    #(100*HALF_PERIOD);

    $display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end

endmodule
