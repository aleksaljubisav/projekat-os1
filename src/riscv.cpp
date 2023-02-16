//
// Created by os on 5/27/22.
//

#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../lib/console.h"
#include "../h/tcb.h"
//#include "../h/print.hpp"
#include "../test/printing.hpp"
#include "../h/syscall_c.hpp"
#include "../h/Semaphore.h"


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
    if(scause == 0x0000000000000008UL) {
        // interrupt: no, cause code: environment call from U-mode (8)
        uint64 sepc = r_sepc() + 4; //sve instrukcije su 4 bajta, pa ne treba da se vratimo na ecall, nego na instr. iza njega
        uint64 kod;
        __asm__ volatile("mv %0, a0" : "=r" (kod));
        if (kod == 0x01) {
            size_t brojBlokova;
            __asm__ volatile("mv %0, a1" : "=r" (brojBlokova));
            uint64 retValue = (uint64) MemoryAllocator::getInstance().mem_alloc(brojBlokova * MEM_BLOCK_SIZE);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
        } else if (kod == 0x02) {
            void *pointer;
            __asm__ volatile("mv %0, a1" : "=r" (pointer));
            int retValue = MemoryAllocator::getInstance().mem_free(pointer);
            __asm__ volatile("mv a0, %0" : : "r" (retValue));
        } else if(kod == 0x0E) // thread(tcb)_delete_only
        {
            TCB** handle;
            __asm__ volatile("mv %0, a1" : "=r" (handle));

            delete *handle;

        } else if(kod == 0x0F) // thread_create_only
        {
            void* args;
            __asm__ volatile("mv %0, a3" : "=r" (args));
            TCB::Body body;
            __asm__ volatile("mv %0, a2" : "=r" (body));
            TCB** handle;
            __asm__ volatile("mv %0, a1" : "=r" (handle));

            void* stek = MemoryAllocator::getInstance().mem_alloc(DEFAULT_STACK_SIZE);
            if (!stek)
            {
                __asm__ volatile("li a0, -1");
            } else {
                (*handle) = (TCB::createThreadOnly(body, ((void *) ((char *)stek + DEFAULT_STACK_SIZE)), args));
                __asm__ volatile("li a0, 0");
            }
        } else if(kod == 0x10) // thread_schedule_only
        {
            TCB** handle;
            __asm__ volatile("mv %0, a1" : "=r" (handle));

            int provera = (TCB::scheduleThreadOnly(*handle));
            __asm__ volatile("mv a0, %0": : "r" (provera));

        } else if(kod == 0x11) // thread_create
        {
            void* args;
            __asm__ volatile("mv %0, a3" : "=r" (args));
            TCB::Body body;
            __asm__ volatile("mv %0, a2" : "=r" (body));
            TCB** handle;
            __asm__ volatile("mv %0, a1" : "=r" (handle));

            void* stek = MemoryAllocator::getInstance().mem_alloc(DEFAULT_STACK_SIZE);
            if (!stek)
            {
                __asm__ volatile("li a0, -1");
            } else {
                (*handle) = (TCB::createThread(body, ((void *) ((char *)stek + DEFAULT_STACK_SIZE)), args));
                __asm__ volatile("li a0, 0");
            }
        } else if(kod == 0x12) //18 to je thread_exit
        {
            uint64 sstatus = r_sstatus();
            TCB::running->setFinished(true);
            TCB::dispatch();
            w_sstatus(sstatus);
        } else if(kod == 0x13) //19 to je thread_dispatch
        {
            uint64 sstatus = r_sstatus();
            TCB::timeSliceCounter = 0;
            TCB::dispatch();
            w_sstatus(sstatus);

        } else if(kod == 0x21) // sem_open
        {
            Semaphore** handle;
            __asm__ volatile("mv %0, a1" : "=r" (handle));
            unsigned init;
            __asm__ volatile("mv %0, a2" : "=r" (init));


            (*handle) = new Semaphore(init);
            int provera;
            if(!(*handle)) { provera = -1; }
            else { provera = 0; }
            __asm__ volatile("mv a0, %0": : "r" (provera));

        } else if(kod == 0x22) // sem_close
        {
            Semaphore** handle;
            __asm__ volatile("mv %0, a1" : "=r" (handle));

            delete *handle; //JA MISLIM DA U DESKRIPTORU TREBAJU SVE NITI DA SE DEBLOKIRAJU

            int provera = 0;
            __asm__ volatile("mv a0, %0": : "r" (provera));

        } else if(kod == 0x23) // sem_wait
        {
            uint64 sstatus = r_sstatus();
            Semaphore** id;
            __asm__ volatile("mv %0, a1" : "=r" (id));

            (*id)->wait(); //treba da vrati 0 ili negativnu vrednost

            int provera = 0;
            __asm__ volatile("mv a0, %0": : "r" (provera));
            w_sstatus(sstatus);
        } else if(kod == 0x24) // sem_signal
        {
            uint64 sstatus = r_sstatus();
            Semaphore** id;
            __asm__ volatile("mv %0, a1" : "=r" (id));

            (*id)->signal(); //treba da vrati 0 ili negativnu vrednost

            int provera = 0;
            __asm__ volatile("mv a0, %0": : "r" (provera));
            w_sstatus(sstatus);
        } else if(kod == 0xFF) // vracanje u sistemski rezim na kraju main-a
        {
            Riscv::ms_sstatus(Riscv::SSTATUS_SPP);

        } else { // Yield iz U-mode
            /*printString("\n Yield, a ne thread_dispatch() \n SCAUSE: ");
            printInt(scause);
            printString("\n STVAL: ");
            printInt(r_stval());
            printString("\n SEPC: ");
            printInt(r_sepc());
            printString("\n");*/
            uint64 sstatus = r_sstatus();
            TCB::timeSliceCounter = 0;
            TCB::dispatch();
            w_sstatus(sstatus);
        }
        w_sepc(sepc);
    } else if(scause == 0x0000000000000009UL) // Yield iz S-mode
    {
        // interrupt: no, cause code: environment call from S-mode (9)
        // slicno kao i za prekid od tajmera, samo sto je ovo za yield

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
        TCB::timeSliceCounter++;/*
        if(TCB::timeSliceCounter >= TCB::running->getTimeslice())
        {
            uint64 sepc = r_sepc(); // u sepc se vraca prekidna rutina
            uint64 sstatus = r_sstatus();
            TCB::timeSliceCounter = 0;
            TCB::dispatch();
            // prvi put kad se nit izvrsava, necemo nastavljati ovuda, zbog toga u popSppSpie ima sret
            w_sstatus(sstatus);
            w_sepc(sepc); // nova nit je nekad pre sacuvala svoje sepc
        }*/
        mc_sip(SIP_SSIP);
    } else if(scause == 0x8000000000000009UL)
    {
        // interrupt: yes, cause code: supervisor external interrupt (console)
        console_handler();
    } else {
        // unexpected trap cause (trebalo bi da ispisemo scause na terminal, stval i sepc)
        printString("\n SCAUSE: ");
        printInt(scause);
        printString("\n STVAL: ");
        printInt(r_stval());
        printString("\n SEPC: ");
        printInt(r_sepc());
        printString("\n");
    }

    /*
    if(scause == 0x0000000000000008UL)
    {
        // interrupt: no, cause code: environment call from U-mode (8)
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