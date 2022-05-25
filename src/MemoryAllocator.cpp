//
// Created by os on 5/22/22.
//

#include "../h/MemoryAllocator.hpp"

// Singleton getter
MemoryAllocator& MemoryAllocator::getInstance()
{
    static MemoryAllocator instance;
    return instance;
}

// Class constructor
MemoryAllocator::MemoryAllocator() : freeMemHead((BlockHeader*)(HEAP_START_ADDR)), allocMemHead(nullptr)
{
    //freeMemHead = (BlockHeader*)(HEAP_START_ADDR);
    freeMemHead->next = nullptr;
    freeMemHead->prev = nullptr;
    freeMemHead->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - sizeof(BlockHeader);
}

// freeMemHead initialization
//MemoryAllocator::BlockHeader* MemoryAllocator::freeMemHead = nullptr;

// allocMemHead initialization
//MemoryAllocator::BlockHeader* MemoryAllocator::allocMemHead = nullptr;

// First fit algorithm
inline MemoryAllocator::BlockHeader* MemoryAllocator::findFirstFit(size_t size)
{
    BlockHeader* blk = freeMemHead;
    for(; blk!=nullptr; blk = blk->next)
        if(blk->size >= size) break;
    return blk;
}

// Helper: Get block from the ordered free list
inline void MemoryAllocator::getFromFreeList(BlockHeader* blk, size_t size)
{
    size_t allocSize = (size % MEM_BLOCK_SIZE == 0) ? size : (size + MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);
    size_t remainingSize = blk->size - allocSize;
    if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE)
    {
        // A fragment remains
        blk->size = size;
        size_t offset = sizeof(BlockHeader) + allocSize;
        auto* newBlk = (BlockHeader*)((char*)blk + offset);

        // Prevezivanje
        if(blk->prev) blk->prev->next = newBlk;
        else freeMemHead = newBlk;
        newBlk->prev = blk->prev;
        if(blk->next) blk->next->prev = newBlk;
        newBlk->next = blk->next;

        newBlk->size = remainingSize - sizeof(BlockHeader);
    } else
    {
        // No remaining fragment, allocate the entire block
        if(blk->prev) blk->prev->next = blk->next;
        else freeMemHead = blk->next;
        if(blk->next) blk->next->prev = blk->prev;
    }
    blk->next = nullptr;
    blk->prev = nullptr;
}

// Helper: Put block into the ordered alloc list
inline void MemoryAllocator::putIntoOrderedList(BlockHeader* blk, BlockHeader* &head)
{
    BlockHeader* cur = head;
    if(!head || (char*)blk < (char*)head)
        cur = nullptr;
    else
        for(; cur->next!=nullptr && (char*)blk > (char*)(cur->next); cur = cur->next);
    blk->prev = cur;
    if(cur) blk->next = cur->next;
    else blk->next = head;

    if(blk->next) blk->next->prev = blk;
    if(cur) cur->next = blk;
    else head = blk;
}

// Memory allocation---------------------------------------------------------------------------------------
void* MemoryAllocator::mem_alloc(size_t size)
{
    // Try to find an existing free block in list (first fit):
    BlockHeader* blk = findFirstFit(size);
    if(blk == nullptr) return nullptr; // If not found

    // Get block from free memory list
    getFromFreeList(blk, size);

    // Put block in allocated memory list
    putIntoOrderedList(blk, allocMemHead);

    return (char*)blk + sizeof(BlockHeader);
}

// Helper: Try to join cur with the cur->next free segment:
inline int MemoryAllocator::tryToJoin(BlockHeader* cur)
{
    if(!cur) return 0;
    if(cur->next && (char*)cur + cur->size == (char*)(cur->next))
    {
        // Remove cur->next segment:
        cur->size += cur->next->size;
        cur->next = cur->next->next;
        if(cur->next) cur->next->prev = cur;
        return 1;
    } else
        return 0;
}

// Get block from allocated list
inline MemoryAllocator::BlockHeader* MemoryAllocator::getFromAllocList(void* address)
{
    BlockHeader* blk = allocMemHead;
    for(; blk!=nullptr && (char*)address != (char*)blk + blk->size; blk = blk->next);
    if(!blk) return nullptr;

    // Prevezivanje
    if(blk->prev) blk->prev->next = blk->next;
    else freeMemHead = blk->next;
    if(blk->next) blk->next->prev = blk->prev;

    blk->next = nullptr;
    blk->prev = nullptr;

    return blk;
}


// Memory deallocation
int MemoryAllocator::mem_free(void* address)
{
    // Get block from allocated list
    BlockHeader* blk = getFromAllocList(address);
    if(!blk) return -1;

    // Find where and insert the new segment after cur:
    putIntoOrderedList(blk, freeMemHead);

    // Try to merge with the previous and next segments
    tryToJoin(blk->prev);
    tryToJoin(blk);

    return 0;
}
