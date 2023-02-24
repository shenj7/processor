module single_cycle_control_component(op, reset, ALUOP, ALUSRC, REGWRITE, MEMREAD, MEMWRITE, PCSRC, MEM2REG);

input[3:0] op;
input reset;

output reg ALUOP;
output reg ALUSRC;
output reg REGWRITE;
output reg MEMREAD;
output reg MEMWRITE;
output reg PCSRC;
output reg MEM2REG;

always @(*)  
 begin  
     //no more reset  
      case(op)   
      4'b0000: begin // add  
        //1 = add, 0 = sub  
        ALUOP <= 1'b1;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
     4'b0010: begin // sub  
        //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end 
      4'b0001: begin // grt LOOK HERE
        //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end   
      4'b0011: begin // eq  LOOK HERE
        //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <=1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <=1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
     4'b0110: begin // jal
        //1 = add, 0 = sub  
        ALUOP <= 1'b1;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b1;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
      4'b0100: begin // jalr 
        //1 = add, 0 = sub  
        ALUOP <= 1'b1;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b1;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b1;
        // 1 = yes, 0 = no
        MEM2REG <=1'b0;
        end  
      4'b1000: begin // addi  
        //1 = add, 0 = sub  
        ALUOP <= 1'b1;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b1;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
      4'b0101: begin // lui  
         //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b1;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
     4'b1001: begin // lw  
        //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b1;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b1;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b1;
        // 1 = yes, 0 = no
        MEMWRITE <=1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
     4'b1010: begin // sw  
         //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b1;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b0;
        // 1 = yes, 0 = no
        MEMREAD <=1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <=1'b1;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0 ;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b1;
        end  
     4'b1011: begin // bne  
        //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b0;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b1;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
     4'b1100: begin // wri  
         //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <=  1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b0;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b0;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b1;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end    
      default: begin  //rea
        //1 = add, 0 = sub  
        ALUOP <= 1'b0;
        // 1 = imm, 0 = rs2
        ALUSRC <= 1'b0;
        // 1 = yes, 0 = no
        REGWRITE <= 1'b0;
        // 1 = yes, 0 = no
        MEMREAD <= 1'b1;
        // 1 = yes, 0 = no
        MEMWRITE <= 1'b0;
        // 1 = branch, 0 = normal + 2
        PCSRC <= 1'b0;
        // 1 = yes, 0 = no
        MEM2REG <= 1'b0;
        end  
      endcase   
 end   
endmodule