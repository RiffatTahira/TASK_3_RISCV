
module ALU(
    input [31:0] op1,
    input [31:0] op2,
    input [3:0] alu_ctrl,
    output reg [31:0] result
);
    always @(*) begin
        case (alu_ctrl)
            4'b0000: result = op1 + op2;  // ADD
            4'b1000: result = op1 - op2;  // SUB
            4'b0001: result = op1 << op2; // SLL
            4'b0010: result = (op1 < op2) ? 1 : 0; // SLT
            4'b0011: result = (op1 < op2) ? 1 : 0; // SLTU
            4'b0100: result = op1 ^ op2;  // XOR
            4'b0101: result = op1 >> op2; // SRL
            4'b1101: result = op1 >>> op2; // SRA
            4'b0110: result = op1 | op2;  // OR
            4'b0111: result = op1 & op2;  // AND
            default: result = 0;
        endcase
    end
endmodule
