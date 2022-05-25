//
// Created by os on 5/22/22.
//
#ifndef PROJECT_BASE_MEMORYALLOCATOR_HPP
#define PROJECT_BASE_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

class MemoryAllocator
{
public:
    friend int main();

    static MemoryAllocator& getInstance();
    static void* mem_alloc(size_t size);
    static int mem_free(void* location);


    MemoryAllocator();
    struct BlockHeader
    {
        BlockHeader* next;
        BlockHeader* prev;
        size_t size;
    };
private:
    BlockHeader* freeMemHead;
    BlockHeader* allocMemHead;

    static BlockHeader *findFirstFit(size_t size);
    static void getFromFreeList(BlockHeader *blk, size_t size);
    static void putIntoOrderedList(BlockHeader *blk, BlockHeader* &head);
    static int tryToJoin(BlockHeader *cur);
    static BlockHeader *getFromAllocList(void *address);
};


#endif //PROJECT_BASE_MEMORYALLOCATOR_HPP
