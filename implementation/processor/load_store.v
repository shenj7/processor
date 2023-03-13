module load_store(clock, read_in, rst, write_out);
    reg_component pc_reg (
        .clock(),
        .in(),
        .write(),
        .reset(),
        .out()
    );

    two_way_mux_component pc_to_mem_mux (
        .in0(),
        .in1(),
        .op(),
        .reset(),
        .out(),
    );
    
    mem_component memory (
        .writedata(),
        .addr(),
        .write(),
        .clk(),
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
        .clock(),
        .in(),
        .write(),
        .reset(),
        .out()
    );
    
    reg_file_component reg_file(
        .clock(),
        .rs1(),
        .rs2(),
        .rd(),
        .currd(),
        .writedata(),
        .reset(),
        .write(),
        .reg1(),
        .reg2()
    );
    

    reg_component a_reg (
        .clock(),
        .in(),
        .write(),
        .reset(),
        .out()
    );


    reg_component b_reg (
        .clock(),
        .in(),
        .write(),
        .reset(),
        .out()
    );
    
    imm_gen_component imm_gen ( // TODO: fix component
        .imm(),
        .immgenop(),
        .out()
    );

    four_way_mux_component alusrc1_alu(
        .in0(),
        .in1(),
        .in2(),
        .in3(),
        .op(),
        .reset(),
        .out(),
    );

    four_way_mux_component alusrc2_mux (
        .in0(),
        .in1(),
        .in2(),
        .in3(),
        .op(),
        .reset(),
        .out(),
    );
    
    alu_component alu(
        .inst_id(), 
        .in0(), 
        .in1(), 
        .reset(),
        .out(), 
        .zero(), 
        .pos()
    );


    reg_component aluout_reg (
        .clock(),
        .in(),
        .write(),
        .reset(),
        .out()
    );
    

    two_way_mux_component pcsrc_mux (
        .in0(),
        .in1(),
        .op(),
        .reset(),
        .out(),
    );


    always @(posedge clock)
    begin

    end
    
endmodule