//
// Created by os on 9/10/23.
//

#include "../h/SleepList.h"
#include "../h/tcb.h"

// Singleton getter
SleepList& SleepList::getInstance()
{
    static SleepList instance;
    return instance;
}

TCB* SleepList::sleepQueueHead = nullptr;

// Remove first and all who have 0 time
void SleepList::wakeSleeping()
{
    if(!sleepQueueHead) return;
    TCB* cur = sleepQueueHead;
    //for(; cur->sleepTime == 0 && cur->nextSleep!=nullptr; cur = cur->nextSleep) //ovde cur bude null nzm
    do {
        sleepQueueHead = cur->nextSleep;
        if(cur->nextSleep) cur->nextSleep->prevSleep = nullptr;
        cur->nextSleep = nullptr;
        cur->prevSleep = nullptr;

        cur->sleeping = false;
        Scheduler::getInstance().put(cur);

        cur = sleepQueueHead;
    } while(cur && cur->sleepTime == 0); //&& cur->nextSleep!=nullptr
}

// Add
void SleepList::putSleeping(TCB *tcb)
{
    if(!tcb) return;

    tcb->sleeping = true;

    TCB* cur = sleepQueueHead;
    if(!sleepQueueHead || tcb->sleepTime < sleepQueueHead->sleepTime)
    {
        cur = nullptr;
    } else {
        tcb->sleepTime -= cur->sleepTime;
        for(; cur->nextSleep && tcb->sleepTime > cur->nextSleep->sleepTime; cur = cur->nextSleep)
        {
            tcb->sleepTime -= cur->nextSleep->sleepTime;
        }
    }
    tcb->prevSleep = cur;
    if(cur) tcb->nextSleep = cur->nextSleep;
    else tcb->nextSleep = sleepQueueHead;

    if(tcb->nextSleep) tcb->nextSleep->prevSleep = tcb;
    if(cur) cur->nextSleep = tcb;
    else sleepQueueHead = tcb;

    if(tcb->nextSleep) tcb->nextSleep->sleepTime -= tcb->sleepTime;

}