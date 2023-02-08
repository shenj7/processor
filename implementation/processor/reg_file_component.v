// Register File

module reg_file_component(clock, rs1, rs2, rd, writedata, reset, write, reg1, reg2);

input clock;
input rs1[3:0];
input rs2[3:0];
input rd[3:0];
input writedata[3:0];
input reset;
input write;

output reg1[15:0];
output reg2[15:0];

integer NUM_REG = 16;

reg [15:0] regs[NUM_REG-1:0];

always @(posedge clock)
begin
    //get out of rs1
    reg1 <= regs[rs1];
    
    //get out of rs2
    reg2 <= regs[rs2];

    //write to register
    if (write) begin
        rd <= writedata;
    end

    //reset
    if (reset) begin
        reg1 <= 0;
        reg2 <= 0;
    end



end
endmodule
