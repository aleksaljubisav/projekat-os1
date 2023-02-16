//
// Created by os on 2/14/23.
//

#ifndef PROJECT_BASE_REPOSITORY_SEMAPHORE_H
#define PROJECT_BASE_REPOSITORY_SEMAPHORE_H

#include "../h/tcb.h"
#include "../h/scheduler.h"

class TCB;

class Semaphore {
public:
    void* operator new(size_t size);
    void operator delete (void* p) noexcept;

    Semaphore (unsigned init=1) : val(init), blockedQueueHead(nullptr), blockedQueueTail(nullptr) {}
    void wait ();
    void signal ();
    int value () const { return val; }
    TCB *get();
    void put(TCB *ccb);

    ~Semaphore() { }; //MISLIM DA SVE NITI TREBA DA SE DEBLOKIRAJU I DA WAIT VRATI GRESKU

protected:
    void block ();
    void unblock ();
private:
    int val;

    TCB* blockedQueueHead;
    TCB* blockedQueueTail;
};
//int lck = 0; // lock


#endif //PROJECT_BASE_REPOSITORY_SEMAPHORE_H
