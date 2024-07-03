
module DMem(
    input clk,
    input we,
    input [31:0] addr,
    input [31:0] wd,
    output [31:0] rd
);
    reg [31:0] dmem [0:255];

    always @(posedge clk) begin
        if (we)
            dmem[addr[9:2]] <= wd;
    end

    assign rd = dmem[addr[9:2]];
endmodule
