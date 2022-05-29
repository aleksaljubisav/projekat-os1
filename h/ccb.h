//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_CCB_H
#define PROJECT_BASE_REPOSITORY_CCB_H

#include "../lib/hw.h"

class CCB {
public:
    void* operator new(size_t size);
    void operator delete (void* p);

    bool isFinished() const { return finished; }
    void setFinished(bool f) { CCB::finished = finished; }

    using Body = void (*)();

    static CCB* createCoroutine(Body body);

    friend class Scheduler;

private:
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
};


#endif //PROJECT_BASE_REPOSITORY_CCB_H
