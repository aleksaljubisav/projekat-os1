#include "../h/MemoryAllocator.hpp"
#include "../h/print.hpp"


int main()
{
    MemoryAllocator::getInstance();
    printInteger(sizeof(MemoryAllocator::BlockHeader));
    printString("\n");
    printInteger(sizeof(MemoryAllocator));
    printString("\n");

    MemoryAllocator::mem_alloc(500);

    for(MemoryAllocator::BlockHeader* cur = freeMemHead; ;);





    return 0;
}