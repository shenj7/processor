module load_store(clock, read_in, rst, write_out);
//______________________________________________
//INPUTS/OUTPUTS
input clock;
input [15:0] read_in;
input rst;
output [15:0] write_out;
parameter HALF_PERIOD=50;
//_______________________________________________
//WIRES
//wires out of control
wire [1:0] immgenop;
wire aluop;
wire [1:0] aluin1;
wire [1:0] aluin2;
wire [1:0] alusrc; 
wire memread;
wire memwrite;
wire pcwrite;
wire regwrite; 
wire mem2reg;

//wires for hazards and forwarding
wire stall;
wire branch_taken;


//pc main stuff
wire [15:0] next_pc;
wire [15:0] chosen_pc;

//wires from forwarding
wire [15:0] newb;
wire [1:0] forwarded_alusrc0;
wire [1:0] forwarded_alusrc1;

//wires into fetch
wire [15:0] fetch_pc; 

//wires out of fetch
wire [15:0] fetch_ir;
wire [15:0] fetch_pcout;
wire [1:0] fetch_aluin1;
wire [1:0] fetch_aluin2;

//wires into decode
wire [15:0] decode_ir;
wire [15:0] decode_pc;
wire [15:0] decode_writedata;
wire [15:0] decode_rd;
wire [1:0] decode_aluin1;
wire [1:0] decode_aluin2;

//wires out of decode
wire [15:0] decode_pcout;
wire [15:0] decode_a;
wire [15:0] decode_b;
wire [15:0] decode_c;
wire [3:0] decode_rdout;
wire [15:0] decode_imm;
wire [15:0] decode_irout;
wire [1:0] decode_aluin1out;
wire [1:0] decode_aluin2out;
wire memory_regwritein;
wire rb_regwrite;

//writeback decode
wire [3:0] write_rd;

//wires into execute
wire [15:0] execute_pc;
wire [15:0] execute_a;
wire [15:0] execute_b;
wire [15:0] execute_c;
wire [3:0] execute_rd;
wire [15:0] execute_imm;
wire [15:0] execute_ir;
wire [1:0] execute_aluin1;
wire [1:0] execute_aluin2;
wire execute_regwritein;

//wires out of execute
wire [15:0] execute_bout;
wire [15:0] execute_aluout;
wire [3:0] execute_rdout;
wire execute_zero;
wire execute_pos;
wire execute_regwriteout;

//writeback 
wire [15:0] mem_aluout;
wire [15:0] intermediate_aluout;
wire execute_pcwrite;
wire [3:0] execute_opout;
wire [15:0] writeback_alufor;

wire [1:0] forward_a;
wire [1:0] forward_b;

//wires into mem
wire [15:0] mem_b;

//wires out of mem
wire [15:0] mem_memout;
wire [15:0] mem_alufor;

//memory-writeback
wire [15:0] writeback_memout;

//in-between registers
//fetch-decode
reg [15:0] inst_ir;

//_______________________________________________
//CONTROL UNITS

reg_component pcmain (
    .clock(clock), 
    .in(chosen_pc), 
    .out(fetch_pc),
    .write(stall),
    .reset(rst )
);

//control
control_component control (
    //input
    .op(fetch_ir[3:0]),
    .reset(rst),

    //output
    .IMMGENOP(immgenop),
    .ALUOP(aluop),
    .ALUIN1(aluin1),
    .ALUIN2(aluin2),
    .ALUSRC(alusrc),
    .REGWRITE(regwrite),
    .MEMREAD(memread),
    .MEMWRITE(memwrite),
    .PCWRITE(pcwrite),
    .MEM2REG(mem2reg)
);

//hazards and forwarding
hazard_detection_unit_component hazard (
    .clock(clock),
    .memread(memread),
    .pcwrite(execute_pcwrite),
    .instop(execute_opout),
    .rs1(decode_ir[11:8]),
    .rs2(decode_ir[15:12]),
    .zero(execute_zero),
    .stall(stall),
    .branch_taken(branch_taken)
);

// forward_unit_component fw (
//     .rs1(execute_ir[11:8]), // moved rs1 and rs2 one cycle forward, seems to be coming in too early
//     .rs2(execute_ir[15:12]),
//     .rd(write_rd), //mw_rd doesn't exist yet, need to move either rd or the entire inst down the pipeline
//     .oldalusrc0(execute_aluin1),
//     .oldalusrc1(execute_aluin2),
//     .alusrc0(forwarded_alusrc0),
//     .alusrc1(forwarded_alusrc1),
//     .newb(newb),
//     .shouldb(mem_aluout),
//     .originalb(execute_bout)
// );




forward_unit_component fw(
    .new_rs1(),
    .new_rs2(),
    .old_inst_op(),
    .old_exe_rd(),
    .old_mem_rd(),
    .old_aluin1(),
    .old_aluin2(),
    .memout(),
    .aluout(),
    .forward_a(),
    .forward_b(),
    .new_alusrc1(),
    .new_alusrc2()

)

//_______________________________________________
//MUXES

two_way_mux_component mw_m2r (
    .in0(writeback_alufor),
    .in1(writeback_memout),
    .op(mem2reg),
    .reset(0),
    .out(decode_writedata)
);

two_way_mux_component pcsrc (
    .in0(next_pc),
    .in1(decode_c), //execute_c
    .op(branch_taken),
    .reset(rst),
    .out(chosen_pc)
);

//_______________________________________________
//CYCLES

//fetch cycle
fetch_cycle fetch (
    //from prev cycle
    .pc(fetch_pc),
    .clk(clock),
    
    //from control
    .rst(rst),
    .pcwrite(stall),
    .aluin1(aluin1),
    .aluin2(aluin2),
    
    //output
    .aluin1out(fetch_aluin1),
    .aluin2out(fetch_aluin2),
    .ir(fetch_ir),
    .currpc(fetch_pcout),
    .newpc(next_pc)
);

fd_regs fdr (
    .fetch_aluin1(fetch_aluin1),
    .fetch_aluin2(fetch_aluin2),
    .fetch_pc(fetch_pc),
    .inst_ir(inst_ir),

    .clock(clock),
    .stall(stall),
    .rst(rst),
    .branch_taken(branch_taken),

    .decode_aluin1(decode_aluin1),
    .decode_aluin2(decode_aluin2),
    .decode_pc(decode_pc),
    .decode_ir(decode_ir)
);


decode_cycle decode (
    //from prev cycle (and writeback)
    .ir(decode_ir),
    .pc(decode_pc),
    .clk(clock),
    .writedata(decode_writedata),
    .rd(write_rd),

    //from control
    .rst(rst),
    .regwrite(wb_regwrite), //HERE
    // .aluin1(decode_aluin1), //TODO
    // .aluin2(decode_aluin2),
    .aluin1(fetch_aluin1),
    .aluin2(fetch_aluin2),

    //output
    .pcout(decode_pcout),
    .a(decode_a),
    .b(decode_b),
    .c(decode_c),
    .rdout(decode_rdout),
    .imm(decode_imm),
    .aluin1out(decode_aluin1out),
    .aluin2out(decode_aluin2out),
    .irout(decode_irout)
);

//decode-execute new nice component
de_regs der(
    .decode_regwriteout(decode_regwriteout),
    .decode_irout(decode_irout),
    .decode_pcout(decode_pcout),
    .decode_a(decode_a),
    .decode_b(decode_b),
    .decode_aluin1out(decode_aluin1out),
    .decode_aluin2out(decode_aluin2out),
    .decode_c(decode_c),
    .decode_rdout(decode_rdout),
    .decode_imm(decode_imm),

    .clock(clock),
    .stall(stall),
    .rst(rst),
    .branch_taken(branch_taken),

    .execute_regwritein(execute_regwritein),
    .execute_ir(execute_ir),
    .execute_pc(execute_pc),
    .execute_a(execute_a),
    .execute_b(execute_b),
    .execute_aluin1(execute_aluin1),
    .execute_aluin2(execute_aluin2),
    .execute_c(execute_c),
    .execute_rd(execute_rd),
    .execute_imm(execute_imm)
);


execute_cycle execute (
    //from the prev cycle
    .clk(clock),
    .pc(decode_pcout), //was execte_pcout
    .a(execute_a),
    .b(execute_b),
    .new_write_aluout(writeback_alufor),
    .new_mem_aluout(),
    .c(execute_c),
    .rd(execute_rd),
    .imm(execute_imm),
    .regwrite(execute_regwritein),
    .op(execute_ir[3:0]),

    //writeback
    .forwarded_aluout(mem_aluout),

    //from control
    .rst(rst),
    .aluop(aluop),
    .aluin1(execute_aluin1), //no longer fucked with by forwarding unit
    .aluin2(execute_aluin2),
    .forward_a(forward_a),
    .forward_b(forward_b),
    // .aluin1(aluin1),
    // .aluin2(aluin2),
    .alusrc(alusrc),

    //maybe
    .pcwrite(pcwrite),

    //outputs
    .bout(execute_bout),
    .aluout(execute_aluout),
    .rdout(execute_rdout),
    .opout(execute_opout),
    .zero(execute_zero),
    .pos(execute_pos),
    .regwriteout(execute_regwriteout),
    .execute_pcwrite(execute_pcwrite),
    .intermediate_aluout(intermediate_aluout)
);

//execute-memory
em_regs emr (
    .execute_regwriteout(execute_regwriteout),
    .newb(newb),
    .execute_aluout(execute_aluout),
    .execute_rd(execute_rd),

    .clock(clock),
    .stall(stall),
    .rst(rst),

    .memory_regwritein(memory_regwritein),
    .mem_b(mem_b),
    .mem_aluout(mem_aluout),
    .decode_rd(decode_rd)
);


mem_cycle mem (
    //input
    .clk(clock),
    .b(mem_b),
    .aluout(mem_aluout),

    //outside input
    .read_in(read_in),

    //outside output
    .write_out(write_out),

    //from control
    .rst(rst),
    .memwrite(memwrite),
    .regwrite(memory_regwritein),

    //output
    .memout(mem_memout),
    .alufor(mem_alufor),
    .regwriteout(memory_regwriteout)
);


mw_regs mwr (
    .decode_rd(decode_rd),
    .mem_memout(mem_memout),
    .mem_aluout(mem_aluout),
    .memory_regwriteout(memory_regwriteout),

    .clock(clock),
    .stall(stall),
    .rst(rst),

    .write_rd(write_rd),
    .writeback_memout(writeback_memout),
    .writeback_alufor(writeback_alufor),
    .wb_regwrite(wb_regwrite)
);

//________________________________________________
// make input, output, clocki, rest

always @(stall, fetch_ir) begin
    if (stall == 0) begin // stall
        inst_ir = 16'b0000000000000000;
    end else begin
        inst_ir = fetch_ir;
    end
end

always @(posedge clock)
begin

end

endmodule