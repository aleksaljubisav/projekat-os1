#include "../h/MemoryAllocator.hpp"
#include "../h/print.hpp"
#include "../lib/console.h"
#include "../lib/hw.h"


typedef MemoryAllocator MA;

inline void ispisListe(void* head)
{
    for (auto *cur = (MA::BlockHeader*)head; cur != nullptr; cur = cur->next)
    {
        printInteger(cur->size);
        __putc('-');
    }
    __putc('\n');
}

int main() {
    printString("Velicina heap-a na pocetku: ");
    printInteger((uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR);
    __putc('\n'); __putc('\n');

    printString("Free lista pre alociranja: ");
    ispisListe(MA::getInstance().freeMemHead);
    printString("Alloc lista pre alociranja: ");
    ispisListe(MA::getInstance().allocMemHead);

    __putc('\n');
    printString("ALOCIRANJE \n");

    //char* one = (char*)mem.mem_alloc(134195260);
    void* two = MA::getInstance().mem_alloc(500);
    void* three = MA::getInstance().mem_alloc(10000);
    void* four = MA::getInstance().mem_alloc(200);
    void* five = MA::getInstance().mem_alloc(30);
    void* six = MA::getInstance().mem_alloc(120);
    //char* seven = (char*)MA::getInstance().mem_alloc(900000000000000);

    printString("END\n\n");

    printString("Free lista posle alociranja: ");
    ispisListe(MA::getInstance().freeMemHead);
    printString("Alloc lista posle alociranja: ");
    ispisListe(MA::getInstance().allocMemHead);
    __putc('\n');


    // DEALOCIRANJE:
    printString("DEALOCIRANJE \n");

    MA::getInstance().mem_free(two);
    printString("\nFree lista posle dealociranja: ");
    ispisListe(MA::getInstance().freeMemHead);
    printString("Alloc lista posle dealociranja: ");
    ispisListe(MA::getInstance().allocMemHead);

    MA::getInstance().mem_free(three);
    printString("\nFree lista posle dealociranja: ");
    ispisListe(MA::getInstance().freeMemHead);
    printString("Alloc lista posle dealociranja: ");
    ispisListe(MA::getInstance().allocMemHead);

    MA::getInstance().mem_free(four);
    printString("Free lista posle dealociranja: ");
    ispisListe(MA::getInstance().freeMemHead);
    printString("Alloc lista posle dealociranja: ");
    ispisListe(MA::getInstance().allocMemHead);

    MA::getInstance().mem_free(five);
    printString("Free lista posle dealociranja: ");
    ispisListe(MA::getInstance().freeMemHead);
    printString("Alloc lista posle dealociranja: ");
    ispisListe(MA::getInstance().allocMemHead);

    MA::getInstance().mem_free(six);
    printString("END \n\n");

    printString("Free lista posle dealociranja: ");
    ispisListe(MA::getInstance().freeMemHead);
    printString("Alloc lista posle dealociranja: ");
    ispisListe(MA::getInstance().allocMemHead);


    return 0;
}