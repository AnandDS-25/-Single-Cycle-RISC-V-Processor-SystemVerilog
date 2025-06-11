module mux_3to1 (
    input  logic [2:0] data_in, // 3-bit input vector (3 data inputs)
    input  logic [1:0] sel,     // 2-bit select signal
    output logic       data_out // Output of the MUX
);

    always_comb begin
        case (sel)
            2'b00: data_out = data_in[0]; // Select input 0
            2'b01: data_out = data_in[1]; // Select input 1
            2'b10: data_out = data_in[2]; // Select input 2
            default: data_out = 1'b0;     // Default case (can be modified as needed)
        endcase
    end

endmodule
