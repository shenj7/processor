//test for imm gen
module tb_memory();

reg [15:0] data;
reg [15:0] addr;
reg we;
reg clk;


//Outputs
wire [15:0] q;

parameter HALF_PERIOD=50;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
    end
end 


memory UUT(
.data(data),
    .addr(addr),
    .clk(clk),
    .we(we),
	 .q(q)	 
); 

 initial begin
   clk = 0;
   addr = 'h0000;
   data = 'h1111;

   #(20*HALF_PERIOD);
   addr = 'h0001;
   #(20*HALF_PERIOD);
   addr = 'h0002;
   #(20*HALF_PERIOD);
   addr = 'h0003;

   #(20*HALF_PERIOD);
   addr = 'h0004;


   #(20*HALF_PERIOD);
   addr = 'h0008;
 end
	  
endmodule
