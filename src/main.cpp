#include "../h/MemoryAllocator.hpp"
#include "../h/riscv.hpp"
//#include "../h/print.hpp"
#include "../lib/console.h"
#include "../h/tcb.h"
//#include "../h/workers.h"
#include "../lib/hw.h"
#include "../h/syscall_c.hpp"
#include "../test/printing.hpp"

typedef MemoryAllocator MA;
extern void userMain(void*);

inline void ispisiListe()
{
    printString("Free lista: ");
    for(MA::BlockHeader* cur = MA::getInstance().freeMemHead; cur; cur = cur->next)
    {
        printInt(cur->size);
        printString(" - ");
    }
    printString("\n");

    printString("Alloc lista: ");
    for(MA::BlockHeader* cur = MA::getInstance().allocMemHead; cur; cur = cur->next)
    {
        printInt(cur->size);
        printString(" - ");
    }
    printString("\n");

}

void main()
{
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    TCB* threads[2];

    threads[0] = TCB::createThread(nullptr, nullptr, nullptr);
    TCB::running = threads[0];

    threads[1] = TCB::createThread(userMain, ((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)), nullptr);
    printString("Thread userMain created\n");

    while(!(threads[1]->isFinished()))
    {
        TCB::yield();
    }

    //vracanje u sistemski rezim
    __asm__ volatile("li a0, 0xFF");
    __asm__ volatile("ecall");

    delete threads[0];
    delete threads[1];
    /*for(auto &thread: threads)
    {
        //MA::getInstance().mem_free(coroutine);
        delete thread;
    }*/

    printString("Finished\n");
    ispisiListe();

    /*
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    ispisiListe();
    TCB* threads[5];

    threads[0] = TCB::createThread(nullptr, nullptr); /// alocira samo jedan blok od 64B za objekat klase
    // telo main korutine se vec izvrsava, ne treba da krene da se izvrsava od maina
    // main korutini ne treba stek jer ona implicitno vec ima stek na kom se izvrsava

    TCB::running = threads[0];

    ispisiListe();

    threads[1] = TCB::createThread(workerBodyA, ((void*)((char*)mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));//((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE))); // MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE)
    printString("ThreadA created\n");
    ispisiListe();
    threads[2] = TCB::createThread(workerBodyB, ((void*)((char*)mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));
    printString("ThreadB created\n");
    ispisiListe();
    threads[3] = TCB::createThread(workerBodyC, ((void*)((char*)mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));
    printString("ThreadC created\n");
    ispisiListe();
    threads[4] = TCB::createThread(workerBodyD, ((void*)((char*)mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));
    printString("ThreadD created\n");
    ispisiListe();

    //Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    while(!(threads[1]->isFinished() &&
            threads[2]->isFinished() &&
            threads[3]->isFinished() &&
            threads[4]->isFinished()   ))
    {
        thread_dispatch();//TCB::yield();
    }

    for(auto &thread: threads)
    {
        //MA::getInstance().mem_free(coroutine);
        delete thread;
    }

    printString("Finished\n");
    ispisiListe();
     */
}

// u ispisivanju treba zabraniti prekide