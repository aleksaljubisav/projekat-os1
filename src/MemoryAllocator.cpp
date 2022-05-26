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
MemoryAllocator::MemoryAllocator() :
    freeMemHead(((BlockHeader*)(HEAP_START_ADDR))), allocMemHead(nullptr)
{
    freeMemHead->next = nullptr;
    freeMemHead->prev = nullptr;
    freeMemHead->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR - sizeof(BlockHeader);
}

// Memory allocation
void* MemoryAllocator::mem_alloc(size_t size)
{
    if(size <= 0) return nullptr; // If size is less or equal to zero
    size_t allocSize = (size % MEM_BLOCK_SIZE == 0) ? size : (size + MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);

    // Try to find an existing free block in list (first fit):
    BlockHeader* blk = findFirstFit(allocSize);
    if(!blk) return nullptr; // If not found

    // Get block from free memory list
    blk = getFromFreeList(blk, allocSize);

    // Put block in allocated memory list
    putIntoOrderedList(blk, allocMemHead);

    return (char*)blk + sizeof(BlockHeader);
}

// Memory deallocation
int MemoryAllocator::mem_free(void* address)
{
    if(!address) return -1;
    // Get block from allocated list
    BlockHeader* blk = getFromAllocList(address);
    if(!blk) return -1;

    // Find where and insert the new segment after cur:
    putIntoOrderedList(blk, freeMemHead);

    // Try to merge with the previous and next segments
    tryToJoin(blk);
    tryToJoin(blk->prev);

    return 0;
}

// Helper: First fit algorithm
inline MemoryAllocator::BlockHeader* MemoryAllocator::findFirstFit(size_t allocSize)
{
    BlockHeader* blk = freeMemHead;
    for(; blk!=nullptr; blk = blk->next)
        if(blk->size >= allocSize) break;
    return blk;
}

// Helper: Get block from the ordered free list
inline MemoryAllocator::BlockHeader* MemoryAllocator::getFromFreeList(BlockHeader* blk, size_t allocSize)
{
    size_t remainingSize = blk->size - sizeof(BlockHeader) - allocSize;
    if(remainingSize >= sizeof(BlockHeader) + MEM_BLOCK_SIZE)
    {
        // A fragment remains
        BlockHeader* newBlk = blk;
        newBlk->size = newBlk->size - sizeof(BlockHeader) - allocSize;
        size_t offset = sizeof(BlockHeader) + newBlk->size;
        blk = (BlockHeader*)((char*)newBlk + offset);

        // Prevezivanje
        blk->size = allocSize;

    } else
    {
        // No remaining fragment, allocate the entire block
        if(blk->prev) blk->prev->next = blk->next;
        else freeMemHead = blk->next;
        if(blk->next) blk->next->prev = blk->prev;
    }
    blk->next = nullptr;
    blk->prev = nullptr;
    return blk;
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

// Helper: Get block from allocated list
inline MemoryAllocator::BlockHeader* MemoryAllocator::getFromAllocList(void* address)
{
    BlockHeader* blk = allocMemHead;
    for(; blk!=nullptr && (char*)address != (char*)blk + sizeof(BlockHeader); blk = blk->next);
    if(!blk) return nullptr;

    // Prevezivanje
    if(blk->prev) blk->prev->next = blk->next;
    else allocMemHead = blk->next;
    if(blk->next) blk->next->prev = blk->prev;

    blk->next = nullptr;
    blk->prev = nullptr;

    return blk;
}

// Helper: Try to join cur with the cur->next free segment:
inline int MemoryAllocator::tryToJoin(BlockHeader* cur)
{
    if(!cur) return 0;
    if(cur->next && (char*)cur + sizeof(BlockHeader) + cur->size == (char*)(cur->next))
    {
        // Remove cur->next segment:
        cur->size = cur->size + sizeof(BlockHeader) + cur->next->size;
        cur->next = cur->next->next;
        if(cur->next) cur->next->prev = cur;
        return 1;
    } else
        return 0;
}
