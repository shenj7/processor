module forward_unit_tb()
//Inputs

//Outputs


parameter HALF_PERIOD = 50;
integer failures = 0;
integer expected = 0;

initial begin
 forever begin
     #(HALF_PERIOD);
      clk = ~clk;
    end
end

//UUT

//Tests
endmodule