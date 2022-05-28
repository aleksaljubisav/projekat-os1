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


int main()
{
    printString("ENTER\n");

    printString("POCETAN SLOBODAN PROSTOR end - start - BlockHeader = ");
    printInteger((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR - 24);
    __putc('\n');

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    //MA::getInstance().mem_alloc(sizeof(int));
    //MA::getInstance().mem_alloc(5559);
    printInteger((uint64)(mem_alloc(sizeof(int))));
    __putc('\n');
    printInteger((uint64)(mem_alloc(5559)));
    __putc('\n');
    printString("EXIT\n");

    ispisiListe();

    return 0;
}