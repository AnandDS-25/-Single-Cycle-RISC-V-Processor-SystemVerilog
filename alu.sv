module alu (
    input [31:0] rs1_data,       // Source register 1 data
    input [31:0] rs2_data,       // Source register 2 data (or immediate for I-type)
    input [3:0] alu_control,     // 4-bit ALU control input
    output reg [31:0] result,    // ALU result
    output zero                  // Zero flag output
);

    // ALU operation based on alu_control lines
    always @(*) begin
        case (alu_control)
            4'b0000: result = rs1_data & rs2_data;         // AND operation
            4'b0001: result = rs1_data | rs2_data;         // OR operation
            4'b0010: result = rs1_data + rs2_data;         // ADD operation (for I-type, rs2_data is immediate)
            4'b0110: result = rs1_data - rs2_data;         // SUBTRACT operation (used for branches)
            4'b1000: result = rs1_data << rs2_data[4:0];   // Logical shift left
            4'b1001: result = rs1_data >> rs2_data[4:0];   // Logical shift right
            4'b1010: result = rs1_data >>> rs2_data[4:0];  // Arithmetic shift right
            4'b1100: result = rs1_data ^ rs2_data;         // XOR operation
            4'b1101: result = (rs1_data < rs2_data) ? 32'b1 : 32'b0; // Set less than (SLT)
            default: result = 32'b0;                       // Default case for unsupported operations
        endcase
    end

    // Zero flag is set if the result is zero
    assign zero = (result == 32'b0) ? 1'b1 : 1'b0;

endmodule
