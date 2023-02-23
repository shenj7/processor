module hazard_detection_unit_component(clock, memread, rs1, rs2, rs2, instop, zero, stall, branch_taken, pcwrite);

input clock;
input memread;
input [3:0] rs1;
input [3:0] rs2;

input zero;
input pcwrite;
input [3:0] instop;


output reg stall;
output reg branch_taken;
reg stalled;


initial begin 
    stalled <= 0;
end

always @(posedge clock)
begin
    //use rs1 and rs2 to determine whether we need to flush or not
    if(!zero && pcwrite) begin
        branch_taken <= 1;
    end else if (instop == 4'b0100 || instop == 4'b0110) begin
      branch_taken <= 1;
    end else begin
        branch_taken <= 0;
    end

    if (memread == 1) begin //check whether rd = rs1 or rs2 from prev cycle
        //$display("shold not stall >:(");
        stall <= 0; // if stall == 0, then stall else don't
    end else begin
        stall <= 1;
    end
end



endmodule