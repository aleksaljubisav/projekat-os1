//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_TCB_H
#define PROJECT_BASE_REPOSITORY_TCB_H

#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/scheduler.h"
#include "../h/SleepList.h"
//class Scheduler;

// Thread Control Block
class TCB {
public:
    ~TCB() { if(stack) {MemoryAllocator::getInstance().mem_free((char*)stack - DEFAULT_STACK_SIZE);} }

    void* operator new(size_t size);
    void operator delete (void* p) noexcept;

    bool isFinished() const { return finished; }
    void setFinished(bool f) { TCB::finished = f; }
    uint64 getTimeslice() const { return timeslice; }

    using Body = void (*)(void*); //pokazivac na funkciju koja nema argumente i nema povratnu vrednost //sad ima arg
    Body getBody() const { return body; }

    static TCB* createThread(Body body, void* stack, void* args);
    static TCB* createThreadOnly(Body body, void* stack, void* args);
    static int scheduleThreadOnly(TCB* t);

    static void yield();
    void join(TCB* thr);

    static TCB* running;

    friend class Scheduler;
    friend class Sem;
    friend class SleepList;

    static TCB* idleThread;
    static void kProducer(void* arg);

private:
    TCB(Body body, void* st, uint64 timeslice, void* args) :
            next(nullptr),
            nextBlocked(nullptr),
            body(body),
            args(args),
            stack((uint64*)st), // pok. na posl. lok. (tehnicki na lok. nakon posl. za stek), u asembleru -8, a u C++-u -1 i onda se stavi elem
            context({   (uint64) &threadWrapper, /// vrednost za ra neka u pocetku bude body
                        stack!=nullptr ? (uint64)stack : 0 /// vec imam adresu na lok. nakon posl. za stek, tako da cemo to da cast-ujemo
                    }),
            timeslice(timeslice),
            finished(false),
            nextSleep(nullptr),
            prevSleep(nullptr),
            blocked(false),
            sleeping(false),
            sleepTime(0)
    {
        //if(body != nullptr) { Scheduler::getInstance().put(this); } // u dispatchu ce da ubaci main u scheduler, ne treba mi da ubacujemo ovde
        //prebacili smo u createThread
        //if(body == kProducer) priv = true;
        //else priv = false;
    }

    TCB* next;
    TCB* nextBlocked;

    struct Context //kontekst korutine treba da budu svi registri procesora koje je korutina potencijalno mogla da koristi
    {
        uint64 ra; //cuvamo makar u Context-u stack pointer, ali razumno je da se nadje tu ra
        uint64 sp;
    };
    Body body;
    void* args;
    uint64* stack; //niz 64-obitnih vrednosti (jer se na steku uglavnom nalaze vrednosti iz registara)
    Context context; //registre x3-x31 ne cuvamo u kontrolnoj strukturi Context, vec na samom steku ove korutine
    uint64 timeslice;
    bool finished;

    //bool priv;

    friend class Riscv;

    static void threadWrapper();

    static void contextSwitch(Context* oldContext, Context* runningContext);

    static void dispatch();

    static int sleep(time_t time);
    TCB* nextSleep; //za listu uspavanih niti
    TCB* prevSleep;

    static uint64 timeSliceCounter;
    static uint64 constexpr TIME_SLICE = DEFAULT_TIME_SLICE;

    bool blocked;
    bool sleeping;
    time_t sleepTime;

};


#endif //PROJECT_BASE_REPOSITORY_TCB_H
