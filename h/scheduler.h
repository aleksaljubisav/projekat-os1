//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_SCHEDULER_H
#define PROJECT_BASE_REPOSITORY_SCHEDULER_H

#include "../h/list.h"

class CCB;

class Scheduler
{
private:
    static List<CCB> readyCoroutineQueue;

public:
    static CCB *get();

    static void put(CCB *ccb);

};


#endif //PROJECT_BASE_REPOSITORY_SCHEDULER_H
