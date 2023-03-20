module delay_component (should_branch, clock, rst, branch_out);

input should_branch;
input clock;
input rst;

output branch_out;

wire branch_inter;

little_reg_component lr1 (
    .in(should_branch),
    .out(branch_inter),
    .clock(clock),
    .write(1),
    .reset(rst)
);

little_reg_component lr2 (
    .in(branch_inter),
    .out(branch_out),
    .clock(clock),
    .write(1),
    .reset(rst)
);


always @(posedge clock)
begin
end
endmodule