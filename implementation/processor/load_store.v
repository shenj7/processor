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
wire aluin1;
wire [1:0] aluin2;
wire alusrc; //tf is this doing?
wire memread;
wire memwrite;
wire pcwrite;
wire regwrite; //why do we not have this?
wire mem2reg; //we still need to put docs for this



//wires for hazards and forwarding
wire stall = 1;
wire flush = 0;


//pc main stuff
wire [15:0] next_pc;
wire [15:0] chosen_pc;

reg branch_taken;


//wires into fetch
wire [15:0] fetch_pc; //error

reg_component pcmain (
    .clock(clock),
    .in(chosen_pc), //mux (pcsrc)
    .out(fetch_pc),
    .write(stall),
    .reset(flush)
);

//wires out of fetch
wire [15:0] fetch_ir;
wire [15:0] fetch_pcout;

//control
control_component control (
    //input
    .op(decode_ir),
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

//fetch cycle
fetch_cycle fetch (
    //from prev cycle
    .pc(fetch_pc),
    .clk(clock),
    
    //from control
    .rst(branch_taken),
    .pcwrite(stall),
    
    //output
    .ir(fetch_ir),
    .currpc(fetch_pcout),
    .newpc(next_pc)
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
    .rd(decode_rd),

    //from control
    .rst(branch_taken),
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
    .rst(branch_taken),
    .aluop(aluop),
    .aluin1(forwarded_alusrc0),
    .aluin2(forwarded_alusrc1),

    //outputs
    .bout(execute_bout),
    .aluout(execute_aluout),
    .rdout(execute_rdout),
    .zero(execute_zero),
    .pos(execute_pos)
);

two_way_mux_component pcsrc (
    .in0(next_pc),
    .in1(execute_aluout),
    .op(branch_taken),
    .reset(branch_taken),
    .out(chosen_pc)
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

    //outside input
    .read_in(read_in),

    //outside output
    .write_out(write_out),

    //from control
    .rst(branch_taken),
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
    .write(stall),
    .reset(branch_taken),
    .out(decode_pc)
);

wire [15:0] inst_ir;

reg_component fd_ir (
    .clock(clock),
    .in(inst_ir),
    .write(1),
    .reset(branch_taken),
    .out(decode_ir)
);

always @(stall) begin
    if (stall == 0) begin // stall
        inst_ir = 16'b0000000000000000;
    end else begin
        inst_ir = fetch_ir;
    end
end

//decode-execute
reg_component de_pc (
    .clock(clock),
    .in(decode_pcout),
    .write(stall),
    .reset(branch_taken),
    .out(execute_pc)
);

reg_component de_a (
    .clock(clock),
    .in(decode_a),
    .write(stall),
    .reset(branch_taken),
    .out(execute_a)
);

reg_component de_b (
    .clock(clock),
    .in(decode_b),
    .write(stall),
    .reset(branch_taken),
    .out(execute_b)
);

small_reg_component de_rd (
    .clock(clock),
    .in(decode_rdout),
    .write(stall),
    .reset(branch_taken),
    .out(execute_rd)
);

reg_component de_imm (
    .clock(clock),
    .in(decode_imm),
    .write(stall),
    .reset(branch_taken),
    .out(execute_imm)
);

//execute-memory
reg_component em_b (
    .clock(clock),
    .in(newb),
    .write(stall),
    .reset(0),
    .out(mem_b)
);

reg_component em_aluout (
    .clock(clock),
    .in(execute_aluout),
    .write(stall),
    .reset(0),
    .out(mem_aluout)
);

small_reg_component em_rd (
    .clock(clock),
    .in(execute_rd),
    .write(stall),
    .reset(0),
    .out(decode_rd)
);

//memory-writeback
wire [15:0] writeback_memout;
wire [15:0] writeback_alufor;

reg_component mw_mem (
    .clock(clock),
    .in(mem_memout),
    .write(1),
    .reset(0),
    .out(writeback_memout)
);

reg_component mw_alufor (
    .clock(clock),
    .in(mem_alufor),
    .write(1),
    .reset(0),
    .out(writeback_alufor)
);

two_way_mux_component mw_m2r (
    .in0(writeback_memout),
    .in1(writeback_alufor),
    .op(mem2reg),
    .out(decode_writedata)
);

//branch logic
always @(*) begin
    branch_taken <= pcwrite && flush;
end


//hazards and forwarding
hazard_detection_unit_component hazard (
    .clock(clock),
    .memread(memread),
    .instop(decode_ir),
    .zero(execute_zero),
    .stall(stall),
    .flush(flush)
);

forward_unit_component fw (
    .rs1(decode_ir[11:8]),
    .rs2(decode_ir[15:12]),
    .rd(decode_ir[7:4]),
    .oldalusrc0(aluin1),
    .oldalusrc1(aluin2),
    .alusrc0(forwarded_alusrc0),
    .alusrc1(forwarded_alusrc1),
    .newb(newb),
    .shouldb(mem_aluout),
    .originalb(execute_bout)
    // wire [15:0] newb;
    // wire [1:0] forwarded_alusrc0;
    // wire [1:0] forwarded_alusrc1;
);


always @(posedge clock)
begin

$display("HERE READ_IN: %d", read_in);
$display("fetch inst %d", fetch_ir);
$display("Reading inst from mem: %d", decode_ir);
$display("fetch pcout: %d", fetch_pcout);
$display("fetch pc: %d", fetch_pc);
$display("chosen pc: %d", chosen_pc);
$display("stall: %d plz be 1", stall);


end

endmodule