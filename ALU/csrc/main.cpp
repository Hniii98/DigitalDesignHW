#include "verilated.h"
#include "Vtop.h"
#include <stdio.h>
#include <sys/stat.h>
#include <nvboard.h>

static Vtop* top;

void nvboard_bind_all_pins(Vtop* top);


int main() {
    
    top = new Vtop;
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