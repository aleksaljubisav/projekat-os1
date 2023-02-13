//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_SCHEDULER_H
#define PROJECT_BASE_REPOSITORY_SCHEDULER_H

//#include "../h/ccb.h"
class TCB;

// Singleton
class Scheduler
{
public:
    static Scheduler& getInstance();

    TCB *get();
    void put(TCB *ccb);

    /*  deleted functions should generally be pubSlic
    as it results in better error messages      */
    Scheduler(Scheduler const&) = delete;
    void operator=(Scheduler const&) = delete;

private:
    // Skriveni konstruktor
    Scheduler() : readyQueueHead(nullptr), readyQueueTail(nullptr) {}

    TCB* readyQueueHead; //= nullptr;
    TCB* readyQueueTail; //= nullptr;
};


#endif //PROJECT_BASE_REPOSITORY_SCHEDULER_H
