module riscv_single_cycle (
    input logic clk,                 // Clock signal
    input logic rst,                 // Reset signal
    inout logic [31:0] pc_imm,       // Immediate value for PC
    
    output logic [31:0] inst         // Instruction output
);
    // Control signals
    logic [1:0] aluop;
    logic branch, mread, mwrite, alusrc, memtoreg, regwrite;
    logic [31:0] rs1, rs2, s_imm, alu_result, data_out, alu_out;
    logic [6:0] opcode, func7;
    logic [2:0] func3;
    logic [3:0] aluopp;
    logic zero, jump, and_output;
    logic [31:0] adder_result;       // Result from adder in execute stage

    // Instruction Fetch with the AND gate's output (and_output) as MUX select line
    intruc_fetch if_stage (
        .adder_res(adder_result),    // Output of adder in execute stage as first MUX input
        .sel(and_output),            // AND gate output from execute stage as MUX select
        .clk(clk), 
        .rst(rst), 
        .inst(inst),
		  .pc_ex(pc_imm)
    );

    // Instruction Decode
    instruc_decode id_stage (
        .clk(clk),
        .reset(rst),
        .inst(inst),
        .wr_data(alu_out), 
        .wr_enab(regwrite),
        .rs1(rs1),
        .rs2(rs2),
        .s_imm(s_imm),
        .func3(func3),
        .func7(func7),
        .opcode(opcode)
    );

    // Main Control
    main_control main_ctrl (
        .opcode(opcode),
        .aluop(aluop),
        .branch(branch),
        .mread(mread),
        .mwrite(mwrite),
        .alusrc(alusrc),
        .memtoreg(memtoreg),
        .regwrite(regwrite)
    );

    // ALU Control
    alu_control alu_ctrl (
        .alu_op(aluop),
        .func7(func7),
        .func3(func3),
        .aluop(aluopp)
    );

    // Execute Stage
    instruc_ex ex_stage (
        .rs1_data(rs1),
        .rs2_data(rs2),
        .imm(s_imm),
        .alu_src(alusrc),
        .alu_control(aluopp),
        .branch(branch),
        .alu_result(alu_result),
        .zero(zero),
        .jump(jump),
        .and_outt(and_output),       // Output of AND gate for MUX select in fetch stage
        .adder_res(adder_result),
		  .pc(pc_imm)
         		  // Adder result connected as MUX input in fetch stage
    );

    // Data Memory
    data_mem mem_stage (
        .ALU_result(alu_result), 
        .rs2_data(rs2), 
        .mem_read(mread),   
        .mem_write(mwrite),  
        .clk(clk), 
        .read_data(data_out)
    );

    // Write-Back Stage
    write_back wb_stage (
        .data_out(data_out),
        .alu_out(alu_result),
        .mem_reg(memtoreg),
        .mux_out(alu_out)
    );
endmodule