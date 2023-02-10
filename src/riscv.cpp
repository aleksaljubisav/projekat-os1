//
// Created by os on 5/27/22.
//

#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../lib/console.h"
#include "../h/tcb.h"
#include "../h/print.hpp"

void Riscv::popSppSpie()
{
    Riscv::mc_sstatus(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra"); // zbog ovoga nije smelo da bude inline!!!
    __asm__ volatile("sret"); // sret ce da popuje ove dve stvari
    // zelimo da se vratimo tamo gde ce ova funkcija i biti pozvana, na pocetak threadWrapper-a
}

void Riscv::handleSupervisorTrap()
{
    uint64 scause = r_scause();
    if(scause == 0x0000000000000009UL)
    {
        // interrupt: no, cause code: environment call from S-mode (9)
        // sepc dobija vrednost SAME ECALL INSTRUKCIJE!!!
        uint64 sepc = r_sepc() + 4; //sve instrukcije su 4 bajta, pa ne treba da se vratimo na ecall, nego na instr. iza njega
        uint64 sstatus = r_sstatus();
        TCB::timeSliceCounter = 0;
        TCB::dispatch();
        w_sstatus(sstatus);
        w_sepc(sepc);
    } else if(scause == 0x0000000000000008UL)
    {
        // interrupt: no, cause code: environment call from U-mode (8)
        // sepc dobija vrednost SAME ECALL INSTRUKCIJE!!!
        uint64 sepc = r_sepc() + 4; //sve instrukcije su 4 bajta, pa ne treba da se vratimo na ecall, nego na instr. iza njega
        uint64 sstatus = r_sstatus();
        TCB::timeSliceCounter = 0;
        TCB::dispatch();
        w_sstatus(sstatus);
        w_sepc(sepc);
    } else if(scause == 0x8000000000000001UL)
    {
        // interrupt: yes, cause code: supervisor software interrupt (timer)
        TCB::timeSliceCounter++;
        if(TCB::timeSliceCounter >= TCB::running->getTimeslice())
        {
            uint64 sepc = r_sepc(); // u sepc se vraca prekidna rutina
            uint64 sstatus = r_sstatus();
            TCB::timeSliceCounter = 0;
            TCB::dispatch();
            // prvi put kad se nit izvrsava, necemo nastavljati ovuda, zbog toga u popSppSpie ima sret
            w_sstatus(sstatus);
            w_sepc(sepc); // nova nit je nekad pre sacuvala svoje sepc
        }
        mc_sip(SIP_SSIP);
    } else if(scause == 0x8000000000000009UL)
    {
        // interrupt: yes, cause code: supervisor external interrupt (console)
        console_handler();
    } else {
        // unexpected trap cause (trebalo bi da ispisemo scause na terminal, stval i sepc)
        printString("\n SCAUSE: ");
        printInteger(scause);
        printString("\n STVAL: ");
        printInteger(r_stval());
        printString("\n SEPC: ");
        printInteger(r_sepc());
        printString("\n");
    }

    /*
    if(scause == 0x0000000000000009UL)
    {
        // interrupt: no, cause code: environment call from S-mode (9)
        __asm__ volatile("csrr s1, sepc");
        __asm__ volatile("addi s1, s1, 4");
        __asm__ volatile("csrw sepc, s1"); // sepc dobija vrednost same ecall instrukcije

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
    */
}