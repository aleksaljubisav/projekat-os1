//
// Created by os on 5/22/22.
//

#include "../h/syscall_c.h"

void* mem_alloc(size_t size)
{
    //size_t allocSize = (size % MEM_BLOCK_SIZE == 0) ? size : (size + MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);
    size_t brojBlokova = (size % MEM_BLOCK_SIZE == 0) ? (size / MEM_BLOCK_SIZE) : (size / MEM_BLOCK_SIZE + 1);
    __asm__ volatile("mv a1, %0" : : "r" (brojBlokova));
    __asm__ volatile("li a0, 1"); // ako stavim gore, size bude 1
    __asm__ volatile("ecall");
    void* retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

int mem_free(void* pointer)
{
    __asm__ volatile("mv a1, %0" : : "r" (pointer));
    __asm__ volatile("li a0, 2"); // mora posle a1, zato sto nam je pointer u a0
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}


int thread_create(thread_t* handle, void (*start_routine)(void*), void* arg)
{
    __asm__ volatile("mv s1, a0");
    __asm__ volatile("mv s2, a1");
    /*void* stack_space = */start_routine != nullptr ? (void*)((char*)mem_alloc(DEFAULT_STACK_SIZE) + DEFAULT_STACK_SIZE) : nullptr;
    __asm__ volatile("li a5, 0x11");
    __asm__ volatile("mv a3, a0"); // kao da je 4. argument

    __asm__ volatile("mv a0, s1");
    __asm__ volatile("mv a1, s2");

    /*__asm__ volatile("mv a3, %0" : : "r" (arg));
    __asm__ volatile("mv a2, %0" : : "r" (start_routine));
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 0x11"); // mora ovim redosledom
    __asm__ volatile("ecall"); */
    systemCall();
    /*int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;*/return 0;
}

void thread_dispatch()
{
    __asm__ volatile("li a0, 0x13");
    __asm__ volatile("ecall");
}
