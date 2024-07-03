
module riscv_core(
    input clk,
    input reset,
    output [31:0] pc_out,
    output [31:0] instruction,
    output [31:0] rd1, rd2,
    output [31:0] result,
    output [31:0] dmem_rd
);
    wire [4:0] rs1, rs2, rd;
    wire [31:0] imm;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [3:0] alu_ctrl;
    wire we, branch, jump;
    wire [1:0] alu_src;
    wire mem_read, mem_write, mem_to_reg;

    PC pc_inst(
        .clk(clk),
        .reset(reset),
        .branch_target(32'b0), 
        .jump_target(32'b1),   
        .branch(branch),
        .jump(jump),
        .pc_out(pc_out)
    );

    Fetch fetch_inst(
        .pc(pc_out),
        .instruction(instruction)
    );

    Decode decode_inst(
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .imm(imm),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );

    RegisterFile rf_inst(
        .clk(clk),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(result),
        .rd1(rd1),
        .rd2(rd2)
    );

    ALU alu_inst(
        .op1(rd1),
        .op2(rd2),
        .alu_ctrl(alu_ctrl),
        .result(result)
    );

    DMem dmem_inst(
        .clk(clk),
        .we(mem_write),
        .addr(result),
        .wd(rd2),
        .rd(dmem_rd)
    );

    Control control_inst(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl),
        .we(we),
        .branch(branch),
        .jump(jump),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg)
    );

 
endmodule
