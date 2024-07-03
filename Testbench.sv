
module testbench;
    reg clk;
    reg reset;
    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] rd1, rd2;
    wire [31:0] result;
    wire [31:0] dmem_rd;

    riscv_core core_inst(
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .instruction(instruction),
        .rd1(rd1),
        .rd2(rd2),
        .result(result),
        .dmem_rd(dmem_rd)
    );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);

        clk = 0;
        reset = 1;
        #5;
        reset = 0;
        #5;
        reset = 1;
        #10;

        // Run simulation for 1000 cycles
        repeat (1000) begin
            #5 clk = ~clk;
        end

        $finish;
    end
endmodule
