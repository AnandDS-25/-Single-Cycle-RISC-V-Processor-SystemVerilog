module reg_file (
    input logic [4:0] rs1_addr,
    input logic [4:0] rs2_addr,
    input logic [4:0] rd_addr,
    input logic reg_write,          // Single-bit for write enable
    input logic [31:0] wr_data,
    input logic rst,                // Single-bit for reset
    output logic [31:0] rs1_imm,
    output logic [31:0] rs2_data
);

    // Register file array
    logic [31:0] reg_f[31:0]; 

    // Reset or read/write operations
    always @(*) begin
        // Output the register values
        rs1_imm = reg_f[rs1_addr];
        rs2_data = reg_f[rs2_addr];

        // Handle reset: Clear all registers if rst is high
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                reg_f[i] = 32'b0;
            end
        end
        // Write operation: Write data to rd_addr if reg_write is high
        else if (reg_write) begin
            reg_f[rd_addr] = wr_data;
        end
    end

endmodule
