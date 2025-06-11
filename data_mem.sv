module data_mem(
    input logic [31:0] ALU_result,   // Address from ALU
    input logic [31:0] rs2_data,     // Data to write to memory
    input logic mem_read,             // Read enable signal
    input logic mem_write,            // Write enable signal
    input logic clk,                  // Clock signal
    output logic [31:0] read_data     // Data read from memory
);

    // Memory definition: 32 locations, each 32-bits wide
    logic [31:0] data_mem [31:0];

    // Always block for memory read/write operations
    always_ff @(posedge clk) begin
        if (mem_read) begin
            // Perform read operation from memory at ALU_result address
            read_data <= data_mem[ALU_result];
        end
        else if (mem_write) begin
            // Perform write operation to memory at ALU_result address
            data_mem[ALU_result] <= rs2_data;
            read_data <= 32'b0;  // No data to read on write
        end
        else begin
            // Default read_data value when neither read nor write is active
            read_data <= 32'b0;
        end
    end

endmodule
