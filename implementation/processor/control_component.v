module control_component (PCWriteCond,
    PCWrite,
    IorD,
    ALUSrcA,
    ALUSrcB,
    ALUOp,
    ImmgenOp,
    RegWrite,
    MemToReg,
    PCSrc,
    MemWrite,
    MemRead,
    current_state,
    next_state,
    CLK,
    Reset
);


// outputs
output PCWriteCond;
output PCWrite;
output IorD;
output ALUSrcA;
output [1:0] ALUSrcB;
output ALUOp;
output [1:0] ImmgenOp;
output RegWrite;
output MemToReg;
output PCSrc;
output MemWrite;
output MemRead;

output [3:0] current_state;
output [3:0] next_state;

//inputs
input [3:0]  Opcode;
input        CLK;
input        Reset;

//wires for internal
reg PCWriteCond;
reg PCWrite;
reg IorD;
reg ALUSrcA;
reg [1:0] ALUSrcB;
reg ALUOp;
reg [1:0] ImmgenOp;
reg RegWrite;
reg MemToReg;
reg PCSrc;
reg MemWrite;
reg MemRead;

//state flip-flops
reg [3:0]    current_state;
reg [3:0]    next_state;

//state definitions
//common steps
parameter    Fetch = 0;
parameter    Decode = 1;
//r-type (nonbranching)
parameter R_E_A = 2;
parameter R_E_SEG = 3
parameter R_W_AS = 4;
parameter R_W_G = 5;
parameter R_W_E = 6;
//r-type (branching)
parameter R_E_J = 7;
parameter R_E_Jal = 8;
parameter R_E_Jalr = 9;
parameter R_W_J = 10;

//register calculation
always @ (posedge CLK, posedge Reset)
begin
    if (Reset)
        current_state = Fetch;
    else 
        current_state = next_state;
end


//OUTPUT signals for each state (depends on current state)
always @ (current_state)
begin
    //Reset all signals
    PCWriteCond = 0;
    PCWrite = 0;
    IorD = 0;
    ALUSrcA = 0; //0 = PC, 1 = A
    ALUSrcB = 2'b00; //0 = B, 1 = 2, 2 = imm
    ALUOp = 0; //0 = "+", 1 = "-"
    ImmgenOp =  2'b00; //0 = shift by left 1, 1 = shift by 8, 2 = sign extend
    RegWrite = 0;
    MemToReg = 0; //0 = aluout, 1 = mdr, 2 = zero, 3 = pos
    PCSrc = 0;
    MemWrite = 0;
    MemRead = 0;

    case (current_state)

        Fetch:
        begin
            MemRead = 1;
            IRWrite =  1;
            ALUSrcB = 1;
            PCWrite = 1;
        end 

        Decode:
        begin
            //just grabbing A and B
        end

        R_E_A:
        begin
            ALUSrcA = 1;
            //just adding (TODO: double check)
        end

        R_E_SEG:
        begin
            ALUOp = 1;
            ALUSrcA = 1;
        end
        R_W_AS:
        begin
            IRWrite = 1;
        end
        R_W_G:
        begin
            IRWrite = 1;
            MemToReg = 3;
        end

        R_W_E:
        begin
            IRWrite = 1;
            MemToReg = 2;
        end

        R_E_J:
        begin
            //Defaults are all correct
        end
        R_E_Jal:
        begin
            IRWrite = 1;
            ALUSrcB = 2;
            ALUSrcA = 1;
        end

        R_E_Jalr:
        begin
            IRWrite = 1;
        end

        R_W_J:
        begin
            PCWrite = 1
        end
        default:
        begin $display ("not implemented"); end
    endcase
end

//NEXT STATE calculation (depends on current state and opcode)       
always @ (current_state, next_state, Opcode)
begin         

$display("The current state is %d", current_state);

case (current_state)

    Fetch:
    begin
        next_state = Decode;
        $display("In Fetch, the next_state is %d", next_state);
    end

    Decode: 
    begin       
    $display("The opcode is %d", Opcode);
    case (Opcode)
        0:
        begin
            next_state = R_E_A;
        end
        1:
        begin
            next_state = R_E_SEG;
        end
        2:
        begin
            next_state = R_E_SEG;
        end
        3:
        begin
            next_state = R_E_SEG;
        end
        1:
        begin
            next_state = R_E_J;
        end
        default:
        begin 
        $display(" Wrong Opcode :( %d ", Opcode);  
        next_state = Fetch; 
    end
endcase  

$display("In Decode, the next_state is %d", next_state);
            end

            R_E_A:
            begin
                next_state = R_W_AS;
            end

            R_E_SEG:
            begin
                case (Opcode)
                    1:
                    begin
                        next_state = R_W_G;
                    end
                    2:
                    begin
                        next_state = R_W_AS;
                    end
                    3:
                    begin
                        next_state = R_W_E;
                    end               
                endcase

            end


            R_W_AS:
            begin
                next_state = Fetch;
            end

            R_W_G:
            begin
                next_state = Fetch;
            end

            R_W_E:
            begin
                next_state = Fetch;
            end

            R_E_J:
            begin
                case (Opcode)
                    6:
                    begin
                        next_state = R_E_Jal;
                    end
                    4:
                    begin
                        next_state = R_E_Jalr;
                    end
                endcase
            end

            R_E_Jal:
            begin
                next_state = R_W_J;
            end

            R_E_Jalr:
            begin
                next_state = R_W_J;
            end

            R_W_J:
            begin
                next_state = Fetch;
            end



            default:
            begin
                $display("Not implemented!");
                next_state = Fetch;
            end

        endcase

        $display("After the tests, the next_state is %d", next_state);

    end

    endmodule
