//load-store
module load_store(clock, read_in, rst, write_out);
// make input, output, clocki, rest
input clock;
input [15:0] read_in;
input rst;

output [15:0] write_out;

parameter HALF_PERIOD=50;

//wires out of control
wire [1:0] immgenop;
wire aluop;
wire [1:0] aluin1;
wire [1:0] aluin2;
wire [1:0] alusrc; 
wire memread;
wire memwrite;
wire pcwrite;
wire regwrite; //why do we not have this? TODO: forward a regwrite (1 for instructions involving writing to registers), see wb intermediate register (https://rosehulman-my.sharepoint.com/personal/williarj_rose-hulman_edu/_layouts/15/Doc.aspx?sourcedoc={526b68a4-b014-48a8-a92e-48a2395fe4d4}&action=view&wd=target%28Pipeline.one%7C19a91754-ac57-43a0-b626-081762078c5b%2FClean%20Datapath%7Ca31e1fa3-3f74-bd49-b1f8-643b6fb30f73%2F%29&wdorigin=NavigationUrl)
wire mem2reg; //we still need to put docs for this



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

reg_component pcmain (
    .clock(clock), 
    .in(chosen_pc), 
    .out(fetch_pc),
    .write(stall), //wacky
    .reset(rst )
);

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

decode_cycle decode (
    //from prev cycle (and writeback)
    .ir(decode_ir),
    .pc(decode_pc),
    .clk(clock),
    .writedata(decode_writedata),
    .rd(decode_rd),

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

execute_cycle execute (
    //from the prev cycle
    .clk(clock),
    .pc(decode_pcout), //was execte_pcout
    .a(execute_a),
    .b(execute_b),
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
    .aluin1(forwarded_alusrc0),
    .aluin2(forwarded_alusrc1),
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

two_way_mux_component pcsrc (
    .in0(next_pc),
    .in1(decode_c), //execute_c
    .op(branch_taken),
    .reset(rst),
    .out(chosen_pc)
);

//wires into mem
wire [15:0] mem_b;

//wires out of mem
wire [15:0] mem_memout;
wire [15:0] mem_alufor;

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

//in-between registers
//fetch-decode
little_reg_component fd_aluin1 (
    .clock(clock),
    .in(fetch_aluin1),
    .write(stall),
    .reset(branch_taken | rst),
    .out(decode_aluin1)
);

little_reg_component fd_aluin2 (
    .clock(clock),
    .in(fetch_aluin2),
    .write(stall),
    .reset(branch_taken | rst),
    .out(decode_aluin2)
);

reg_component fd_pc (
    .clock(clock),
    .in(fetch_pc),
    .write(stall),
    .reset(branch_taken | rst),
    .out(decode_pc)
);

reg [15:0] inst_ir;

reg_component fd_ir (
    .clock(clock),
    .in(inst_ir),
    .write(1),
    .reset(branch_taken | rst),
    .out(decode_ir)
);

always @(stall, fetch_ir) begin
    if (stall == 0) begin // stall
        inst_ir = 16'b0000000000000000;
    end else begin
        inst_ir = fetch_ir;
    end
end

//decode-execute
tiny_reg_component de_regwrite (
    .clock(clock),
    .in(regwrite), 
    .write(stall),
    .reset(branch_taken || reset),
    .out(execute_regwritein)
);

reg_component de_ir (
    .clock(clock),
    .in(decode_irout),
    .write(stall),
    .reset(rst),
    .out(execute_ir)
);

reg_component de_pc (
    .clock(clock),
    .in(decode_pcout),
    .write(stall),
    .reset(rst),
    .out(execute_pc)
);

reg_component de_a (
    .clock(clock),
    .in(decode_a),
    .write(stall),
    .reset(rst),
    .out(execute_a)
);

reg_component de_b (
    .clock(clock),
    .in(decode_b),
    .write(stall),
    .reset(rst),
    .out(execute_b)
);

little_reg_component de_aluin1 (
    .clock(clock),
    .in(decode_aluin1out),
    .reset(rst),
    .write(stall),
    .out(execute_aluin1)
);

little_reg_component de_aluin2 (
    .clock(clock),
    .in(decode_aluin2out),
    .reset(rst),
    .write(stall),
    .out(execute_aluin2)
);

reg_component de_c (
    .clock(clock),
    .in(decode_c),
    .write(stall),
    .reset(rst),
    .out(execute_c)
);

small_reg_component de_rd (
    .clock(clock),
    .in(decode_rdout),
    .write(stall),
    .reset(rst),
    .out(execute_rd)
);

reg_component de_imm (
    .clock(clock),
    .in(decode_imm),
    .write(stall),
    .reset(rst),
    .out(execute_imm)
);

//execute-memory
tiny_reg_component em_regwrite (
    .clock(clock),
    .in(execute_regwriteout),
    .write(stall),
    .reset(rst),
    .out(memory_regwritein)
);


reg_component em_b (
    .clock(clock),
    .in(newb),
    .write(stall),
    .reset(rst),
    .out(mem_b)
);

reg_component em_aluout (
    .clock(clock),
    .in(execute_aluout),
    .write(stall),
    .reset(rst),
    .out(mem_aluout)
);

small_reg_component em_rd (
    .clock(clock),
    .in(execute_rd),
    .write(stall),
    .reset(rst),
    .out(decode_rd)
);


//memory-writeback
wire [15:0] writeback_memout;
wire [15:0] writeback_alufor;

wire [3:0] write_rd;

small_reg_component mw_rd (
    .clock(clock),
    .in(decode_rd),
    .write(1),
    .reset(rst),
    .out(write_rd)
);

reg_component mw_mem (
    .clock(clock),
    .in(mem_memout),
    .write(1),
    .reset(rst),
    .out(writeback_memout)
);

reg_component mw_alufor (
    .clock(clock),
    .in(mem_aluout),
    .write(1),
    .reset(rst),
    .out(writeback_alufor)
);

tiny_reg_component mw_regwrite (
    .clock(clock),
    .in(memory_regwriteout),
    .write(1),
    .reset(rst),
    .out(wb_regwrite)
);

two_way_mux_component mw_m2r (
    .in0(writeback_alufor),
    .in1(writeback_memout),
    .op(mem2reg),
    .reset(0),
    .out(decode_writedata)
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

forward_unit_component fw (
    .rs1(execute_ir[11:8]), // moved rs1 and rs2 one cycle forward, seems to be coming in too early
    .rs2(execute_ir[15:12]),
    .rd(write_rd), //mw_rd doesn't exist yet, need to move either rd or the entire inst down the pipeline
    .oldalusrc0(execute_aluin1),
    .oldalusrc1(execute_aluin2),
    .alusrc0(forwarded_alusrc0),
    .alusrc1(forwarded_alusrc1),
    .newb(newb),
    .shouldb(mem_aluout),
    .originalb(execute_bout)
);


always @(posedge clock)
begin

end

endmodule