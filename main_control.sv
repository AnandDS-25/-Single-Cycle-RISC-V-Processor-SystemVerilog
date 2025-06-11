module main_control (
    input logic [6:0] opcode,
    output logic [1:0] aluop,
    output logic branch,
    output logic mread,
    output logic mwrite,
    output logic alusrc,
    output logic memtoreg,
    output logic regwrite
);

always_comb begin
    case (opcode)
        7'b0110011: begin // R-type
            branch = 0;
            mread = 0;
            mwrite = 0;
            regwrite = 1;
            alusrc = 0;
            memtoreg = 0;
            aluop = 2'b10;
        end

        7'b0010011: begin // I-type
            branch = 0;
            mread = 0;
            mwrite = 0;
            regwrite = 1;
            alusrc = 1;
            memtoreg = 0;
            aluop = 2'b00;
        end

        7'b0000011: begin // Load
            branch = 0;
            mread = 1;
            mwrite = 0;
            regwrite = 1;
            alusrc = 1;
            memtoreg = 1;
            aluop = 2'b00;
        end

        7'b0100011: begin // Store-type
            branch = 0;
            mread = 0;
            mwrite = 1;
            regwrite = 0;
            alusrc = 1;
            memtoreg = 0;
            aluop = 2'b00;
        end

        7'b1100011: begin // Branch-type (e.g., BEQ)
            branch = 1;
            mread = 0;
            mwrite = 0;
            regwrite = 0;
            alusrc = 0;
            memtoreg = 0;
            aluop = 2'b01;
        end

        default: begin // Default case to avoid latches
            branch = 0;
            mread = 0;
            mwrite = 0;
            regwrite = 0;
            alusrc = 0;
            memtoreg = 0;
            aluop = 2'b00;
        end
    endcase
end

endmodule
