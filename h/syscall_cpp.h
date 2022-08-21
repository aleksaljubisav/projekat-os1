//
// Created by os on 5/22/22.
//

#ifndef PROJECT_BASE_SYSCALL_CPP_HE
#define PROJECT_BASE_SYSCALL_CPP_HE

#include "syscall_c.h"

void* operator new (size_t size);
void operator delete (void* p) noexcept;

#endif //PROJECT_BASE_SYSCALL_CPP_HE
