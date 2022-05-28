#include "../h/MemoryAllocator.hpp"
#include "../lib/console.h"
#include "../lib/hw.h"
#include "../h/riscv.hpp"
#include "../h/print.hpp"

int main(){
    printString("ENTER\n");

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    __asm__ volatile("ecall");

    printString("EXIT\n");


    return 0;
}