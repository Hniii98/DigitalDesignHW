#include <nvboard.h>
#include <Vtop.h>

static Vtop top;

void nvboard_bind_all_pins(Vtop* top);

static void single_cycle() {
  top.clk = 0; top.eval();
  top.clk = 1; top.eval();
}

static void reset(int n) {
  top.clrn = 0;
  while (n -- > 0) single_cycle();
  top.clrn = 1;
}

int main() {
  nvboard_bind_all_pins(&top);
  nvboard_init();

  reset(10);

  while(1) {
    nvboard_update();
    single_cycle();
  }

  nvboard_quit();
  
}