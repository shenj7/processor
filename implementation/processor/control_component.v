//control
module control_component(op, reset, IMMGENOP, ALUOP, ALUIN1, ALUIN2, ALUSRC, MEMREAD, MEMWRITE, PCWRITE,REGWRITE, MEM2REG);

input[3:0] op;
input reset;

output reg [1:0] IMMGENOP; //can get rid of all immgenops later - just pass in entire inst to immgen
output reg ALUOP;
output reg ALUIN1;
output reg [1:0] ALUIN2;
output reg [1:0] ALUSRC;
output reg MEMREAD;
output reg MEMWRITE;
output reg PCWRITE;
output reg MEM2REG;
output reg REGWRITE;

 always @(*)  
 begin  
      if(reset == 1'b1) begin  
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b0;  
                ALUIN1 <= 1'b0;  
                ALUIN2 <= 2'b00;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;   
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b0;
      end  
      else begin  
      case(op)   
      4'b0000: begin // add  
                 IMMGENOP <= 2'b00;  
                ALUOP <= 1'b0;  
                ALUIN1 <= 1'b0;  
                ALUIN2 <= 2'b00;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;   
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end  
     4'b0010: begin // sub  
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b1;  
                ALUIN1 <= 1'b0;  
                ALUIN2 <= 2'b00;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;  
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end 
      4'b0001: begin // grt 
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b1;  
                ALUIN1 <= 1'b0;  
                ALUIN2 <= 2'b00;  
                ALUSRC <= 2'b10;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0; 
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end   
      4'b0011: begin // eq  
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b1;  
                ALUIN1 <= 1'b0;  
                ALUIN2 <= 2'b00;  
                ALUSRC <= 2'b11;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;   
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end  
     4'b0110: begin // jal
                IMMGENOP <= 2'b10;  
                ALUOP <= 1'b0;  
                ALUIN1 <= 1'b1;  
                ALUIN2 <= 2'b10;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b1;  
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end  
      4'b0100: begin // jalr 
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b0;  
                ALUIN1 <= 1'b1;  
                ALUIN2 <= 2'b01;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b1;  
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b0;
                end  
      4'b1000: begin // addi  
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b0;  
                ALUIN1 <= 1'b0;  
                ALUIN2 <= 2'b10;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;   
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end  
      4'b0101: begin // lui  
                IMMGENOP <= 2'b11;  
                ALUOP <= 1'b1;  
                ALUIN1 <= 2'b11;  
                ALUIN2 <= 2'b10;  
                ALUSRC <= 2'b01;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;  
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end  
      4'b1111: begin // lli  
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b1;  
                ALUIN1 <= 2'b11;  
                ALUIN2 <= 2'b10;  
                ALUSRC <= 2'b01;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;  
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b1;
                end  
     4'b1001: begin // lw  
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b0;  
                ALUIN1 <= 1'b1;  
                ALUIN2 <= 2'b10;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b1;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b0;   
                MEM2REG <= 1'b1;
                REGWRITE <= 1'b1;
                end  
     4'b1010: begin // sw  
                IMMGENOP <= 2'b00;  
                ALUOP <= 1'b0;  
                ALUIN1 <= 1'b1;  
                ALUIN2 <= 2'b10;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b1;  
                PCWRITE <= 1'b1;   
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b0;
                end  
       default: begin // bne  
                IMMGENOP <= 2'b10;  
                ALUOP <= 1'b1;  
                ALUIN1 <= 1'b1;  
                ALUIN2 <= 2'b00;  
                ALUSRC <= 2'b00;  
                MEMREAD <= 1'b0;  
                MEMWRITE <= 1'b0;  
                PCWRITE <= 1'b1;   
                MEM2REG <= 1'b0;
                REGWRITE <= 1'b0;
                end  
      endcase  
      end  
 end  
 endmodule  



