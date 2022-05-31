//
// Created by os on 5/29/22.
//

#ifndef PROJECT_BASE_REPOSITORY_WORKERS_H
#define PROJECT_BASE_REPOSITORY_WORKERS_H

bool finishedA = false;
bool finishedB = false;

extern void workerBodyA(void* arg);

extern void workerBodyB(void* arg);

#endif //PROJECT_BASE_REPOSITORY_WORKERS_H
