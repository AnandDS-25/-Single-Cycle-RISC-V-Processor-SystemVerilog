module write_back(
    input logic [31:0] data_out, 
    input logic [31:0] alu_out,
    input logic mem_reg,
    output logic [31:0] mux_out
);

    always @(*) begin
        if (mem_reg)
            mux_out = data_out;  // Select data_out if mem_reg is 1
        else
            mux_out = alu_out;   // Select alu_out if mem_reg is 0
    end
endmodule
