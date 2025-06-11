module half_adder (
    input logic [31:0] a,      // First input bit
    input logic [31:0] b,      // Second input bit
    output logic [31:0] sum    // Sum output bit
   
);
    // Sum is XOR of input bits
    assign sum = a + b;

endmodule
