// File: tb_top_module.cpp
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vriscv_core.h"

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    Vriscv_core *top = new Vriscv_core;
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("waveform.vcd");

    // Set initial state
    top->clk = 0;
    top->reset = 1;
    top->eval();
    tfp->dump(0);

    // Simulate clock cycles
    for (int i = 0; i < 1000; ++i) {
        top->clk = !top->clk;
        if (i == 10) top->reset = 0; // Deassert reset after some cycles
        top->eval();
        tfp->dump(i * 10);
    }

    // Finish simulation
    tfp->close();
    delete top;
    return 0;
}
