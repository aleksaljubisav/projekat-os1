#include "../h/MemoryAllocator.hpp"
//#include "../h/syscall_c.h"
#include "../h/riscv.hpp"
#include "../h/print.hpp"
#include "../lib/console.h"
#include "../h/tcb.h"
#include "../h/workers.h"
#include "../lib/hw.h"

typedef MemoryAllocator MA;

inline void ispisiListe()
{
    printString("Free lista: ");
    for(MA::BlockHeader* cur = MA::getInstance().freeMemHead; cur; cur = cur->next)
    {
        printInteger(cur->size);
        printString(" - ");
    }
    __putc('\n');

    printString("Alloc lista: ");
    for(MA::BlockHeader* cur = MA::getInstance().allocMemHead; cur; cur = cur->next)
    {
        printInteger(cur->size);
        printString(" - ");
    }
    __putc('\n');

}

void main()
{
    //ispisiListe();
    TCB* threads[5];

    threads[0] = TCB::createThread(nullptr, nullptr); /// alocira samo jedan blok od 64B za objekat klase
    // telo main korutine se vec izvrsava, ne treba da krene da se izvrsava od maina
    // main korutini ne treba stek jer ona implicitno vec ima stek na kom se izvrsava

    TCB::running = threads[0];

    //ispisiListe();

    threads[1] = TCB::createThread(workerBodyA, ((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE))); // MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE)
    printString("ThreadA created\n");
    //ispisiListe();
    threads[2] = TCB::createThread(workerBodyB, ((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));
    printString("ThreadB created\n");
    //ispisiListe();
    threads[3] = TCB::createThread(workerBodyC, ((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));
    printString("ThreadC created\n");
    //ispisiListe();
    threads[4] = TCB::createThread(workerBodyD, ((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));
    printString("ThreadD created\n");
    //ispisiListe();

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    while(!(threads[1]->isFinished() &&
            threads[2]->isFinished() &&
            threads[3]->isFinished() &&
            threads[4]->isFinished()   ))
    {
        TCB::yield();
    }

    for(auto &thread: threads)
    {
        //MA::getInstance().mem_free(coroutine);
        delete thread;
    }

    printString("Finished\n");
    //ispisiListe();

}

// u ispisivanju treba zabraniti prekide