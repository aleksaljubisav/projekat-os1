//
// Created by os on 5/29/22.
//

#include "../h/scheduler.h"
#include "../h/tcb.h"

// Singleton getter
    Scheduler& Scheduler::getInstance()
{
    static Scheduler instance;
    return instance;
}

// Remove first
TCB* Scheduler::get()
{
    if(!readyQueueHead) { return nullptr; }

    TCB* cur = readyQueueHead;
    readyQueueHead = readyQueueHead->next;
    if(!readyQueueHead) { readyQueueTail = nullptr; }

    cur->next = nullptr;/////////////naknadno sam dodao
    return cur;
}

// Add last
void Scheduler::put(TCB *ccb)
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

