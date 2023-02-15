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

//wires out of fetch

fetch_cycle fetch (
    //from prev cycle
    .pc(),
    .clk(clock),
    
    //from control
    .rst(),
    .pcwrite(pcwrite),
    
    //output
    .ir(),
    .currpc()
);

//wires into fetch

//wires out of decode

decode_cycle decode (
    //from prev cycle (and writeback)
    .ir(),
    .pc(),
    .clk(clock),
    .writedata(),

    //from control
    .rst(),
    .regwrite(regwrite),
    .immgenop(immgenop),

    //output
    .inst(),
    .pcout(),
    .a(),
    .b(),
    .rdout(),
    .imm()
);

//wires into execute

//wires out of execute

execute_cycle execute (
    //from the prev cycle
    .clk(clock),
    .pc(),
    .a(),
    .b(),
    .rd(),
    .imm(),

    //from control
    .rst(),
    .aluop(aluop),
    .aluin1(aluin1),
    .aluin2(aluin2),

    //outputs
    .newpc(),
    .aluout(),
    .rdout(),
    .zero(),
    .pos()

);

//wires into mem

//wires out of mem

mem_cycle mem (
    //input
    .clk(clock),
    .b(),
    .aluout(),

    //from control
    .rst(),
    .memwrite(memwrite),

    //output
    .memout(),
    .addrout()
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