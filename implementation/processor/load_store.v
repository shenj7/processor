module load_store(clock, read_in, rst, write_out);
    //inputs
    input clock;
    input [15:0] read_in;
    input rst;

    //internal wires
    wire [15:0] pc_pc2mem;
    wire [15:0] pc2mem_mem;
    wire [15:0] mem_ir;
    wire [3:0] ir_rs1_reg;
    wire [3:0] ir_rs2_reg;
    wire [3:0] ir_rd_reg;
    wire [15:0] ir_inst;
    wire [15:0] mdr_reg_in;
    wire [15:0] regwrite_in;
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
    wire [15:0] pcsrcout_pc;

    //control wires
    wire pcwrite;
    wire iord;
    wire [1:0] alusrca;
    wire [1:0] alusrcb;
    wire aluop;
    wire regwrite;
    wire memtoreg;
    wire pcsrc;
    wire memwrite;
    wire memread;
    wire irwrite;

    //outputs
    output [15:0] write_out;


    //control
    control_component control (
        .inst(ir_inst),
        .PCWrite(pcwrite),
        .IorD(iord),
        .ALUSrcA(alusrca),
        .ALUSrcB(alusrcb),
        .ALUOp(aluop),
        .RegWrite(regwrite),
        .MemToReg(memtoreg),
        .PCSrc(pcsrc),
        .MemWrite(memwrite),
        .MemRead(memread),
        .IRWrite(irwrite),
        .CLK(clock),
        .Reset(rst)
    );

    //components

    reg_component pc_reg (
        .clock(clock),
        .in(pcsrcout_pc),
        .write(),
        .reset(rst),
        .out(pc_pc2mem)
    );

    two_way_mux_component pc_to_mem_mux (
        .in0(pc_pc2mem),
        .in1(aluout_pcsrc),
        .op(iord),
        .reset(rst),
        .out(pc2mem_mem)
    );
    
    mem_component memory (
        .writedata(b_alusrc2),
        .addr(pc2mem_mem),
        .write(memwrite),
        .read(memread),
        .clk(clock),
        .read_in(read_in),
        .write_out(write_out),
        .out(mem_ir)
    );

    ir_component ir (
        .in1(mem_ir),
        .inst(ir_inst),
        .write(irwrite),
        .reset(rst),
        .rs1(ir_rs1_reg),
        .rs2(ir_rs2_reg),
        .rd(ir_rd_reg)
    );

    reg_component mem_data_reg (
        .clock(clock),
        .in(mem_ir),
        .write(1),
        .reset(rst),
        .out(mdr_reg_in)
    );

    four_way_mux_component reg_in (
        .in0(aluout_pcsrc),
        .in1(mdr_reg_in),
        .in2(alu_zero),
        .in3(alu_pos),
        .op(memtoreg),
        .reset(rst),
        .out(regwrite_in)
    );
    
    reg_file_component reg_file (
        .clock(clock),
        .rs1(ir_rs1_reg),
        .rs2(ir_rs2_reg),
        .rd(ir_rd_reg),
        .writedata(regwrite_in),
        .reset(rst),
        .write(regwrite),
        .reg1(reg_a),
        .reg2(reg_b)
    );
    

    reg_component a_reg (
        .clock(clock),
        .in(reg_a),
        .write(1),
        .reset(rst),
        .out(a_alusrc1)
    );


    reg_component b_reg (
        .clock(clock),
        .in(reg_b),
        .write(1),
        .reset(rst),
        .out(b_alusrc2)
    );
    
    imm_gen_component imm_gen (
        .inst(ir_inst),
        .reset(rst),
        .out(immgen_alusrc2)
    );

    four_way_mux_component alusrc1_mux (
        .in0(pc_pc2mem),
        .in1(a_alusrc1),
        .in2(0),
        .in3(0),
        .op(alusrca),
        .reset(rst),
        .out(alusrc1_alu)
    );

    four_way_mux_component alusrc2_mux (
        .in0(b_alusrc2),
        .in1(2),
        .in2(immgen_alusrc2),
        .in3(0),
        .op(alusrcb),
        .reset(rst),
        .out(alusrc2_alu)
    );
    
    alu_component alu(
        .inst_id(aluop), 
        .in0(alusrc1_alu), 
        .in1(alusrc2_alu), 
        .reset(rst),
        .out(alu_aluout), 
        .zero(alu_zero), 
        .pos(alu_pos)
    );


    reg_component aluout_reg (
        .clock(clock),
        .in(alu_aluout),
        .write(1),
        .reset(rst),
        .out(aluout_pcsrc)
    );
    

    two_way_mux_component pcsrc_mux (
        .in0(alu_aluout),
        .in1(aluout_pcsrc),
        .op(pcsrc),
        .reset(rst),
        .out(pcsrcout_pc)
    );


    always @(posedge clock)
    begin

    end
    
endmodule