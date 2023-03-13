module load_store(clock, read_in, rst, write_out);
    //inputs
    input clock;
    input [15:0] read_in;
    input rst;

    //internal wires
    wire [15:0] pc_alusrca;
    wire [15:0] pc_pc2mem;
    wire [15:0] pc2mem_mem;
    wire [15:0] mem_ir;
    wire [3:0] ir_rs1_reg;
    wire [3:0] ir_rs2_reg;
    wire [3:0] ir_rd_reg;
    wire [15:0] ir_immgen;
    wire [15:0] mem_mdr;
    wire [15:0] mdr_reg_in;
    wire [15:0] reg_a;
    wire [15:0] reg_b;
    wire [15:0] a_alusrc1;
    wire [15:0] b_alusrc2;
    wire [15:0] immgen_alusrc2;
    wire [15:0] alusrc1_alu;
    wire [15:0] alusrc2_alu;    
    wire [15:0] alu_aluout;
    wire alu_zero;
    wire alu_pos;
    wire [15:0] aluout_pcsrc;

    //control wires
    wire pcwrite;
    wire iord;
    wire alusrca;
    wire alusrcb;
    wire aluop;
    wire regwrite;
    wire memtoreg;
    wire pcsrc;
    wire memwrite;

    //outputs
    output write_out;


    //control
    control_component control (
        .PCWrite(),
        .IorD(),
        .ALUSrcA(),
        .ALUSrcB(),
        .ALUOp(),
        .RegWrite(),
        .MemToReg(),
        .PCSrc(),
        .MemWrite(),
        .current_state(),
        .next_state(),
        .CLK(clock),
        .Reset(rst)
    );

    //components

    reg_component pc_reg (
        .clock(clock),
        .in(),
        .write(),
        .reset(),
        .out()
    );

    two_way_mux_component pc_to_mem_mux (
        .in0(),
        .in1(),
        .op(iord),
        .reset(),
        .out(),
    );
    
    mem_component memory (
        .writedata(),
        .addr(),
        .write(memwrite),
        .clk(clock),
        .read_in(),
        .write_out(),
        .out()
    );

    ir_component ir (
        .in1(),
        .reset(),
        .rs1(),
        .rs2(),
        .rd()
    );

    reg_component mem_data_reg (
        .clock(clock),
        .in(),
        .write(),
        .reset(),
        .out()
    );

    four_way_mux_component reg_in (
        .in0(),
        .in1(),
        .in2(),
        .in3(),
        .op(memtoreg),
        .reset(),
        .out(),
    );
    
    reg_file_component reg_file (
        .clock(clock),
        .rs1(),
        .rs2(),
        .rd(),
        .currd(),
        .writedata(),
        .reset(),
        .write(regwrite),
        .reg1(),
        .reg2()
    );
    

    reg_component a_reg (
        .clock(clock),
        .in(),
        .write(),
        .reset(),
        .out()
    );


    reg_component b_reg (
        .clock(clock),
        .in(),
        .write(),
        .reset(),
        .out()
    );
    
    imm_gen_component imm_gen ( // TODO: fix component
        .inst(),
        .reset(),
        .out()
    );

    four_way_mux_component alusrc1_alu (
        .in0(),
        .in1(),
        .in2(),
        .in3(),
        .op(alusrca),
        .reset(),
        .out(),
    );

    four_way_mux_component alusrc2_mux (
        .in0(),
        .in1(2),
        .in2(),
        .in3(),
        .op(alusrcb),
        .reset(),
        .out(),
    );
    
    alu_component alu(
        .inst_id(aluop), 
        .in0(), 
        .in1(), 
        .reset(),
        .out(), 
        .zero(), 
        .pos()
    );


    reg_component aluout_reg (
        .clock(clock),
        .in(),
        .write(),
        .reset(),
        .out()
    );
    

    two_way_mux_component pcsrc_mux (
        .in0(),
        .in1(),
        .op(pcsrc),
        .reset(),
        .out(),
    );


    always @(posedge clock)
    begin

    end
    
endmodule