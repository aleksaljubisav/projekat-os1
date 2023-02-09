//
// Created by os on 5/29/22.
//

#include "../h/workers.h"

#include "../lib/hw.h"
#include "../h/tcb.h"
#include "../h/print.hpp"

void workerBodyA()
{
    for(uint64 i=0; i<10; i++)
    {
        printString("A: i=");
        printInteger(i);
        printString("\n");
        for(uint64 j=0; j<10000; j++)
        {
            for(uint64 k=0; k<30000; k++)
            {
                //busy wait
            }
//          TCB::yield();
        }
    }
} //nema eksplicitnog naglasavanja da se funkcija zavrsila

void workerBodyB()
{
    for(uint64 i=0; i<10; i++)
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
        for(uint64 j=0; j<10000; j++)
        {
            for(uint64 k=0; k<30000; k++)
            {
                //busy wait
            }
//          TCB::yield();
        }
    }
}

static uint64 fibonacci(uint64 n)
{
    if (n == 0 || n == 1) { return n; }
    if (n % 4 == 0) TCB::yield();
    return fibonacci(n - 1) + fibonacci(n - 2);
}

void workerBodyC()
{
    uint8 i = 0;
    for (; i < 3; i++)
    {
        printString("A: i=");
        printInteger(i);
        printString("\n");
    }

    printString("A: yield\n");
    __asm__ ("li t1, 7");
    TCB::yield();

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));

    printString("A: t1=");
    printInteger(t1);
    printString("\n");

    uint64 result = fibonacci(20);
    printString("A: fibonaci=");
    printInteger(result);
    printString("\n");

    for (; i < 6; i++)
    {
        printString("A: i=");
        printInteger(i);
        printString("\n");
    }

    TCB::running->setFinished(true);
    TCB::yield();
}

void workerBodyD()
{
    uint8 i = 10;
    for (; i < 13; i++)
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
    }

    printString("B: yield\n");
    __asm__ ("li t1, 5");
    TCB::yield();

    uint64 result = fibonacci(23);
    printString("A: fibonaci=");
    printInteger(result);
    printString("\n");

    for (; i < 16; i++)
    {
        printString("B: i=");
        printInteger(i);
        printString("\n");
    }

    TCB::running->setFinished(true);
    TCB::yield();
}