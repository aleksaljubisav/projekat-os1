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

void Riscv::handleSupervisorTrap()
{
    uint64 scause = r_scause();
    if(scause == 0x0000000000000009UL) // interrupt: no, cause code: environment call from S-mode (9)
    {
        __asm__ volatile("csrr s1, sepc");
        __asm__ volatile("addi s1, s1, 4");
        __asm__ volatile("csrw sepc, s1");

        uint64 kod;
        __asm__ volatile("mv %0, a0" : "=r" (kod));

        if(kod == 0x01) // mem_alloc
        {
            /*size_t brojBlokova = a1;
            void* retValue = MemoryAllocator::getInstance().mem_alloc(brojBlokova * MEM_BLOCK_SIZE);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));*/
            size_t brojBlokova;
            __asm__ volatile("mv %0, a1" : "=r" (brojBlokova));
            void* retValue = MemoryAllocator::getInstance().mem_alloc(brojBlokova * MEM_BLOCK_SIZE);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
        } else if(kod == 0x02) // mem_free
        {
            /*void* pointer = (void*)a1;
            int retValue = MemoryAllocator::getInstance().mem_free(pointer);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));*/
            void* pointer;
            __asm__ volatile("mv %0, a1" : "=r" (pointer));
            int retValue = MemoryAllocator::getInstance().mem_free(pointer);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
        } else if(kod == 0x11) // thread_create
        {
            /*CCB** volatile handle = (CCB**)a1;
            using Body = void (*)(void*);
            Body volatile body = (Body)a2;
            void* volatile arg = (void*)a3;
            void* volatile stack_space = (void*)a4;
            *handle = CCB::createCoroutine(body, arg, stack_space);
            if(*handle != nullptr) __asm__ volatile("li a0, 0");
            else __asm__ volatile("li a0, -1");*/
            uint64 frame_pointer;
            __asm__ volatile("ld %0, -16(fp)" : "=r" (frame_pointer));
            CCB** handle;
            __asm__ volatile("ld %0, 11 * 8(%1)" : "=r" (handle) : "r" (frame_pointer));
            using Body = void (*)(void*);
            Body body;
            __asm__ volatile("ld %0, 12 * 8(%1)" : "=r" (body) : "r" (frame_pointer));
            void* arg;
            __asm__ volatile("ld %0, 13 * 8(%1)" : "=r" (arg) : "r" (frame_pointer));
            void* stack_space;
            __asm__ volatile("ld %0, 14 * 8(%1)" : "=r" (stack_space) : "r" (frame_pointer));
            *handle = CCB::createCoroutine(body, arg, stack_space);
            if(*handle != nullptr) __asm__ volatile("li a0, 0");
            else __asm__ volatile("li a0, -1");
        } else if(kod == 0x13)
        {
            uint64 sepc = r_sepc();
            uint64 sstatus = r_sstatus();
            CCB::dispatch();
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
    }
}