
module Fetch(
    input [31:0] pc,
    output [31:0] instruction
);
    reg [31:0] imem [0:255];
    initial begin
        // Load instructions from the hex file imem
        $readmemh("instructions.hex", imem); 
    end
    assign instruction = imem[pc[9:2]];

    /* verilator lint_off UNUSED due to issues in verilation on terminal */
    wire [21:0] unused_pc_bits = pc[31:10];
    wire unused_pc_bit_1 = pc[1];
    wire unused_pc_bit_0 = pc[0];
    /* verilator lint_on UNUSED */
endmodule
