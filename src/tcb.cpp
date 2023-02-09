//
// Created by os on 5/29/22.
//

#include "../h/tcb.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/riscv.hpp"

// Preklapamo operatore da bismo mogli da kreiramo objekat bez syscall-a
void* TCB::operator new(size_t size)
{
    void* p = MemoryAllocator::getInstance().mem_alloc(size);
    return p;
}
void TCB::operator delete (void* p) noexcept
{
    MemoryAllocator::getInstance().mem_free(p);
}

TCB* TCB::running = nullptr;

TCB* TCB::createCoroutine(Body body, void* stack)
{
    return new TCB(body, stack); // nije iz syscall nego iz jezgra
}


// extern "C" void pushRegisters();
    // tako mozemo da uvezemo ove funkcije
    // da CPP prevodilac zna da ne treba da vrsi name mangling da bi dobio ispravno ime
    // ali ipak cemo da radimo sa name mangling-om

void TCB::yield()
{
    // korutina je mozda koristila te registre pre nego sto je predala procesor,
    // i mozda ce ih koristiti nakon sto joj procesor bude vracen
    Riscv::pushRegisters(); // cuvamo registre x3-x31 (one koje nismo cuvali u strukturi Context)
    dispatch();
    Riscv::popRegisters();
}

void TCB::dispatch()
{
    TCB *old = running;
    if(!old->isFinished()) { Scheduler::getInstance().put(old); }
    running = Scheduler::getInstance().get();

    TCB::contextSwitch(&old->context, &running->context);
    // za prvi parametar argument ce biti prosledjen kroz a0, a za drugi kroz a1
}