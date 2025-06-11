module program_counter #(parameter n =32) (
     input  logic clk,
    input  logic rst,                    //sync_ff
	 
    input  logic [n-1:0] pc_next,
    output logic [n-1:0] pc,output logic [n-1:0] pc_dup);

always_ff @(posedge clk) begin
    if (rst) begin
        pc <= '0;
    end else begin
        pc <= pc_next;
    end
end
assign pc_dup=pc;

endmodule