
module PC(
    input clk,
    input reset,
    input [31:0] branch_target,
    input [31:0] jump_target,
    input branch,
    input jump,
    output reg [31:0] pc_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 0;
        else if (jump)
            pc_out <= jump_target;
        else if (branch)
            pc_out <= branch_target;
        else
            pc_out <= pc_out + 4;
    end
endmodule
