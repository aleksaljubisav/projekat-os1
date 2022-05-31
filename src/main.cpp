#include "../h/riscv.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/syscall_c.h"
#include "../h/print.hpp"
#include "../lib/console.h"
#include "../h/ccb.h"
//#include "../h/workers.h"
#include "../lib/hw.h"

/*typedef MemoryAllocator MA;

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

}*/

void userMain();

void main()
{

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    userMain();

    /*ispisiListe();
    thread_t coroutines[3];

    thread_create(&coroutines[0], nullptr, nullptr);
    CCB::running = coroutines[0];

    ispisiListe();
    thread_create(&coroutines[1], workerBodyA, nullptr);
    printString("CoroutineA created\n");
    ispisiListe();
    thread_create(&coroutines[2], workerBodyB, nullptr);
    printString("CoroutineB created\n");
    ispisiListe();

    while (!(finishedA && finishedB))
        CCB::yield();

    for(auto &coroutine: coroutines)
    {
        //MA::getInstance().mem_free(coroutine);
        delete coroutine;
    }

    printString("Finished\n");
    ispisiListe();*/

}