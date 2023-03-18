module control_component (PCWriteCond,
    PCWrite,
    IorD,
    ALUSrcA,
    ALUSrcB,
    ALUOp,
    RegWrite,
    MemToReg,
    PCSrc,
    MemWrite,
    MemRead,
    IRWrite,
    inst,
    CLK,
    Reset
);


// outputs
output PCWriteCond; //we know what do :)
output PCWrite;
output IorD;
output [1:0] ALUSrcA;
output [1:0] ALUSrcB;
output ALUOp;
output RegWrite;
output [1:0] MemToReg;
output PCSrc;
output MemWrite;
output MemRead;
output IRWrite;

//inputs
input [15:0]  inst;
input        CLK;
input        Reset;

//wires for internal
reg PCWriteCond;
reg PCWrite;
reg IorD;
reg [1:0] ALUSrcA;
reg [1:0] ALUSrcB;
reg ALUOp;
reg RegWrite;
reg [1:0] MemToReg;
reg PCSrc;
reg MemWrite;
reg MemRead;
reg [3:0] Opcode;
reg IRWrite;

//state flip-flops
reg [8:0]    current_state;
reg [8:0]    next_state;

//state definitions
//common steps
parameter    Fetch = 0;
parameter    Decode = 1;
//r-type (nonbranching)
parameter R_E_A = 2;
parameter R_E_SEG = 3;
parameter R_W_AS = 4;
parameter R_W_G = 5;
parameter R_W_E = 6;
//r-type (branching)
parameter R_E_J = 7;
parameter R_E_Jal = 8;
parameter R_E_Jalr = 9;
parameter R_W_J = 10;

//m-type instructions
parameter M_C = 11;
parameter M_Lw_1 = 12;
parameter M_Lw_2 = 13;
parameter M_Addi = 14;
parameter M_Sw = 15;

//i-type instructions
parameter I_Bne = 16;
parameter I_Lui = 17;
parameter I_Lli = 18;
parameter I_LIW = 19;
parameter I_Bne_2 = 20;
parameter I_Bne_3 = 21;

//register calculation
always @ (posedge CLK)
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
    ALUSrcA = 2'b00; //0 = PC, 1 = A
    ALUSrcB = 2'b00; //0 = B, 1 = 2, 2 = imm
    ALUOp = 0; //0 = "+", 1 = "-"
    RegWrite = 0;
    MemToReg = 2'b00; //0 = aluout, 1 = mdr, 2 = zero, 3 = pos
    PCSrc = 0;
    MemWrite = 0;
    MemRead = 0;
    IRWrite = 0;


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
            RegWrite = 1;
        end
        R_W_G:
        begin
            RegWrite = 1;
            MemToReg = 3;
        end

        R_W_E:
        begin
            RegWrite = 1;
            MemToReg = 2;
        end

        R_E_J:
        begin
            //Defaults are all correct
        end
        R_E_Jalr:
        begin
            RegWrite = 1;
        end

        R_W_J:
        begin
            PCWrite = 1;
            PCSrc = 0;
            ALUSrcA = 1;
            ALUSrcB = 3;
            RegWrite = 1;
        end
     
        M_C:
        begin
            ALUSrcA = 1;
            ALUSrcB = 2;
        end

        M_Lw_1:
        begin
            IorD = 1;
            MemRead = 1;
        end

        M_Lw_2:
        begin
            MemToReg = 1;
            RegWrite = 1;
        end
        // M_Lw_1:
        // begin
        //     IorD = 1;
        //     MemRead = 1;
        // end

        // M_Lw_2:
        // begin
        //     MemToReg = 1;
        // end

		M_Addi:
        begin
            RegWrite = 1;
        end

		M_Sw:
        begin
            IorD = 1;
            MemWrite = 1;
        end

		I_Bne:
		begin
			ALUSrcA = 1;
			ALUOp = 1;
		end

        I_Bne_2:
        begin
            ALUSrcA = 3;
            ALUSrcB = 3;
        end

        I_Bne_3:
        begin
            PCSrc = 1;
            PCWriteCond = 1;
        end

		I_Lui:
		begin
			ALUSrcA = 2;
			ALUSrcB = 2;
		end

		I_Lli:
		begin
			ALUSrcA = 2;
			ALUSrcB = 2;
		end

        I_LIW:
        begin
            RegWrite = 1;
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
            4:
            begin
                next_state = R_E_J;
            end
			5:
			begin
				next_state = I_Lui;
			end
            6:
            begin
                next_state = R_E_J;
            end

            8:
            begin
                next_state = M_C;
            end

            9:
            begin
                next_state = M_C;
            end

            10:
            begin
                next_state = M_C;
            end

			11:
			begin
				next_state = I_Bne;
			end

			15:
			begin
				next_state = I_Lli;
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

    M_C:
    begin
        case (Opcode)
            8:
            begin
                next_state = M_Addi;
            end
            9:
            begin
                next_state = M_Lw_1;
            end
            10:
            begin
                next_state = M_Sw;
            end
        endcase

    end

    M_Lw_1:
    begin
        next_state = M_Lw_2;
    end

    M_Lw_2:
    begin
        next_state = Fetch;
    end

    M_Addi:
    begin
        next_state = Fetch;
    end
	
	M_Sw:
	begin
		next_state = Fetch;
	end

    I_Lui:
    begin
        next_state = I_LIW;
    end

    I_Lli:
    begin
        next_state = I_LIW;
    end

    I_LIW:
    begin
        next_state = Fetch;
    end

    I_Bne:
    begin
        next_state = I_Bne_2;
    end

    I_Bne_2:
    begin
        next_state = I_Bne_3;
    end

    I_Bne_3:
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

    always @(inst) begin
        Opcode = inst[3:0];
    end

    endmodule
