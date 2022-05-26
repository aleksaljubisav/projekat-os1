//
// Created by os on 5/22/22.
//
#ifndef PROJECT_BASE_MEMORYALLOCATOR_HPP
#define PROJECT_BASE_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

class MemoryAllocator
{
public:
    static MemoryAllocator& getInstance();
    void* mem_alloc(size_t size);
    int mem_free(void* address);

    friend int main();

private:
    MemoryAllocator();
    struct BlockHeader
    {
        BlockHeader* next;
        BlockHeader* prev;
        size_t size;
    };
    BlockHeader* freeMemHead;
    BlockHeader* allocMemHead;

    // Helpers:
    BlockHeader *findFirstFit(size_t size);
    void getFromFreeList(BlockHeader *blk, size_t size, size_t allocSize);
    static void putIntoOrderedList(BlockHeader *blk, BlockHeader* &head);
    static int tryToJoin(BlockHeader *cur);
    BlockHeader *getFromAllocList(void *address);
};


#endif //PROJECT_BASE_MEMORYALLOCATOR_HPP
