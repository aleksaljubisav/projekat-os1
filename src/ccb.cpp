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
void CCB::operator delete (void* p) noexcept
{
    MemoryAllocator::getInstance().mem_free(p);
}

CCB* CCB::running = nullptr;

CCB* CCB::createCoroutine(Body body, void* stack)
{
    return new CCB(body, stack); // nije iz syscall nego iz jezgra
}


// extern "C" void pushRegisters();
    // tako mozemo da uvezemo ove funkcije
    // da CPP prevodilac zna da ne treba da vrsi name mangling da bi dobio ispravno ime
    // ali ipak cemo da radimo sa name mangling-om

void CCB::yield()
{
    // korutina je mozda koristila te registre pre nego sto je predala procesor,
    // i mozda ce ih koristiti nakon sto joj procesor bude vracen
    Riscv::pushRegisters(); // cuvamo registre x3-x31 (one koje nismo cuvali u strukturi Context)
    dispatch();
    Riscv::popRegisters();
}

void CCB::dispatch()
{
    CCB *old = running;
    if(!old->isFinished()) { Scheduler::getInstance().put(old); }
    running = Scheduler::getInstance().get();

    CCB::contextSwitch(&old->context, &running->context);
    // za prvi parametar argument ce biti prosledjen kroz a0, a za drugi kroz a1
}