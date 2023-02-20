// Register File

module reg_file_component(clock, rs1, rs2, rd, writedata, reset, write, reg1, reg2);

input clock;
input [3:0] rs1;
input [3:0] rs2;
input [3:0] rd;
input [15:0] writedata;
input reset;
input write;

output reg [15:0] reg1;
output reg [15:0] reg2;

parameter NUM_REG = 16;

reg [15:0] regs[NUM_REG-1:0];
integer i = 0;
initial begin
  for (i=0;i<NUM_REG;i=i+1)
    regs[i] = 0;
end

always @(posedge clock)
begin
    //write to register
    if (write && rd != 4'b0000) begin
        regs[rd] = writedata;
    end

    //get out of rs1
    if (rs1 == 0) begin
        reg1 <= 4'h0000;
    end else begin
        reg1 <= regs[rs1];
    end

    //get out of rs2
    if (rs2 == 0) begin
        reg1 <= 4'h0000;
    end else begin
        reg2 <= regs[rs2];
    end


    //reset
    if (reset) begin
        reg1 <= 0;
        reg2 <= 0;
    end



end
endmodule
