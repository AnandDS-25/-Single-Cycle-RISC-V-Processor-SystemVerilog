module mux (
    input  logic a,        // Input a
    input  logic b,        // Input b
    input  logic sel,      // Select signal
    output logic y         // Output
);
    always_comb
	
	begin
        if (sel)
            y = b;         // Select b if sel is 1
        else
            y = a;         // Select a if sel is 0
    end
endmodule
