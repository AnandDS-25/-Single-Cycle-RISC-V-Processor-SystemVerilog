module instruc_ex (
    input logic [31:0] rs1_data,    // Source register 1 data
    input logic [31:0] rs2_data,    // Source register 2 data
    input logic [31:0] imm,         // Immediate value (output of sign extension)
    input logic alu_src,            // ALU source select
    input logic [3:0] alu_control,  // ALU control input
    input logic branch,             // Branch control signal
    input logic [31:0] pc,          // PC output from the fetch stage
    output logic [31:0] alu_result, // ALU result output
    output logic jump,              // Jump output (from the AND gate)
    output logic zero,              // Zero flag output from the ALU
    output logic and_outt,          // Output of AND gate
    output logic [31:0] adder_res   // Adder result for branch/jump target
);

    // Intermediate signals
    logic [31:0] mux_out;           // Output of the multiplexer
    logic and_out;                  // Intermediate AND gate output

    // Instantiate the multiplexer
    mux_1 mux_inst (
        .a(rs2_data),               // rs2_data as input A
        .b(imm),                    // Immediate value as input B
        .sel(alu_src),              // Select signal for ALU source
        .y(mux_out)                 // MUX output connected to ALU input
    );

    // Instantiate the ALU
    alu alu_inst (
        .rs1_data(rs1_data),        // Source register 1 data
        .rs2_data(mux_out),         // Output of MUX connected to ALU input
        .alu_control(alu_control),  // ALU control signals
        .result(alu_result),        // ALU computation result
        .zero(zero)                 // Zero flag output from ALU
    );

    // Instantiate the AND gate for branch condition
    and_g and_inst (
        .a(zero),                   // Zero flag from ALU
        .b(branch),                 // Branch control signal
        .c(and_out)                 // Output of the AND gate
    );

    // Connect AND gate output to both `jump` and `and_outt` for clarity
    assign jump = and_out;          // Assign AND gate output to `jump`
    assign and_outt = and_out;      // Assign AND gate output to `and_outt`

    // Instantiate the adder for PC + immediate value (branch/jump target)
    adder_ex_stage new_adder (
        .a(pc),                     // PC value as input A
        .b(imm),                    // Immediate value as input B
        .y(adder_res)               // Adder result
    );


endmodule
