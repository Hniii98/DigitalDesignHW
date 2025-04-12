#include <nvboard.h>
#include <Vtop.h>
#include <chrono>

static Vtop top;

void nvboard_bind_all_pins(Vtop* top);

static void single_cycle() {
  top.clk = 0; top.eval();
  top.clk = 1; top.eval();
}

static void reset(int n) {
  top.rst = 1;
  while (n -- > 0) single_cycle();
  top.rst = 0;
}

int main() {
  nvboard_bind_all_pins(&top);
  nvboard_init();

  reset(10);

  auto last_time = std::chrono::steady_clock::now();
  auto cycle_duration = std::chrono::milliseconds(1000); // 每100ms一个周期

  while (1) {
      auto now = std::chrono::steady_clock::now();
      if (now - last_time >= cycle_duration) {
          single_cycle();  // 执行一个时钟周期
          last_time = now;
      }
      nvboard_update();   // 持续刷新界面（不阻塞）

    
  }
  
}

