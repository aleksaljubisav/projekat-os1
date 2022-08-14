//
// Created by os on 5/27/22.
//

#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.hpp"
//#include "../h/tcb.hpp"
//#include "../lib/console.h"

/*void Riscv::popSppSpie()
{
    __asm__ volatile("csrw sepc, ra"); // zbog ovoga nije smelo da bude inline!!!
    __asm__ volatile("sret"); // sret ce da popuje ove dve stvari
    // zelimo da se vratimo tamo gde ce ova funkcija i biti pozvana, na pocetak threadWrapper-a
}*/

void Riscv::handleSupervisorTrap()
{
    uint64 scause = r_scause();
    if(scause == 0x0000000000000009UL)
    {
        // interrupt: no, cause code: environment call from S-mode (9)
        __asm__ volatile("csrr s1, sepc");
        __asm__ volatile("addi s1, s1, 4");
        __asm__ volatile("csrw sepc, s1");

        uint64 kod;
        __asm__ volatile("mv %0, a0" : "=r" (kod));
        if(kod == 0x01)
        {
            size_t brojBlokova;
            __asm__ volatile("mv %0, a1" : "=r" (brojBlokova));
            void* retValue = MemoryAllocator::getInstance().mem_alloc(brojBlokova * MEM_BLOCK_SIZE);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
        } else if(kod == 0x02)
        {
            void* pointer;
            __asm__ volatile("mv %0, a1" : "=r" (pointer));
            int retValue = MemoryAllocator::getInstance().mem_free(pointer);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
        }
    }
}