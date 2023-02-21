module bingle_bicle(clock, read_in, rst, write_out);

input clock;
input [15:0] read_in;
input rst;

output [15:0] write_out;

parameter HALF_PERIOD = 50;


//main pc
wire [15:0] pcin;
wire [15:0] pcout;

reg_component pcmain (
    //inputs
    .clock(clock),
    .in(pcin),
    .write(1),
    .reset(rst),

    //outputs
    .out(pcout)
);

//pc incrementer
wire [15:0] newpc;
alu_component pcinc (
    //inputs
    .inst_id(4'b0000),
    .in0(pcout),
    .in1(2),
    .reset(rst),

    //outputs
    .out(newpc),
    .zero(),
    .pos()
);


//inst memory
wire [15:0] inst;
inst_mem_component inst_mem (
    //inputs
    .addr(pcout[8:0]),
    .clk(clock),

    //outputs
    .out(inst)
);

//control
wire aluop;
wire alusrc;
wire regwrite;
wire memread; //?
wire memwrite;
wire branch;
wire mem2reg;

single_cycle_control_component control (
    .op(inst[3:0]),
    .reset(0),
    .ALUOP(aluop),
    .ALUSRC(alusrc),
    .REGWRITE(regwrite),
    .MEMREAD(memread),
    .MEMWRITE(memwrite),
    .PCSRC(branch),
    .MEM2REG(mem2reg)
);

//reg file component
wire [15:0] reg1;
wire [15:0] reg2;
wire [15:0] writedata;
reg_file_component reg_file (
    //inputs
    .clock(clock),
    .rs1(inst[11:8]),
    .rs2(inst[15:12]),
    .rd(inst[7:4]),
    .writedata(writedata), 
    .reset(rst),

    //controls
    .write(regwrite),

    //outputs
    .reg1(reg1),
    .reg2(reg2)
);


//imm gen
wire [15:0] immgen_out;
imm_gen_component imm_gen (
    .clock(clock),
    .inst(inst), //TODO: might need to make a single-cyle immgen component
    .reset(rst),

    //outputs
    .out(immgen_out)
);


//aluin1 selector
wire [15:0] aluin1;
two_way_mux_component aluin1selector (
    //inputs
    .in0(reg2),
    .in1(immgen_out), //TODO: from inngen
    .op(alusrc),
    .reset(rst),

    //outputs
    .out(aluin1)
);

//main alu
wire aluzero;
wire [15:0] aluout;
alu_component mainalu (
    //inputs
    .inst_id({{3{0}}, aluop}), //TODO from alu control
    .in0(reg1),
    .in1(aluin1),
    .reset(rst),

    //outputs
    .out(aluout),
    .zero(aluzero),
    .pos()
);


//data mem
wire [15:0] memout;
data_mem_component data_mem (
    //inputs
    .writedata(reg2),
    .addr(aluout),
    .write(memwrite), 
    .clk(clock),
    .read_in(read_in),

    //outputs
    .write_out(write_out),
    .out(memout)
);


//writedata selector
two_way_mux_component rf_writedata (
    //inputs
    .in0(aluou),
    .in1(memout),
    .op(mem2reg),
    .reset(rst),

    //outputs
    .out(writedata)
);

//branching
wire branch_taken;
assign branch_taken = branch && aluzero;
wire [15:0] branch_address;

assign branch_address = reg2;

// alu_component branch_alu (
//     //inputs
//     .inst_id(4'b0000),
//     .in0(pcout),
//     .in1(reg2), //TODO: new address - discuss how to deal with branches
//     .reset(0),
    
//     //outputs
//     .out(branch_address),
//     .zero(),
//     .pos()
// );

two_way_mux_component branch_selector (
    //inputs
    .in0(newpc),
    .in1(branch_address),
    .op(branch_taken),
    .reset(rst),

    //outputs
    .out(pcin)
);

always @(posedge clock)
begin
    $display("curr pc: %d", pcout);
    $display("newpc: %d", newpc);
    $display("pcin: %d", pcin);

end

endmodule