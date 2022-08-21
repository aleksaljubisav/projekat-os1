//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_CCB_H
#define PROJECT_BASE_REPOSITORY_CCB_H

#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/scheduler.h"
//class Scheduler;

class CCB {
public:
    ~CCB() { MemoryAllocator::getInstance().mem_free((char*)stack - DEFAULT_STACK_SIZE); }

    void* operator new(size_t size);
    void operator delete (void* p) noexcept;

    bool isFinished() const { return finished; }
    void setFinished(bool f) { CCB::finished = f; }

    using Body = void (*)(); //pokazivac na funkciju koja nema argumente i nema povratnu vrednost
    static CCB* createCoroutine(Body body, void* stack);

    static void yield();

    static CCB* running;

    friend class Scheduler;
private:
    CCB(Body body, void* st) :
            body(body),
            stack((uint64*)st), // pok. na posl. lok. (tehnicki na lok. nakon posl. za stek), u asembleru -8, a u C++-u -1 i onda se stavi elem
            context({   (uint64)body,
                        (uint64)stack
                    }),
            finished(false)
    {
        if(body != nullptr) { Scheduler::getInstance().put(this); } // u dispatchu ce da ubaci main u scheduler, ne treba mi da ubacujemo ovde
    }

    CCB* next;

    struct Context //kontekst korutine treba da budu svi registri procesora koje je korutina potencijalno mogla da koristi
    {
        uint64 ra; //cuvamo makar u Context-u stack pointer, ali razumno je da se nadje tu ra
        uint64 sp;
    };
    Body body;
    uint64* stack; //niz 64-obitnih vrednosti (jer se na steku uglavnom nalaze vrednosti iz registara)
    Context context; //registre x3-x31 ne cuvamo u kontrolnoj strukturi Context, vec na samom steku ove korutine
    bool finished;

    static void contextSwitch(Context* oldContext, Context* runningContext);

    static void dispatch();
};


#endif //PROJECT_BASE_REPOSITORY_CCB_H
