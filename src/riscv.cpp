//
// Created by os on 5/27/22.
//

#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/ccb.h"
//#include "../lib/console.h"

/*void Riscv::popSppSpie()
{
    __asm__ volatile("csrw sepc, ra"); // zbog ovoga nije smelo da bude inline!!!
    __asm__ volatile("sret"); // sret ce da popuje ove dve stvari
    // zelimo da se vratimo tamo gde ce ova funkcija i biti pozvana, na pocetak threadWrapper-a
}*/

void Riscv::handleSupervisorTrap(unsigned long a0, unsigned long a1, unsigned long a2, unsigned long a3, unsigned long a4)
{
    uint64 scause = r_scause();
    if(scause == 0x0000000000000009UL) // interrupt: no, cause code: environment call from S-mode (9)
    {
        __asm__ volatile("csrr s1, sepc");
        __asm__ volatile("addi s1, s1, 4");
        __asm__ volatile("csrw sepc, s1");

        uint64 kod = a0;
        //__asm__ volatile("mv %0, a0" : "=r" (kod));

        if(kod == 0x01) // mem_alloc
        {
            size_t brojBlokova = a1;
            void* retValue = MemoryAllocator::getInstance().mem_alloc(brojBlokova * MEM_BLOCK_SIZE);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
            /*size_t brojBlokova;
            __asm__ volatile("mv %0, a1" : "=r" (brojBlokova));
            void* retValue = MemoryAllocator::getInstance().mem_alloc(brojBlokova * MEM_BLOCK_SIZE);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));*/
        } else if(kod == 0x02) // mem_free
        {
            void* pointer = (void*)a1;
            int retValue = MemoryAllocator::getInstance().mem_free(pointer);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
            /*void* pointer;
            __asm__ volatile("mv %0, a1" : "=r" (pointer));
            int retValue = MemoryAllocator::getInstance().mem_free(pointer);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));*/
        } else if(kod == 0x11) // thread_create
        {
            CCB** handle = (CCB**)a1;
            using Body = void (*)(void*);
            Body body = (Body)a2;
            void* arg = (void*)a3;
            void* stack_space = (void*)a4;
            *handle = CCB::createCoroutine(body, arg, stack_space);
            __asm__ volatile("li a0, 1");///////////////////////
            /*CCB** handle;
            __asm__ volatile("mv %0, a1" : "=r" (handle));
            using Body = void (*)(void*);
            Body body;
            __asm__ volatile("mv %0, a2" : "=r" (body));
            void* arg;
            __asm__ volatile("mv %0, a3" : "=r" (arg));
            void* stack_space;
            __asm__ volatile("mv %0, a4" : "=r" (stack_space));*/
            *handle = CCB::createCoroutine(body, arg, stack_space);
        }
    }
}