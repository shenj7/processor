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
    .PCWRITE(pcwrite)
);

//wires into fetch
wire [15:0] fetch_pc;

//wires out of fetch
wire [15:0] fetch_ir;
wire [15:0] fetch_pc;

fetch_cycle fetch (
    //from prev cycle
    .pc(fetch_pc),
    .clk(clock),
    
    //from control
    .rst(),
    .pcwrite(pcwrite),
    
    //output
    .ir(decode_ir),
    .currpc(decode_pc)
);

//wires into decode
wire [15:0] decode_ir;
wire [15:0] decode_pc;
wire [15:0] decode_writedata

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
wire [15:0] execute_pcout;
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
    .newpc(execute_pcout),
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
wire [15:0] mem_addrout;

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
    .addrout(mem_addrout)
);

//in-between registers
//fetch-decode
reg_component fd_pc (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

reg_component fd_ir (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

//decode-execute
reg_component de_pc (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

reg_component de_a (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

reg_component de_b (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

small_reg_component de_rd (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

reg_component de_imm (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

//execute-memory
reg_component em_b (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

reg_component em_aluout (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

small_reg_component em_rd (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

//memory-writeback
reg_component mw_mem (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

reg_component me_addr (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

//writeback cycle items
two_way_mux_component w_jump (
    .clock(clock),
    .in(),
    .write(),
    .reset(),
    .out()
);

wire [15:0] writedata;


always @(posedge clock)
begin




end

endmodule