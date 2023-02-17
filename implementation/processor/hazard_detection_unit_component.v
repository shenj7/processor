module hazard_detection_unit_component(clock, memread, stall);

input clock;
input memread;

output reg stall;

always @(posedge clock)
begin
    //0 if we want to stall otherwise 1 (should mostly be 1)
    if (memread == 1) begin
        stall = 0;
    end else begin
        stall = 1;
    end
end



endmodule