//
// Created by os on 5/29/22.
//

#include "../h/ccb.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/riscv.hpp"

// Preklapamo operatore da bismo mogli da kreiramo objekat bez syscall-a
void* CCB::operator new(size_t size)
{
    void* p = MemoryAllocator::getInstance().mem_alloc(size);
    return p;
}
void CCB::operator delete (void* p)
{
    MemoryAllocator::getInstance().mem_free(p);
}

CCB* CCB::running = nullptr;

CCB* CCB::createCoroutine(Body body, void* stack)
{
    return new CCB(body, stack); // nije iz syscall nego iz jezgra
}

void CCB::yield()
{
    Riscv::pushRegisters();
    dispatch();
    Riscv::popRegisters();
}

void CCB::dispatch()
{
    CCB *old = running;
    if(!old->isFinished()) { Scheduler::getInstance().put(old); }
    running = Scheduler::getInstance().get();

    CCB::contextSwitch(&old->context, &running->context);
}