//
// Created by os on 2/14/23.
//

#include "../h/Semaphore.h"
#include "../h/tcb.h"

// Preklapamo operatore da bismo mogli da kreiramo objekat bez syscall-a
void* Semaphore::operator new(size_t size)
{
    void* p = MemoryAllocator::getInstance().mem_alloc(size);
    return p;
}
void Semaphore::operator delete(void* p) noexcept
{
    MemoryAllocator::getInstance().mem_free(p);
}

void Semaphore::block () {
        TCB *old = TCB::running;
        put(old); //stavljamo u blocked queue

        TCB::running = Scheduler::getInstance().get();

        TCB::contextSwitch(&old->context, &TCB::running->context);
}
void Semaphore::unblock () {
    TCB* t = get();
    Scheduler::getInstance().put(t);
}
void Semaphore::wait () {
    if (--val<0) block();
}
void Semaphore::signal () {
    if (++val<=0) unblock();
}

TCB *Semaphore::get()
{
    if(!blockedQueueHead) { return nullptr; }

    TCB* cur = blockedQueueHead;
    blockedQueueHead = blockedQueueHead->next;
    if(!blockedQueueHead) { blockedQueueTail = nullptr; }

    cur->next = nullptr;/////////naknadno sam dodao
    return cur;
}
void Semaphore::put(TCB *ccb)
{
    if(blockedQueueTail)
    {
        blockedQueueTail->next = ccb;
        blockedQueueTail = ccb;
    } else
    {
        blockedQueueHead = blockedQueueTail = ccb;
    }

}