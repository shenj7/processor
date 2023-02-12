module connected_control_memory_tb();

//inputs
reg CLK;
reg [15:0] PC;
reg [15:0] datain;

//outputs
wire IMMGENOP;
wire ALUOP;
wire ALUIN1;
wire ALUIN2;
wire [1:0] ALUSRC;
wire MemRead;
wire MemWrite;
wire PCWrite;

parameter HALF_PERIOD=50;

initial begin
    CLK = 0;
    forever begin
        #(HALF_PERIOD);
        CLK = ~CLK;
    end
end 

connected_control_memory_component UUT(
    .CLK(CLK),
    .PC(PC),
    .datain(datain),
    .IMMGENOP(IMMGENOP),
    .ALUOP(ALUOP),
    .ALUIN1(ALUIN1),
    .ALUIN2(ALUIN2),
    .ALUSRC(ALUSRC),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .PCWrite(PCWrite)
);

initial begin
    CLK = 0;
    PC = 0;
    datain = 0;

    #(4*HALF_PERIOD);
    PC = 'h0000;

    #(4*HALF_PERIOD);
    PC = 'h0001;

    #(4*HALF_PERIOD);
    PC = 'h0002;
    
    #(4*HALF_PERIOD);
    PC = 'h0003;

    #(4*HALF_PERIOD);
    PC = 'h0004;

    #(4*HALF_PERIOD);
    PC = 'h0005;

    #(4*HALF_PERIOD);
    PC = 'h0006;

    #(4*HALF_PERIOD);
    PC = 'h0007;

    #(4*HALF_PERIOD);
    PC = 'h0008;

    #(4*HALF_PERIOD);
    PC = 'h0009;

    #(4*HALF_PERIOD);
    PC = 'h000a;

    #(4*HALF_PERIOD);
    PC = 'h000b;

    #(4*HALF_PERIOD);
    PC = 'h000c;

    #(4*HALF_PERIOD);
    PC = 'h000d;

    #(4*HALF_PERIOD);


    $stop;


end


endmodule