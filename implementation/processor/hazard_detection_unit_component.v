module hazard_detection_unit_component(clock, memread, stall, flush);

input clock;
input memread;

input instop;
input zero;

output reg stall;
output reg flush;

always @(posedge clock)
begin

    //branch/flush
    if (instop == 4'b1011 && zero == 0) begin
        flush = 1;
    end
    //lw/store
    //0 if we want to stall otherwise 1 (should mostly be 1)
    if (memread == 1) begin //check whether rd = rs1 or rs2 from prev cycle
        stall = 0;
    end else begin
        stall = 1;
    end
end



endmodule