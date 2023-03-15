// Instruction register

module ir_component(in1, reset, write, inst, rs1, rs2, rd);

input [15:0] in1;
input reset;
input write;

output reg [15:0] inst;
output reg [3:0] rs1;
output reg [3:0] rs2;
output reg [3:0] rd;
// output reg [3:0] op;


always @(in1, reset, write)
begin
    if (reset == 1) begin
        rs1 <= 4'b0000;
        rs2 <= 4'b0000;
        rd <= 4'b0000;
        inst <= 4'h0000;
        // op <= 4'b0000;
    end else if (write == 1) begin
        rs1 <= in1[11:8];
        rs2 <= in1[15:12];
        rd <= in1[7:4];
        inst <= in1;
        // op <= in1[3:0];
    end
end

endmodule
