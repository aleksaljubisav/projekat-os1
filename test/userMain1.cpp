//
// Created by os on 9/14/23.
//
#include "../h/syscall_c.h"
#include "../h/syscall_cpp.hpp"
#include "../test/printing.hpp"

class MyPeriodicThread : public PeriodicThread {
public:
    MyPeriodicThread(time_t period) : PeriodicThread(period) {}

protected:
    void periodicActivation() override {
        printString("Periodicno ukljucivanje.\n");
    }
};

void userMain1()
{
    MyPeriodicThread* nit = new MyPeriodicThread(30);
    nit->start();

    Thread::dispatch();

    time_sleep(100);
    nit->terminate();
    thread_join((thread_t)nit);
    printString("Nit je terminisana!\n");
}