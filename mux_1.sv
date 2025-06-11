module mux_1 (
    input logic[31:0] a,        // Input a
    input  logic[31:0] b,        // Input b
    input  logic sel,      // Select signal
    output logic[31:0] y         // Output
);
    always_comb
	
	begin
        if (sel)
            y = b;         // Select b if sel is 1
        else
            y = a;         // Select a if sel is 0
    end
endmodule
