module intruc_fetch (
    input logic [31:0] pc_imm,
    
    input logic        sel,  // Changed to 1-bit signal for selection in the multiplexer
    input logic        clk,
    input logic        rst,
    output logic [31:0] inst,
	 output logic [31:0]pc_ex,
    input logic [31:0] adder_res
);
 logic [31:0] pc_4;

    logic [31:0] pc;
   
    logic [31:0] pc_inter;
    
    logic rt;

    // Fixed port connections in mux_1 instantiation
    mux_1 mu (
        .a(adder_res),
        .b(pc_4),
        .sel(sel),     // Corrected the selector input port
        .y(pc)         // Corrected output port
    );

    // Fixed half adder instantiation
    half_adder half (
        .a(32'd4),
        .b(pc_inter),
        .sum(pc_4),
           );

    // Fixed memory instantiation
    memory mem (
        .addr(pc_inter),
        .intr(inst),  // Assuming 'inst' is data output, corrected port name
        .rst(rst)         // Changed from 'rt' to 'rst' to match input signal
    );

    // Fixed riscv instantiation
    program_counter p_c (
        .clk(clk),
        .rst(rst),
        .pc_next(pc),
        .pc(pc_inter),
		  .pc_dup(pc_ex)
    );

endmodule

