
module RegisterFile(
    input clk,
    input we,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] wd,
    output [31:0] rd1,
    output [31:0] rd2
);
    reg [31:0] rf [0:31];

    always @(posedge clk) begin
        if (we && rd != 5'b00000)
            rf[rd] <= wd;
    end

    assign rd1 = rf[rs1];
    assign rd2 = rf[rs2];
endmodule
