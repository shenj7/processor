//load-store
module load_store();

parameter HALF_PERIOD=50;
reg clock;

initial begin
    clock = 0;
    forever begin
        #(HALF_PERIOD);
        clock = ~clock;
    end
end

//wires into control

//wires out of control
wire [1:0] immgenop;
wire aluop;
wire aluin1;
wire [1:0] aluin2;
wire alusrc; //tf is this doing?
wire memread;
wire memwrite;
wire pcwrite;
wire regwrite; //why do we not have this?
wire mem2reg; //we still need to put docs for this

control_component control (
    //input
    .op(),
    .reset(),

    //output
    .IMMGENOP(immgenop),
    .ALUOP(aluop),
    .ALUIN1(aluin1),
    .ALUIN2(aluin2),
    .ALUSRC(alusrc),
    //.REGWRITE(regwrite),
    .MEMREAD(memread),
    .MEMWRITE(memwrite),
    .PCWRITE(pcwrite),
    .MEM2REG(mem2reg)
);

//wires into fetch
wire [15:0] fetch_pc;

//wires out of fetch
wire [15:0] fetch_ir;
wire [15:0] fetch_pcout;

fetch_cycle fetch (
    //from prev cycle
    .pc(fetch_pc),
    .clk(clock),
    
    //from control
    .rst(),
    .pcwrite(pcwrite),
    
    //output
    .ir(fetch_ir),
    .currpc(fetch_pcou)
);

//wires into decode
wire [15:0] decode_ir;
wire [15:0] decode_pc;
wire [15:0] decode_writedata;
wire [15:0] decode_rd;

//wires out of decode
wire [15:0] decode_pcout;
wire [15:0] decode_a;
wire [15:0] decode_b;
wire [3:0] decode_rdout;
wire [15:0] decode_imm;

decode_cycle decode (
    //from prev cycle (and writeback)
    .ir(decode_ir),
    .pc(decode_pc),
    .clk(clock),
    .writedata(decode_writedata),
    .rd(decode_rd)

    //from control
    .rst(),
    .regwrite(regwrite),
    .immgenop(immgenop),

    //output
    .pcout(decode_pcout),
    .a(decode_a),
    .b(decode_b),
    .rdout(decode_rdout),
    .imm(decode_imm)
);

//wires into execute
wire [15:0] execute_pc;
wire [15:0] execute_a;
wire [15:0] execute_b;
wire [3:0] execute_rd;
wire [15:0] execute_imm;

//wires out of execute
wire [15:0] execute_bout;
wire [15:0] execute_aluout;
wire [3:0] execute_rdout;
wire execute_zero;
wire execute_pos;

execute_cycle execute (
    //from the prev cycle
    .clk(clock),
    .pc(execute_pc),
    .a(execute_a),
    .b(execute_b),
    .rd(execute_rd),
    .imm(execute_imm),

    //from control
    .rst(),
    .aluop(aluop),
    .aluin1(aluin1),
    .aluin2(aluin2),

    //outputs
    .bout(execute_bout),
    .aluout(execute_aluout),
    .rdout(execute_rdout),
    .zero(execute_zero),
    .pos(execute_pos)
);

//wires into mem
wire [15:0] mem_b;
wire [15:0] mem_aluout;

//wires out of mem
wire [15:0] mem_memout;
wire [15:0] mem_alufor;

mem_cycle mem (
    //input
    .clk(clock),
    .b(mem_b),
    .aluout(mem_aluout),

    //from control
    .rst(),
    .memwrite(memwrite),

    //output
    .memout(mem_memout),
    .alufor(mem_alufor)
);

//in-between registers
//fetch-decode
reg_component fd_pc (
    .clock(clock),
    .in(fetch_pc),
    .write(1),
    .reset(),
    .out(decode_pc)
);

reg_component fd_ir (
    .clock(clock),
    .in(fetch_ir),
    .write(1),
    .reset(),
    .out(decode_ir)
);

//decode-execute
reg_component de_pc (
    .clock(clock),
    .in(decode_pcout),
    .write(1),
    .reset(),
    .out(execute_pc)
);

reg_component de_a (
    .clock(clock),
    .in(decode_a),
    .write(1),
    .reset(),
    .out(execute_a)
);

reg_component de_b (
    .clock(clock),
    .in(decode_b),
    .write(1),
    .reset(),
    .out(execute_b)
);

small_reg_component de_rd (
    .clock(clock),
    .in(decode_rdout),
    .write(1),
    .reset(),
    .out(execute_rd)
);

reg_component de_imm (
    .clock(clock),
    .in(decode_imm),
    .write(1),
    .reset(),
    .out(execute_imm)
);

//execute-memory
reg_component em_b (
    .clock(clock),
    .in(execute_bout),
    .write(1),
    .reset(),
    .out(mem_b)
);

reg_component em_aluout (
    .clock(clock),
    .in(execute_aluout),
    .write(1),
    .reset(),
    .out(mem_aluout)
);

small_reg_component em_rd (
    .clock(clock),
    .in(execute_rd),
    .write(1),
    .reset(),
    .out(decode_rd)
);

//memory-writeback
wire [15:0] writeback_memout;
wire [15:0] writeback_alufor;

reg_component mw_mem (
    .clock(clock),
    .in(mem_memout),
    .write(1),
    .reset(),
    .out(writeback_memout)
);

reg_component mw_alufor (
    .clock(clock),
    .in(mem_alufor),
    .write(1),
    .reset(),
    .out(writeback_alufor)
);

two_way_mux_component mw_m2r (
    .in0(writeback_memout),
    .in1(writeback_alufor),
    .op(mem2reg)
)

always @(posedge clock)
begin




end

endmodule