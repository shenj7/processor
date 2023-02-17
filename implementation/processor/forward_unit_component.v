module forward_unit_component(rs1, rs2, rd, alusrc0, alusrc1);
//remove clock from loadstorej
input rs1;
input rs2;
input rd;
input oldalusrc0;
input oldalusrc1;

output reg alusrc0;
output reg alusrc1;

always @(*)
begin
    if (rd == rs1) begin
        alusrc0 <= 2'b10;
    end
    if (rd == rs2) begin
        alusrc1 <= 2'b11;
    end
    //also need a case for b - may need to forward b into memory
end



endmodule