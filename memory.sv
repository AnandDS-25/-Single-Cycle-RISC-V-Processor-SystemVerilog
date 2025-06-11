module memory #(parameter dw = 32, dl = 1024) (
    input logic [31:0] addr,     // addr is a 32-bit logic vector
    output logic [dw-1:0] intr,  // output is 32 bits
    input logic rst              // reset signal
);

    logic [dw-1:0] mem[dl-1:0];  // 2D array for memory

    // Assign intr, with proper index casting for addr
    assign intr = rst ? 32'b0 : mem[addr[9:0]]; // Using only the lower 10 bits to index the memory (1024 entries)

	 initial begin
    $readmemh("program_dump.hex", mem);
  end

endmodule
