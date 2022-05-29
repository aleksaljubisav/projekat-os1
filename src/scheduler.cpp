//
// Created by os on 5/29/22.
//

#include "../h/scheduler.h"

List<CCB> Scheduler::readyCoroutineQueue;

CCB *Scheduler::get()
{
    return readyCoroutineQueue.removeFirst();
}

void Scheduler::put(CCB *ccb)
{
    readyCoroutineQueue.addLast(ccb);
}