//
// Created by os on 9/10/23.
//

#ifndef PROJECT_BASE_REPOSITORY_PREDAJA_SLEEPLIST_H
#define PROJECT_BASE_REPOSITORY_PREDAJA_SLEEPLIST_H


class TCB;

// Singleton
class SleepList
{
public:
    static SleepList& getInstance();

    void wakeSleeping();
    void putSleeping(TCB *ccb);

    /*  deleted functions should generally be public
    as it results in better error messages      */
    SleepList(SleepList const&) = delete;
    void operator=(SleepList const&) = delete;

    TCB* getSleepQueueHead() const { return sleepQueueHead; }

private:
    // Skriveni konstruktor
    SleepList() : sleepQueueHead(nullptr) {}

    TCB* sleepQueueHead; //= nullptr;
};



#endif //PROJECT_BASE_REPOSITORY_PREDAJA_SLEEPLIST_H
