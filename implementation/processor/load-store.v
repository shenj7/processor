//load-store
module load_store();

reg clock;

initial begin
    clock = 0;
    forever begin
        #(HALF_PERIOD);
        clock = ~clock;
    end
end

//add in a control unit

fetch_cycle fetch (
    //from prev cycle
    .pc(),
    .pcwrite(),
    .clk(),
    
    //from control
    .rst(),
    
    //output
    .ir(),
    .currpc()
);

decode_cycle decode (
    //from prev cycle (and writeback)
    .ir(),
    .pc(),
    .clk(),
    .writedata(),
    .regwrite(),

    //output
    .inst(),
    .pcout(),
    .a(),
    .b(),
    .rdout(),
    .imm(),
);

execute_cycle execute (
    //from the prev cycle
    .pc(),
    .a(),
    .b(),
    .rd(),
    .imm(),
    .inst(),

    //from control
    .aluop(),
    .aluin1(),
    .aluin2(),

    //outputs
    .newpc(),
    .aluout(),
    .rdout(),
    .zero(),
    .pos()

);


always @(posedge clock)
begin




end

endmodule