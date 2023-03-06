//Control Testing
`timescale 1 ns/1 ps

module control_tb();

//Inputs
reg [3:0] op;
reg reset;
reg clk;

//Outputs
wire [1:0] IMMGENOP; //can get rid of all immgenops later - just pass in entire inst to immgen
wire ALUOP;
wire [1:0] ALUIN1;
wire [1:0] ALUIN2;
wire [1:0] ALUSRC;
wire MEMREAD;
wire MEMWRITE;
wire PCWRITE;
wire MEM2REG;
wire REGWRITE;

//

parameter HALF_PERIOD = 50;
integer cycle_counter = 0;
integer counter = 0;
integer failures = 0;

initial begin
    clk = 0;
    forever begin
        #(HALF_PERIOD);
        clk = ~clk;
    end
end

control_component UUT (
	 .reset(reset),
	 .op(op),
	 .IMMGENOP(IMMGENOP),
	 .ALUOP(ALUOP),
	 .ALUIN1(ALUIN1),
	 .ALUIN2(ALUIN2),
	 .ALUSRC(ALUSRC),
	 .MEMREAD(MEMREAD),
	 .MEMWRITE(MEMWRITE),
	 .PCWRITE(PCWRITE),
	 .REGWRITE(REGWRITE),
	 .MEM2REG(MEM2REG)
);

//
function integer test(input integer failures, newOp, newIMMGENOP, newALUOP, newALUIN1, newALUIN2, newALUSRC, 
	 newMEMREAD, newMEMWRITE, newPCWRITE, newMEM2REG, newREGWRITE);
		begin
		op = newOp;
		if (IMMGENOP != newIMMGENOP) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed IMMGENOP = %d, expecting = %d", IMMGENOP, newIMMGENOP);
		 end else if (ALUOP != newALUOP) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed ALUOP = %d, expecting = %d", ALUOP, newALUOP);
		 end else if (ALUIN1 != newALUIN1) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed ALUIN1 = %d, expecting = %d", ALUIN1, newALUIN1);
		 end else if (ALUIN2 != newALUIN2) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed ALUIN2 = %d, expecting = %d", ALUIN2, newALUIN2);
		 end else if (ALUSRC != newALUSRC) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed ALUSRC = %d, expecting = %d", ALUSRC, newALUSRC);
		 end else if (MEMREAD != newMEMREAD) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed MEMREAD = %d, expecting = %d", MEMREAD, newMEMREAD);
		 end else if (MEMWRITE != newMEMWRITE) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed MEMWRITE = %d, expecting = %d", MEMWRITE, newMEMWRITE);
		 end else if (PCWRITE != newPCWRITE) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed PCWRITE = %d, expecting = %d", PCWRITE, newPCWRITE);
		 end else if (MEM2REG != newMEM2REG) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed MEM2REG = %d, expecting = %d", MEM2REG, newMEM2REG);
		 end else if (REGWRITE != newREGWRITE) begin
			  failures = failures + 1;
			  //$display("Test 1 Failed REGWRITE = %d, expecting = %d", REGWRITE, newREGWRITE);
		 end
		end
endfunction

initial begin
    reset = 1;
    #(100*HALF_PERIOD);
    reset = 0;
	 failures = test(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);//-----TEST 1 (add)-----
	 failures = test(failures, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);//-----TEST 2 (sub)-----
	 failures = test(failures, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0);//-----TEST 3 (grt)-----
	 failures = test(failures, 3, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0);//-----TEST 4 (eq)-----
	 failures = test(failures, 6, 2, 0, 1, 2, 0, 0, 0, 1, 0, 1);//-----TEST 5 (jal)-----
	 failures = test(failures, 4, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1);//-----TEST 6 (jalr)-----
	 failures = test(failures, 8, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0);//-----TEST 7 (addi)-----
	 failures = test(failures, 5, 3, 1, 0, 2, 0, 0, 0, 0, 0, 0);//-----TEST 8 (lui)-----
	 failures = test(failures, 15, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0);//-----TEST 9 (lli)-----
	 failures = test(failures, 9, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0);//-----TEST 10 (lw)-----
	 failures = test(failures, 10, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0);//-----TEST 11 (sw)-----
	 failures = test(failures, 11, 2, 1, 1, 0, 0, 0, 0, 1, 0, 1);//-----TEST 12 (bne)-----
	 failures = test(failures, 12, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0);//-----TEST 13 (wri)-----
	 failures = test(failures, 13, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0);//-----TEST 14 (rea)-----
    //$display("TESTS COMPLETE. \n Failures = %d", failures);
    $stop;
end

endmodule
