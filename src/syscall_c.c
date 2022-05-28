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
    __asm__ volatile("li a0, 2"); // mora posle a1
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}