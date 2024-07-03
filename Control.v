module Control(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] alu_ctrl,
    output reg we,
    output reg branch,
    output reg jump,
    output reg [1:0] alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg
);
    always @(*) begin
        we = 0;
        branch = 0;
        jump = 0;
        alu_src = 2'b00;
        mem_read = 0;
        mem_write = 0;
        mem_to_reg = 0;
        alu_ctrl = 4'b0000;

        case (opcode)
            7'b0110011: begin // R-type
                we = 1;
                case ({funct7, funct3})
                    10'b0000000000: alu_ctrl = 4'b0000; // ADD
                    10'b0100000000: alu_ctrl = 4'b1000; // SUB
                    10'b0000000001: alu_ctrl = 4'b0001; // SLL
                    10'b0000000010: alu_ctrl = 4'b0010; // SLT
                    10'b0000000011: alu_ctrl = 4'b0011; // SLTU
                    10'b0000000100: alu_ctrl = 4'b0100; // XOR
                    10'b0000000101: alu_ctrl = 4'b0101; // SRL
                    10'b0100000101: alu_ctrl = 4'b1101; // SRA
                    10'b0000000110: alu_ctrl = 4'b0110; // OR
                    10'b0000000111: alu_ctrl = 4'b0111; // AND
                    default: alu_ctrl = 4'b0000; // Default case to handle all other conditions
                endcase
            end
            7'b0010011: begin // I-type
                we = 1;
                alu_src = 2'b01;
                case (funct3)
                    3'b000: alu_ctrl = 4'b0000; // ADDI
                    3'b010: alu_ctrl = 4'b0010; // SLTI
                    3'b011: alu_ctrl = 4'b0011; // SLTIU
                    3'b100: alu_ctrl = 4'b0100; // XORI
                    3'b110: alu_ctrl = 4'b0110; // ORI
                    3'b111: alu_ctrl = 4'b0111; // ANDI
                    3'b001: alu_ctrl = 4'b0001; // SLLI
                    3'b101: begin
                        if (funct7 == 7'b0000000)
                            alu_ctrl = 4'b0101; // SRLI
                        else if (funct7 == 7'b0100000)
                            alu_ctrl = 4'b1101; // SRAI
                        else
                            alu_ctrl = 4'b0000; // Default case
                    end
                    default: alu_ctrl = 4'b0000; // Default case to handle all other conditions
                endcase
            end
            7'b0000011: begin // Load instructions
                we = 1;
                alu_src = 2'b01;
                alu_ctrl = 4'b0000; // ADD
                mem_read = 1;
                mem_to_reg = 1;
            end
            7'b0100011: begin // Store instructions
                alu_src = 2'b01;
                alu_ctrl = 4'b0000; // ADD
                mem_write = 1;
            end
            7'b1100011: begin // Branch instructions
                branch = 1;
                alu_src = 2'b00;
                case (funct3)
                    3'b000: alu_ctrl = 4'b1000; // BEQ
                    3'b001: alu_ctrl = 4'b1001; // BNE
                    3'b100: alu_ctrl = 4'b1010; // BLT
                    3'b101: alu_ctrl = 4'b1011; // BGE
                    3'b110: alu_ctrl = 4'b1100; // BLTU
                    3'b111: alu_ctrl = 4'b1101; // BGEU
                    default: alu_ctrl = 4'b0000; // Default case to handle all other conditions
                endcase
            end
            7'b1101111: begin // JAL
                we = 1;
                jump = 1;
                alu_src = 2'b10;
                alu_ctrl = 4'b0000; // ADD
            end
            7'b1100111: begin // JALR
                we = 1;
                jump = 1;
                alu_src = 2'b01;
                alu_ctrl = 4'b0000; // ADD
            end
            7'b0110111: begin // LUI
                we = 1;
                alu_src = 2'b10;
                alu_ctrl = 4'b0000; // ADD
            end
            7'b0010111: begin // AUIPC
                we = 1;
                alu_src = 2'b10;
                alu_ctrl = 4'b0000; // ADD
            end
            default: begin
                alu_ctrl = 4'b0000; // Default case to handle all other conditions
            end
        endcase
    end
endmodule
