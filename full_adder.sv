module half_adder (
    input  logic a,      // First input bit
    input  logic b,      // Second input bit
    output logic sum,    // Sum output bit
    output logic carry   // Carry output bit
);
    // Sum is XOR of input bits
    assign sum = a ^ b;
    
    // Carry is AND of input bits
    assign carry = a & b;
endmodule
