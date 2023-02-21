module hazard_detection_unit_component(clock, memread, instop, zero, stall, flush);

input clock;
input memread;

input instop;
input zero;

output reg stall;
output reg flush;
reg stalled;

initial begin 
    stalled <= 0;
end

always @(posedge clock)
begin

    //branch/flush
    if (instop == 4'b1011 && zero == 0) begin
        flush <= 1;
    end
    //lw/store
    //0 if we want to stall otherwise 1 (should mostly be 1)
    $display("memread: %d", memread);
    $display("stalled: %d", stalled);
    if (memread == 1) begin //check whether rd = rs1 or rs2 from prev cycle
        $display("shold not stall >:(");
        stall <= 0; // if stall == 0, then stall else don't
    end else begin
        stall <= 1;
    end
end



endmodule