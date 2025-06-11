module alu_control (
    input  logic [6:0] func7,
    input  logic [2:0] func3,
    input  logic [1:0] alu_op,  // Control signal to distinguish instruction types
    output logic [3:0] aluop
);

always_comb begin
    case (alu_op)
        2'b10: begin // R-type instructions
            case ({func7, func3})
                10'b0000000000: aluop = 4'b0010; // ADD
                10'b0100000000: aluop = 4'b0110; // SUB
                10'b0000000111: aluop = 4'b0000; // AND
                10'b0000000110: aluop = 4'b0001; // OR
                10'b0000000100: aluop = 4'b0011; // XOR
                10'b0000000001: aluop = 4'b1000; // SLL
                10'b0000000101: aluop = 4'b1001; // SRL
                10'b0100000101: aluop = 4'b1010; // SRA
                default: aluop = 4'b0000;        // Default for unexpected R-type inputs
            endcase
        end

        2'b00: begin // I-type and Load instructions (e.g., ADDI, ANDI, ORI, XORI, LW)
            case (func3)
                3'b000: aluop = 4'b0010; // ADDI
                3'b111: aluop = 4'b0000; // ANDI
                3'b110: aluop = 4'b0001; // ORI
                3'b100: aluop = 4'b0011; // XORI
                3'b001: aluop = 4'b1000; // SLLI
                3'b101: aluop = (func7 == 7'b0000000) ? 4'b1001 : 4'b1010; // SRLI/SRAI
                default: aluop = 4'b0000; // Default for unexpected I-type inputs
            endcase
        end

        2'b01: begin // Branch instructions (e.g., BEQ)
            aluop = 4'b0110; // Use SUB to determine zero flag for BEQ comparison
        end

        default: aluop = 4'b0000; // Default output for unsupported ALU control signals
    endcase
end

endmodule
