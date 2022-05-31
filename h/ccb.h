//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_CCB_H
#define PROJECT_BASE_REPOSITORY_CCB_H

#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/scheduler.h"

class CCB {
public:
    ~CCB() { MemoryAllocator::getInstance().mem_free((char*)stack - DEFAULT_STACK_SIZE); }

    void* operator new(size_t size);
    void operator delete (void* p);

    bool isFinished() const { return finished; }
    void setFinished(bool f) { CCB::finished = f; }

    using Body = void (*)(void*);

    static CCB* createCoroutine(Body body, void* arg, void* stack);


    static void yield();
    static void dispatch();

    static CCB* running;

    friend class Scheduler;
private:
    CCB(Body body, void* arg, void* st) :
            body(body),
            bodyArg(arg),
            // st = pok. na posl. lok. (tehnicki na lok. nakon posl. za stek), u asembleru -8, a u C++-u -1 i onda se stavi elem
            stack(body != nullptr ? (uint64*)st : nullptr),
            context({   body != nullptr ? (uint64)&threadWrapper : 0,
                        stack != nullptr ? (uint64)stack : 0
                    }),
            finished(false)
    {
        if(body != nullptr) { Scheduler::getInstance().put(this); }
    }

    CCB* next = nullptr;
    struct Context
    {
        uint64 ra;
        uint64 sp;
    };
    Body body;
    void* bodyArg;
    uint64* stack;
    Context context;
    bool finished;

    static void threadWrapper();

    static void contextSwitch(Context* oldContext, Context* runningContext);
};


#endif //PROJECT_BASE_REPOSITORY_CCB_H
