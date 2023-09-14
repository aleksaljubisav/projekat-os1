//
// Created by os on 5/22/22.
//

#ifndef PROJECT_BASE_SYSCALL_CPP_HE
#define PROJECT_BASE_SYSCALL_CPP_HE

#include "syscall_c.h"

void* operator new (size_t size);
void operator delete (void* p) noexcept;

class Thread {
public:
    Thread (void (*body)(void*), void* arg);
    virtual ~Thread ();
    int start ();

    void join();

    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
private:
    thread_t myHandle;

    static void threadWrapper(/*thread_t* handle, void (*body)(void*),*/ void* arg);
};

class Semaphore {
public:
    Semaphore (unsigned init = 1);
    virtual ~Semaphore ();
    int wait ();
    int signal ();
private:
    sem_t myHandle;
};

class PeriodicThread : public Thread {
public:
    void terminate();
protected:
    PeriodicThread (time_t period);
    virtual void periodicActivation () {}
    void run() override
    {
        while(period > 0)
        {
            periodicActivation();
            sleep(period);
        }
        thread_exit();
    }
private:
    time_t period;
};

class Console {
public:
    static char getc ();
    static void putc (char);
};

#endif //PROJECT_BASE_SYSCALL_CPP_HE
