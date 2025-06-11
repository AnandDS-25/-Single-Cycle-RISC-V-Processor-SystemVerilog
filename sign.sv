module sign
(
  input logic [11:0] imm_in,       // 12-bit immediate input from decoder
  output logic [31:0] imm_out      // 32-bit sign-extended output
);

always_comb begin
  imm_out = {{20{imm_in[11]}}, imm_in[10:0]};  // Sign-extend from 12 bits to 32 bits
end

endmodule