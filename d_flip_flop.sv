module d_flip_flop (
    input  logic clk,   // Clock input
    input  logic reset, // Synchronous reset
    input  logic d,     // Data input
    output logic q      // Data output
);
    // Synchronous process using always_ff
    always_ff @(posedge clk) begin
        if (reset)
            q <= 1'b0;  // Reset value
        else
            q <= d;     // Latch input data
    end
endmodule
