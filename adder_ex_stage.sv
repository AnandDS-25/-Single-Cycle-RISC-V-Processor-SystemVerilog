module adder_ex_stage (
    input logic [31:0] a,         // First input
    input logic [31:0] b,         // Second input
    output logic [31:0] y         // Sum output
);
    assign y = a + b;
endmodule