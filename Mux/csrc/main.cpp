#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vmux41.h"
#include <stdio.h>
#include <sys/stat.h>


VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
static Vmux41* top;

void step_and_dump_wave() {
    top->eval();
    contextp->timeInc(1);
    tfp->dump(contextp->time());
}

void sim_init() {
    contextp = new VerilatedContext;
    tfp = new VerilatedVcdC;
    top = new Vmux41;
    contextp->traceEverOn(true);
    top->trace(tfp, 99);
    tfp->open("dump.vcd");
}

void sim_exit() {
    step_and_dump_wave();
    tfp->close();
    delete top;
    delete tfp;
    delete contextp;
}

int main() {
    sim_init();

    // Initial assignments
    top->X0 = 0b00; top->X1 = 0b01; 
    top->X2 = 0b10; top->X3 = 0b11;
    
    printf("Testing Y=0...\n");
    top->Y = 0b00;
    step_and_dump_wave();
    printf("X0=%d, X1=%d, X2=%d, X3=%d, Y=%d, F=%d\n", 
           top->X0, top->X1, top->X2, top->X3, top->Y, top->F);
    assert(top->F == 0b00);
    
    printf("Testing Y=1...\n");
    top->Y = 0b01;
    step_and_dump_wave();
    printf("X0=%d, X1=%d, X2=%d, X3=%d, Y=%d, F=%d\n", 
           top->X0, top->X1, top->X2, top->X3, top->Y, top->F);
    assert(top->F == 0b01);
    
    printf("Testing Y=2...\n");
    top->Y = 0b10;
    step_and_dump_wave();
    printf("X0=%d, X1=%d, X2=%d, X3=%d, Y=%d, F=%d\n", 
           top->X0, top->X1, top->X2, top->X3, top->Y, top->F);
    assert(top->F == 0b10);
    
    printf("Testing Y=3...\n");
    top->Y = 0b11;
    step_and_dump_wave();
    printf("X0=%d, X1=%d, X2=%d, X3=%d, Y=%d, F=%d\n", 
           top->X0, top->X1, top->X2, top->X3, top->Y, top->F);
    assert(top->F == 0b11);

    printf("Simulation completed successfully\n");
    sim_exit();

    return 0;
}