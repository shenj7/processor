//test for imm gen
module inst_mem_tb();


reg [15:0] addr;
reg clk;

//Outputs
wire [15:0] out;

parameter HALF_PERIOD=50;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
    end
end 


inst_mem_component UUT(
    .addr(addr),
    .clk(clk),
	.out(out)	 
); 

 initial begin
   clk = 0;
   addr = 'h0000;

   #(20*HALF_PERIOD);
   addr = 'h0000;
   #(20*HALF_PERIOD);
   addr = 'h0002;
   #(20*HALF_PERIOD);
   addr = 'h0004;

   #(20*HALF_PERIOD);
   addr = 'h0006;
   #(20*HALF_PERIOD);
   addr = 'h0008;
   #(20*HALF_PERIOD);
   addr = 'h000a;
   #(20*HALF_PERIOD);
   addr = 'h000c;

   #(20*HALF_PERIOD);
   addr = 'h000e;
   #(20*HALF_PERIOD);
   addr = 'h0010;
   #(20*HALF_PERIOD);
   addr = 'h0012;
   #(20*HALF_PERIOD);
   addr = 'h0014;

   #(20*HALF_PERIOD);
   addr = 'h0016;


   #(20*HALF_PERIOD);
   addr = 'h000d;
 end
	  
endmodule