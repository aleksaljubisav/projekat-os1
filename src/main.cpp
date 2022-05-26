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
    printString("ALOCIRANJE \n");

    //char* one = (char*)mem.mem_alloc(134195260);
    char* two = (char*)mem.mem_alloc(500);
    char* three = (char*)mem.mem_alloc(10000);
    char* four = (char*)mem.mem_alloc(200);
    char* five = (char*)mem.mem_alloc(30);
    char* six = (char*)mem.mem_alloc(120);
    char* seven = (char*)mem.mem_alloc(900000000000000);

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


    // DEALOCIRANJE:
    printString("DEALOCIRANJE \n");
    mem.mem_free(two);
    mem.mem_free(three);
    mem.mem_free(four);
    mem.mem_free(five);
    mem.mem_free(six);
    mem.mem_free(seven);
    printString("END \n\n");

    printString("Free lista posle dealociranja: ");
    for (MemoryAllocator::BlockHeader *cur = mem.freeMemHead; cur != nullptr; cur = cur->next)
    {
        printInteger(cur->size);
        __putc('-');
    }
    __putc('\n');

    printString("Alloc lista posle dealociranja: ");
    for(MemoryAllocator::BlockHeader* cur = mem.allocMemHead; cur != nullptr; cur=cur->next) {
        printInteger(cur->size);
        __putc('-');
    }
    __putc('\n');


    return 0;
}