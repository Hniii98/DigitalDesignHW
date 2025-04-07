#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vmux41.h"
#include <stdio.h>
#include <sys/stat.h>
#include <nvboard.h>

static Vmux41* top;

void nvboard_bind_all_pins(Vmux41* top);


int main() {
    
    top = new Vmux41;
    nvboard_bind_all_pins(top);
    nvboard_init();
    

    while(1){
        top->eval();
        nvboard_update();
    }

    nvboard_quit();
    delete top;

    return 0;
}