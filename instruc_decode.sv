module instruc_decode (
    input logic clk,
    input logic reset,             // Single-bit reset signal
    input logic [31:0] inst,       // 32-bit instruction input
    input logic [31:0] wr_data,    // 32-bit write data input
    input logic wr_enab,             // Write enable input
    output logic [31:0] rs1,       // Output for register source 1 data
    output logic [31:0] rs2,       // Output for register source 2 data
    output logic [31:0] s_imm,     // Output for sign-extended immediate
    output logic [2:0] func3,      // Output for function 3 bits
    output logic [6:0] func7,
    output logic [6:0] opcode
);

    // Wires for interconnections
    logic [4:0] rd_addr, rs1_addr, rs2_addr;
    logic [11:0] imm;
    

    // Instantiate decoder module
    decoder d1 (
        .inst(inst),
        .opcode(opcode),
        .rd(rd_addr),
        .func3(func3),
        .imm(imm),
        .rs1(rs1_addr),
        .rs2(rs2_addr),
        .func7(func7)
    );

    // Instantiate register file module
    reg_file rf (
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .reg_write(wr_enab),
        .wr_data(wr_data),
        .rst(reset),
        .rs1_imm(rs1),
        .rs2_data(rs2)
    );

    // Instantiate sign extension module
    sign sig (
        .imm_in(imm),
        .imm_out(s_imm)
    );

endmodule
