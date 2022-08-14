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
    void operator delete (void* p);

    bool isFinished() const { return finished; }
    void setFinished(bool f) { CCB::finished = f; }

    using Body = void (*)();

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
        if(body != nullptr) { Scheduler::getInstance().put(this); }
    }

    CCB* next;
    struct Context
    {
        uint64 ra;
        uint64 sp;
    };
    Body body;
    uint64* stack;
    Context context;
    bool finished;

    static void contextSwitch(Context* oldContext, Context* runningContext);

    static void dispatch();
};


#endif //PROJECT_BASE_REPOSITORY_CCB_H
