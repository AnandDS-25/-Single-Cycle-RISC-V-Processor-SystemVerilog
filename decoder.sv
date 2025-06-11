module decoder
(
  output logic[6:0] opcode,
  output logic[5:0] rd,
  output logic[2:0] func3,
  output logic[11:0] imm,
  output logic[4:0] rs1,
  output logic[4:0] rs2,
  output logic[6:0] func7,
  input logic[31:0] inst
);

assign opcode = inst[6:0];

always @(*) begin 
  case(opcode)
    7'b0110011: begin   // R-type
      rd = inst[11:7];
      func3 = inst[14:12];
      rs1 = inst[19:15];
      rs2 = inst[24:20];
      func7 = inst[31:25];
    end

    7'b0010011: begin    // I-type
      rd = inst[11:7];
      func3 = inst[14:12];
      rs1 = inst[19:15];
      imm = inst[31:20];
    end

    7'b0000011: begin    // Load
      rd = inst[11:7];
      func3 = inst[14:12];
      rs1 = inst[19:15];
      imm = inst[31:20];
    end

    7'b0100011: begin    // Store-type
      imm[4:0] = inst[11:7];  // Lower 5 bits
      func3 = inst[14:12];
      rs1 = inst[19:15];
      rs2 = inst[24:20];
      imm[11:5] = inst[31:25]; // Upper 7 bits
    end

    7'b1100011: begin    // Branch-type
      imm[11] = inst[31];    
      imm[10:5] = inst[30:25]; 
      imm[4:1] = inst[11:8]; 
      imm[10] = inst[7];       // Corrected imm[0] bit extraction
      func3 = inst[14:12];
      rs1 = inst[19:15];
      rs2 = inst[24:20];
    end
  endcase
end

endmodule
