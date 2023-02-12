module connected_control_memory_component
(
    CLK,
    PC,
    datain,
    IMMGENOP,
    ALUOP,
    ALUIN1,
    ALUIN2, 
    ALUSRC,
    MemRead,
    MemWrite,
    PCWrite
);


output IMMGENOP;
output ALUOP;
output ALUIN1;
output ALUIN2;
output [1:0] ALUSRC;
output MemRead;
output MemWrite;
output PCWrite;

input CLK;
input [15:0] PC;
input [15:0] datain;

wire IMMGENOP;
wire ALUOP;
wire ALUIN1;
wire ALUIN2;
wire [1:0] ALUSRC;
wire MemRead;
wire MemWrite;
wire PCWrite;

wire [15:0] inst;

load_store_control ctrl (
    .OP(inst[3:0]),
    .CLK(CLK),
    .Reset(1'b0),
    .IMMGENOP(IMMGENOP),
    .ALUOP(ALUOP),
    .ALUIN1(ALUIN1),
    .ALUIN2(ALUIN2),
    .ALUSRC(ALUSRC),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .PCWrite(PCWrite)
);

memory mem (
    .data(datain),
    .addr(PC),
    .we(MemWrite),
    .clk(CLK),
    .q(inst)
);


always @ (posedge CLK)
begin
    $display("Reading from pc = %d", PC);
    $display("instruction: %d", inst);

end

endmodule