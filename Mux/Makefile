TOPNAME = mux41
NXDC_FILES = constr/mux41.nxdc
INC_PATH ?=

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc -O3 --x-assign fast --x-initial fast --noassert
VERILATOR_SIM_CFLAGS = $(VERILATOR_CFLAGS) --trace  # 仿真专用：启用波形跟踪

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN_SIM = $(BUILD_DIR)/$(TOPNAME)_sim  # 仿真可执行文件
BIN_FPGA = $(BUILD_DIR)/$(TOPNAME)_fpga  # FPGA 可执行文件

default: sim  # 默认构建仿真目标

$(shell mkdir -p $(BUILD_DIR))

# 自动绑定引脚
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_bind.cpp)
$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

# 源代码
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS_SIM = $(shell find $(abspath ./csrc) -name "main.cpp") $(SRC_AUTO_BIND)  # 仿真专用
CSRCS_FPGA = $(shell find $(abspath ./csrc) -name "fpga_test.cpp") $(SRC_AUTO_BIND)  # FPGA专用

# NVBoard 规则
include $(NVBOARD_HOME)/scripts/nvboard.mk

# 编译选项
INCFLAGS = $(addprefix -I, $(INC_PATH))
CXXFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(TOPNAME)\""

# 仿真目标：启用波形跟踪
sim: $(VSRCS) $(CSRCS_SIM) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_SIM_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CXXFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN_SIM))

# FPGA目标：不启用波形跟踪
fpga: $(VSRCS) $(CSRCS_FPGA) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME)  $^\
		$(addprefix -CFLAGS , $(CXXFLAGS)) \
		$(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN_FPGA))

# 运行仿真
run_sim: sim
	@$(BIN_SIM)

# 运行FPGA测试
run_fpga: fpga
	@$(BIN_FPGA)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: default sim fpga run_sim run_fpga clean