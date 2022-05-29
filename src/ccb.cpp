//
// Created by os on 5/29/22.
//

#include "../h/ccb.h"
#include "../h/MemoryAllocator.hpp"

void* CCB::operator new(size_t size)
{
    void* p = MemoryAllocator::getInstance().mem_alloc(size);
    return p;
}
void CCB::operator delete (void* p)
{
    MemoryAllocator::getInstance().mem_free(p);
}
