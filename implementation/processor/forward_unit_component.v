module forward_unit_component(rs1, rs2, rd, oldalusrc0, oldalusrc1, alusrc0, alusrc1, shouldb, originalb, newb);
//remove clock from loadstorej
input [3:0] rs1;
input [3:0] rs2;
input [3:0] rd; // get from both mem and writeback
input oldalusrc0;
input [1:0] oldalusrc1;
input [15:0] shouldb;
input [15:0] originalb;

output reg [1:0] alusrc0;
output reg [1:0] alusrc1;
output reg [15:0] newb;

always @(*)
begin
    if (rd == rs1) begin
        alusrc0 <= 2'b10;
    end else begin
        alusrc0 <= oldalusrc0;
    end
    if (rd == rs2) begin
        alusrc1 <= 2'b11;
        newb <= shouldb;
    end else begin
        alusrc1 <= oldalusrc1;
        newb <= originalb;
    end

    //also need a case for b - may need to forward b into memory
end



endmodule