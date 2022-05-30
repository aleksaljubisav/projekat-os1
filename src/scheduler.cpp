//
// Created by os on 5/29/22.
//

#include "../h/scheduler.h"
#include "../h/ccb.h"

// Singleton getter
    Scheduler& Scheduler::getInstance()
{
    static Scheduler instance;
    return instance;
}

// Remove first
CCB* Scheduler::get()
{
    if(!readyQueueHead) { return nullptr; }

    CCB* cur = readyQueueHead;
    readyQueueHead = readyQueueHead->next;
    if(!readyQueueHead) { readyQueueTail = nullptr; }

    return cur;
}

// Add last
void Scheduler::put(CCB *ccb)
{
    if(readyQueueTail)
    {
        readyQueueTail->next = ccb;
        readyQueueTail = ccb;
    } else
    {
        readyQueueHead = readyQueueTail = ccb;
    }
}

