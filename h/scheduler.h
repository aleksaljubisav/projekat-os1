//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_SCHEDULER_H
#define PROJECT_BASE_REPOSITORY_SCHEDULER_H


#include "../h/ccb.h"

// Singleton
class Scheduler
{
public:
    Scheduler& getInstance();

    CCB *get();
    void put(CCB *ccb);

    /*  deleted functions should generally be public
    as it results in better error messages      */
    Scheduler(Scheduler const&) = delete;
    void operator=(Scheduler const&) = delete;

private:
    // Skriveni konstruktor
    Scheduler() : readyQueueHead(nullptr), readyQueueTail(nullptr) {}

    CCB* readyQueueHead;
    CCB* readyQueueTail;
};


#endif //PROJECT_BASE_REPOSITORY_SCHEDULER_H
