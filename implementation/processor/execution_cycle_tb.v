// testing execution cycle!
//integration tests
`timescale 1 ns/1 ps
module execute_cycle_tb();
//inputs
reg clk;
reg [15:0] pc;
reg [15:0] a;
reg [15:0] b;
reg [3:0] rd;
reg [15:0] imm;

//controls
reg rst;
reg aluop;
reg aluin1;
reg [1:0] aluin2;

//outputs
wire [15:0] bout;
wire [15:0] aluout;
wire [3:0] rdout;
wire zero;
wire pos;

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

execute_cycle UUT(
    .clk(clk),
    .pc(pc),
    .a(a),
    .b(b),
    .rd(rd),
    .imm(imm),
    .rst(rst),
    .aluop(aluop),
    .aluin1(aluin1),
    .aluin2(aluin2),
    .bout(bout),
    .aluout(aluout),
    .rdout(rdout),
    .zero(zero),
    .pos(pos)
);

initial begin
    rst = 1;
    #(100*HALF_PERIOD);
    rst = 0;

    //-----TEST 1-----
    //$display("Testing execute cycle: Add");
    rst = 1; 
    #(2*HALF_PERIOD);
    rst = 0;

    a= 16'b0000000000000000;
    b= 16'b0000000000000001;
    aluop = 0;
    aluin1 = 1;
    aluin2 = 0;
  
    
    expected = 16'b0000000000000001;

    #(4*HALF_PERIOD);
    
    if (aluout != expected) begin
        failures = failures + 1;
        //$display("%t (execute add) Output = %d, expecting %d", $time, aluout, expected);
    end
    
    #(100*HALF_PERIOD);

    //-----TEST 2-----
    //$display("Testing execute cycle: Subtract");
    rst = 1; 
    #(2*HALF_PERIOD);
    rst = 0;

    a= 16'b0000000000000010;
    b= 16'b0000000000000001;
    aluop = 0;
    aluin1 = 1;
    aluin2 = 0;
  
    
    expected = 16'b0000000000000001;

    #(4*HALF_PERIOD);
    
    if (aluout != expected) begin
        failures = failures + 1;
        //$display("%t (execute sub) Output = %d, expecting %d", $time, aluout, expected);
    end
    
    #(100*HALF_PERIOD);

    //-----TEST 3-----
    //$display("Testing execute cycle: Immediate Addition");
    rst = 1; 
    #(2*HALF_PERIOD);
    rst = 0;

    a= 16'b0000000000000010;
    imm= 16'b0000000000000001;
    aluop = 0;
    aluin1 = 1;
    aluin2 = 2;
  
    
    expected = 16'b0000000000000011;

    #(4*HALF_PERIOD);
    
    if (aluout != expected) begin
        failures = failures + 1;
        //$display("%t (execute sub) Output = %d, expecting %d", $time, aluout, expected);
    end
    
    #(100*HALF_PERIOD);


    //$display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;

end



endmodule