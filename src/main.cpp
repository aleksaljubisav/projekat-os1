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

    printString("POCETAN SLOBODAN PROSTOR end - start - BlockHeader = ");
    printInteger((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR - 24);
    __putc('\n');

    printString("ENTER ALLOCATE\n");

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    //MA::getInstance().mem_alloc(sizeof(int));
    //MA::getInstance().mem_alloc(5559);
    void* zero = mem_alloc(134195264);
    ispisiListe();
    void* one = mem_alloc(sizeof(int));
    ispisiListe();
    void* two = mem_alloc(5559);
    ispisiListe();
    void* three = mem_alloc(sizeof(uint64) + 122);
    ispisiListe();
    void* four = mem_alloc(9999999999);
    ispisiListe();

    printString("EXIT\n");

    printString("ENTER DEALLOCATE\n");

    printInteger(mem_free(zero));
    __putc('\n');
    printInteger(mem_free(one));
    __putc('\n');
    printInteger(mem_free(two));
    __putc('\n');
    printInteger(mem_free(three));
    __putc('\n');
    printInteger(mem_free(four));
    __putc('\n');

    printString("EXIT\n");


    ispisiListe();

    return 0;
}