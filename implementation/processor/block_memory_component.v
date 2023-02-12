module load_store_control (
    OP,
    CLK,
    Reset,
    IMMGENOP,
    ALUOP,
    ALUIN1,
    ALUIN2, 
    ALUSRC,
    MemRead, // we possibly don't need a memread
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

input [3:0] OP;
input CLK;
input Reset;

reg IMMGENOP;
reg ALUOP;
reg ALUIN1;
reg ALUIN2;
reg [1:0] ALUSRC;
reg MemRead;
reg MemWrite;
reg PCWrite;


always @ (posedge CLK)
begin      
$display("The opcode is %d", OP);
case (OP)
    4'b0000:
    begin
        $display("add");
        IMMGENOP = 0;
        ALUOP = 0;
        ALUIN1 = 0;
        ALUIN2 = 0;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b0001:
    begin
        $display("grt");
        IMMGENOP = 0;
        ALUOP = 1;
        ALUIN1 = 0;
        ALUIN2 = 0;
        ALUSRC = 1;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b0010:
    begin
        $display("sub");
        IMMGENOP = 0;
        ALUOP = 1;
        ALUIN1 = 0;
        ALUIN2 = 0;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b0011:
    begin
        $display("eq");
        IMMGENOP = 0;
        ALUOP = 1;
        ALUIN1 = 0;
        ALUIN2 = 0;
        ALUSRC = 2;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b0100:
    begin
        $display("jalr");
        IMMGENOP = 0;
        ALUOP = 0;
        ALUIN1 = 1;
        ALUIN2 = 1;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 1;
    end
    4'b0101:
    begin
        $display("lui");
        IMMGENOP = 3;
        ALUOP = 1;
        ALUIN1 = 0;
        ALUIN2 = 2;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b0110:
    begin
        $display("jal");
        IMMGENOP = 2;
        ALUOP = 0;
        ALUIN1 = 1;
        ALUIN2 = 2;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b1000:
    begin
        $display("addi");
        IMMGENOP = 0;
        ALUOP = 0;
        ALUIN1 = 0;
        ALUIN2 = 2;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b1001:
    begin
        $display("lw");
        IMMGENOP = 0;
        ALUOP = 0;
        ALUIN1 = 0;
        ALUIN2 = 2;
        ALUSRC = 0;
        MemRead = 1;
        MemWrite = 0;
        PCWrite = 0;
    end
    4'b1010:
    begin
        $display("sw");
        IMMGENOP = 0;
        ALUOP = 0;
        ALUIN1 = 0;
        ALUIN2 = 2;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 1;
        PCWrite = 0;
    end
    4'b1011:
    begin
        $display("bne"); // AHHH
        IMMGENOP = 2;
        ALUOP = 1;
        ALUIN1 = 1;
        ALUIN2 = 0;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 0;
        PCWrite = 1;
    end
    4'b1100:
    begin
        $display("wri");
        IMMGENOP = 0;
        ALUOP = 1;
        ALUIN1 = 0;
        ALUIN2 = 0;
        ALUSRC = 0;
        MemRead = 0;
        MemWrite = 1;
        PCWrite = 0;
    end
    4'b1101:
    begin
        $display("rea");
        IMMGENOP = 0;
        ALUOP = 1;
        ALUIN1 = 0;
        ALUIN2 = 0;
        ALUSRC = 0;
        MemRead = 1;
        MemWrite = 0;
        PCWrite = 0;
    end
    default:
    begin 
        $display(" Wrong Opcode %d ", OP);  
    end
    endcase 

end

endmodule
