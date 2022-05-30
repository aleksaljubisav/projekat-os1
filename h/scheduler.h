//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_SCHEDULER_H
#define PROJECT_BASE_REPOSITORY_SCHEDULER_H

//#include "../h/ccb.h"
class CCB;

// Singleton
class Scheduler
{
public:
    static Scheduler& getInstance();

    CCB *get();
    void put(CCB *ccb);

    /*  deleted functions should generally be pubSlic
    as it results in better error messages      */
    Scheduler(Scheduler const&) = delete;
    void operator=(Scheduler const&) = delete;

private:
    // Skriveni konstruktor
    Scheduler() {}

    CCB* readyQueueHead = nullptr;
    CCB* readyQueueTail = nullptr;
};


#endif //PROJECT_BASE_REPOSITORY_SCHEDULER_H
