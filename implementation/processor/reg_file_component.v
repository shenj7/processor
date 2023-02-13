// Register File

module reg_file_component(clock, rs1, rs2, rd, writedata, reset, write, reg1, reg2);

input clock;
input [3:0] rs1;
input [3:0] rs2;
input [3:0] rd;
input [3:0] writedata;
input reset;
input write;

output reg [15:0] reg1;
output reg [15:0] reg2;

parameter NUM_REG = 16;

reg [15:0] regs[NUM_REG-1:0];

always @(posedge clock)
begin
   //get out of rs1
   reg1 <= regs[rs1];
   
   //get out of rs2
   reg2 <= regs[rs2];

   //write to register
   if (write) begin
       regs[rd] <= writedata;
   end

   //reset
   if (reset) begin
       reg1 <= 0;
       reg2 <= 0;
   end



end
endmodule
