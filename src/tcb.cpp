//
// Created by os on 5/29/22.
//

#include "../h/tcb.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.h"
#include "../test/printing.hpp"
#include "../h/printingSys.h"

typedef MemoryAllocator MA;

inline void ispisiListe() {
    printString("Free lista: ");
    for (MA::BlockHeader *cur = MA::getInstance().freeMemHead; cur; cur = cur->next) {
        printInt(cur->size);
        printString(" - ");
    }
    printString("\n");

    printString("Alloc lista: ");
    for (MA::BlockHeader *cur = MA::getInstance().allocMemHead; cur; cur = cur->next) {
        printInt(cur->size);
        printString(" - ");
    }
    printString("\n");
}

// Preklapamo operatore da bismo mogli da kreiramo objekat bez syscall-a
void* TCB::operator new(size_t size)
{
    void* p = MemoryAllocator::getInstance().mem_alloc(size);
    return p;
}
void TCB::operator delete(void* p) noexcept
{
    MemoryAllocator::getInstance().mem_free(p);
}

TCB* TCB::running = nullptr;

uint64 TCB::timeSliceCounter = 0;

TCB* TCB::createThread(Body body, void* stack, void* args)
{
    TCB* t = new TCB(body, stack, TIME_SLICE, args); // nije iz syscall nego iz jezgra
    if(body != nullptr && t != idleThread) { Scheduler::getInstance().put(t); }
    return t;
}

TCB* TCB::createThreadOnly(Body body, void* stack, void* args)
{
    return new TCB(body, stack, TIME_SLICE, args); // nije iz syscall nego iz jezgra
}
int TCB::scheduleThreadOnly(TCB* t)
{
    if(t->getBody() != nullptr) { Scheduler::getInstance().put(t); return 0;}
    return -1;
}

void TCB::join(TCB* thr)
{
    while( !( (thr)->isFinished() ) ) {
        dispatch();
    }
}

// extern "C" void pushRegisters();
    // tako mozemo da uvezemo ove funkcije
    // da CPP prevodilac zna da ne treba da vrsi name mangling da bi dobio ispravno ime
    // ali ipak cemo da radimo sa name mangling-om

void TCB::yield()
{
    // korutina je mozda koristila te registre pre nego sto je predala procesor,
    // i mozda ce ih koristiti nakon sto joj procesor bude vracen
    //Riscv::pushRegisters(); // cuvamo registre x3-x31 (one koje nismo cuvali u strukturi Context)
    //TCB::timeSliceCounter = 0;
    //dispatch();
    //Riscv::popRegisters();

    __asm__ volatile("ecall"); // exception
}

void TCB::dispatch()
{
    timeSliceCounter = 0;
    TCB *old = running;
    if(!old->isFinished() && old != idleThread && !old->blocked && !old->sleeping) {
        Scheduler::getInstance().put(old);
    }

    running = Scheduler::getInstance().get();

    if (running == nullptr || running == old) {
        running = idleThread;
    }

    TCB::contextSwitch(&old->context, &running->context);
    // za prvi parametar argument ce biti prosledjen kroz a0, a za drugi kroz a1
}

int TCB::sleep(time_t time)
{
    TCB* old = TCB::running;
    old->sleepTime = time;
    SleepList::getInstance().putSleeping(old);

    TCB::dispatch();

    return 0;
}

void TCB::threadWrapper()
{
    // Ovde smo jos uvek u prekidnoj rutini, tako da
    // mora pop nekih stvari iz statusnog registra:
    //  SPP, SPIE
    Riscv::popSppSpie();// MORA CALL INSTRUKCIJOM JER MENJA REGISTAR ra

    //sve ispod popSppSpie je user rezim
    running->body(running->args);
    thread_exit();

    //running->setFinished(true);
    //delete running;
    //yield();//TCB::yield();
    // threadWrapper nije pozvano na obican nacin, nema gde da se vrati
}

TCB* TCB::idleThread = nullptr;