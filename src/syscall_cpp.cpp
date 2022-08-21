//
// Created by os on 5/29/22.
//

#include "../h/syscall_cpp.h"

void* operator new (size_t size)
{
    void* p = mem_alloc(size);
    return p;
}
void operator delete (void* p) noexcept
{
    mem_free(p);
}
