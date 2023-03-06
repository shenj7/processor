// module forward_unit_component(rs1, rs2, rd, oldalusrc0, oldalusrc1, alusrc0, alusrc1, shouldb, originalb, newb);
// //remove clock from loadstorej
// input [3:0] rs1;
// input [3:0] rs2;
// input [3:0] rd; // get from both mem and writeback
// input oldalusrc0;
// input [1:0] oldalusrc1;
// input [15:0] shouldb;
// input [15:0] originalb;

// output reg [1:0] alusrc0;
// output reg [1:0] alusrc1;
// output reg [15:0] newb;

// always @(*)
// begin
//     // if (rd == rs1 && oldalusrc1 == 1) begin
//     //     alusrc0 <= 2'b10;
//     // end else begin
//     //     alusrc0 <= oldalusrc0;
//     // end
//     // if (rd == rs2) begin
//         // alusrc1 <= 2'b11;
//     //     newb <= shouldb;
//     // end else begin
//         // alusrc1 <= oldalusrc1;
//     //     newb <= originalb;
//     // end

//     if rd == rs1 begin


//     //also need a case for b - may need to forward b into memory
// end
// module forward_unit_component(write_rd, mem_rd, rs1, rs2, forward_a, forward_b);

// input [3:0] rs1;
// input [3:0] rs2;
// input [3:0] write_rd;
// input [3:0] mem_rd;

// output reg [1:0] forward_a;
// output reg [1:0] forward_b;

// always @(*) begin
//     if (rs1 == write_rd) begin
//         forward_a <= 2'b01;
//     end else if (rs1 == mem_rd) begin
//         forward_a <= 2'b10;
//     end
//     else begin
//         forward_a <= 2'b00;
//     end

//     if (rs2 == write_rd) begin
//         forward_b <= 2'b01;
//     end else if (rs2 == mem_rd) begin
//         forward_b <= 2'b10;
//     end else begin
//         forward_b <= 2'b00;
//     end
// end

module forward_unit_component(new_rs1, new_rs2, old_inst_op, old_exe_rd, old_mem_rd, old_alusrc1, old_alusrc2, memout, aluout, forward_a, forward_b, new_alusrc1, new_alusrc2); //do we need the rd from both execute and memory?
input [3:0] new_rs1;
input [3:0] new_rs2;
input [3:0] old_inst_op;
input [3:0] old_exe_rd
input [3:0] old_mem_rd;
input old_aluin1;
input [1:0] old_aluin2;
input [15:0] memout;
input [15:0] aluout;

output reg [15:0] forward_a;
output reg [15:0] forward_b;
output reg [1:0] new_alusrc1;
output reg [1:0] new_alusrc2;

always @(*)
begin
if (old_inst_op == 4'b1001) begin
    //lw logic
    if (old_mem_rd == new_rs1 && old_alusrc1 == 1) begin
        new_alusrc1 <= 2'b10;
        forward_a <= memout;
    end else begin
        new_alusrc1 <= old_alusrc1;
    end
    if (old_mem_rd == new_rs2 && old_alusrc2 == 0) begin
        new_alusrc2 <= 2'b11;
        forward_b <= memout;
    end else begin
        new_alusrc2 <= old_alusrc2;
    end
end
else begin
    if (old_exe_rd == new_rs1 && old_alusrc1 == 1) begin
        new_alusrc1 <= 2'b10;
        forward_a <= aluout;
    end else begin
        new_alusrc1 <= old_alusrc1;
    end
    if (old_exe_rd == new_rs2 && old_aluin2 == 0) begin
        new_alusrc2 <= 2'b11;
        forward_b <= aluout;
    end else begin
        new_alusrc2 <= old_alusrc2;
    end
end

end


endmodule