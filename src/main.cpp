#include "../h/MemoryAllocator.hpp"
#include "../h/syscall_c.h"
#include "../h/riscv.hpp"
#include "../h/print.hpp"
#include "../lib/console.h"

typedef MemoryAllocator MA;

inline void ispisiListe()
{
    printString("Free lista: ");
    for(MA::BlockHeader* cur = MA::getInstance().freeMemHead; cur; cur = cur->next)
    {
        printInteger(cur->size);
        printString(" - ");
    }
    __putc('\n');

    printString("Alloc lista: ");
    for(MA::BlockHeader* cur = MA::getInstance().allocMemHead; cur; cur = cur->next)
    {
        printInteger(cur->size);
        printString(" - ");
    }
    __putc('\n');

}

struct Test
{
    uint64 a;
    uint64 b[500];
};

void main()
{
    printString("POCETAN SLOBODAN PROSTOR end - start - BlockHeader = ");
    printInteger((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR - 24);
    __putc('\n');
    ispisiListe();
    printString("ENTER ALLOCATE\n");

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    int* zero = new int;
    ispisiListe();
    Test* one = new Test;
    ispisiListe();
    uint64 * two = new uint64;
    ispisiListe();
    Test* three = new Test;
    ispisiListe();
    char* four = new char;
    ispisiListe();


    printString("EXIT\n");

    printString("ENTER DEALLOCATE\n");

    delete zero;
    delete one;
    delete two;
    delete three;
    delete four;

    printString("EXIT\n");


    ispisiListe();

}