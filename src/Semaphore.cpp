//
// Created by os on 2/14/23.
//

#include "../h/Semaphore.h"
#include "../h/tcb.h"

// Preklapamo operatore da bismo mogli da kreiramo objekat bez syscall-a
void* Sem::operator new(size_t size)
{
    void* p = MemoryAllocator::getInstance().mem_alloc(size);
    return p;
}
void Sem::operator delete(void* p) noexcept
{
    //deblokirati sve niti
    MemoryAllocator::getInstance().mem_free(p);
}

void Sem::block () {
        TCB *old = TCB::running;
        old->blocked = true;
        put(old); //stavljamo u blocked queue

        TCB::dispatch();

}
void Sem::unblock () {
    TCB* t = get();
    t->blocked = false;
    Scheduler::getInstance().put(t);
}
void Sem::wait () {
    if (--val<0) {
        block();
    }
}
int Sem::signal () {
    if (++val<=0) unblock();
    return 0;
}

TCB *Sem::get()
{
    if(!blockedQueueHead) { return nullptr; }

    TCB* cur = blockedQueueHead;
    blockedQueueHead = blockedQueueHead->nextBlocked;
    if(!blockedQueueHead) { blockedQueueTail = nullptr; }

    cur->nextBlocked = nullptr;/////////naknadno sam dodao
    return cur;
}
void Sem::put(TCB *ccb)
{
    if(blockedQueueTail)
    {
        blockedQueueTail->nextBlocked = ccb;
        blockedQueueTail = ccb;
    } else
    {
        blockedQueueHead = blockedQueueTail = ccb;
    }

}


//Iz block je bilo:
//TCB::yield(); mislim da ne moze yield

/*
TCB *old = TCB::running;
put(old); //stavljamo u blocked queue

TCB::running = Scheduler::getInstance().get();
if (TCB::running == nullptr) {
    TCB::running = TCB::idleThread;
}
TCB::contextSwitch(&old->context, &TCB::running->context);
 */