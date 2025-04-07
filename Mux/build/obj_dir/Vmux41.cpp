// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vmux41.h"
#include "Vmux41__Syms.h"

//============================================================
// Constructors

Vmux41::Vmux41(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vmux41__Syms(contextp(), _vcname__, this)}
    , X0{vlSymsp->TOP.X0}
    , X1{vlSymsp->TOP.X1}
    , X2{vlSymsp->TOP.X2}
    , X3{vlSymsp->TOP.X3}
    , Y{vlSymsp->TOP.Y}
    , F{vlSymsp->TOP.F}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vmux41::Vmux41(const char* _vcname__)
    : Vmux41(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vmux41::~Vmux41() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vmux41___024root___eval_debug_assertions(Vmux41___024root* vlSelf);
#endif  // VL_DEBUG
void Vmux41___024root___eval_static(Vmux41___024root* vlSelf);
void Vmux41___024root___eval_initial(Vmux41___024root* vlSelf);
void Vmux41___024root___eval_settle(Vmux41___024root* vlSelf);
void Vmux41___024root___eval(Vmux41___024root* vlSelf);

void Vmux41::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vmux41::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vmux41___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vmux41___024root___eval_static(&(vlSymsp->TOP));
        Vmux41___024root___eval_initial(&(vlSymsp->TOP));
        Vmux41___024root___eval_settle(&(vlSymsp->TOP));
    }
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vmux41___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vmux41::eventsPending() { return false; }

uint64_t Vmux41::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vmux41::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vmux41___024root___eval_final(Vmux41___024root* vlSelf);

VL_ATTR_COLD void Vmux41::final() {
    Vmux41___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vmux41::hierName() const { return vlSymsp->name(); }
const char* Vmux41::modelName() const { return "Vmux41"; }
unsigned Vmux41::threads() const { return 1; }
