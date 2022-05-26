#include "../h/MemoryAllocator.hpp"
#include "../h/print.hpp"

#include "../lib/console.h"
#include "../lib/hw.h"

int main() {
    printString("Velicina heap-a na pocetku: ");
    printInteger((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR);
    __putc('\n');

    MemoryAllocator mem = MemoryAllocator::getInstance();
    printString("sizeof(BlockHeader) = ");
    printInteger(sizeof(MemoryAllocator::BlockHeader));
    __putc('\n');

    printString("Free lista pre alociranja: ");
    for (MemoryAllocator::BlockHeader *cur = mem.freeMemHead; cur != nullptr; cur = cur->next) {
        printInteger(cur->size);
        __putc('-');
    }
    __putc('\n');

    printString("Alloc lista pre alociranja: ");
    for (MemoryAllocator::BlockHeader *cur = mem.allocMemHead; cur != nullptr; cur = cur->next) {
        printInteger(cur->size);
        __putc('-');
    }

    __putc('\n');
    __putc('\n');
    printString("ALOCIRANJE");
    __putc('\n');

    mem.mem_alloc(134195400);
    mem.mem_alloc(500);
    mem.mem_alloc(10000);
    mem.mem_alloc(200);
    mem.mem_alloc(30);
    mem.mem_alloc(120);
    mem.mem_alloc(900000000000000);
    printString("END \n");
    __putc('\n');
    __putc('\n');

    printString("Free lista posle alociranja: ");
    for (MemoryAllocator::BlockHeader *cur = mem.freeMemHead; cur != nullptr; cur = cur->next)
    {
        printInteger(cur->size);
        __putc('-');
    }
    __putc('\n');

    printString("Alloc lista posle alociranja: ");
    for(MemoryAllocator::BlockHeader* cur = mem.allocMemHead; cur != nullptr; cur=cur->next) {
        printInteger(cur->size);
        __putc('-');
    }
    __putc('\n');


    return 0;
}