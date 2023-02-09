#include "../h/MemoryAllocator.hpp"
#include "../h/syscall_c.h"
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
    ispisiListe();
    TCB* coroutines[3];

    coroutines[0] = TCB::createCoroutine(nullptr, nullptr); /// alocira samo jedan blok od 64B za objekat klase
    // telo main korutine se vec izvrsava, ne treba da krene da se izvrsava od maina
    // main korutini ne treba stek jer ona implicitno vec ima stek na kom se izvrsava

    TCB::running = coroutines[0];

    ispisiListe();

    coroutines[1] = TCB::createCoroutine(workerBodyC, ((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE))); // MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE)
    printString("CoroutineA created\n");
    ispisiListe();
    coroutines[2] = TCB::createCoroutine(workerBodyD, ((void*)((char*)MA::getInstance().mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE)));
    printString("CoroutineB created\n");
    ispisiListe();

    while(!(coroutines[1]->isFinished() &&
            coroutines[2]->isFinished() ))
    {
        TCB::yield();
    }

    for(auto &coroutine: coroutines)
    {
        //MA::getInstance().mem_free(coroutine);
        delete coroutine;
    }

    printString("Finished\n");
    ispisiListe();

}