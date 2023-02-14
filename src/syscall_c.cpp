//
// Created by os on 5/22/22.
//

#include "../h/syscall_c.hpp"



void* mem_alloc(size_t size) //0x01
{
    //size_t allocSize = (size % MEM_BLOCK_SIZE == 0) ? size : (size + MEM_BLOCK_SIZE - size % MEM_BLOCK_SIZE);
    size_t brojBlokova = (size % MEM_BLOCK_SIZE == 0) ? (size / MEM_BLOCK_SIZE) : (size / MEM_BLOCK_SIZE + 1);
    __asm__ volatile("mv a1, %0" : : "r" (brojBlokova));
    __asm__ volatile("li a0, 1"); // ako stavim gore, size bude 1
    __asm__ volatile("ecall");
    uint64 retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return (void*)retValue;
}

int mem_free(void* pointer) //0x02
{
    __asm__ volatile("mv a1, %0" : : "r" (pointer));
    __asm__ volatile("li a0, 2"); // mora posle a1
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg) //kod 0x11
{
    __asm__ volatile("mv a3, %0" : : "r" (arg));
    __asm__ volatile("mv a2, %0" : : "r" (start_routine));
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 17"); // 0x11
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

int thread_create_only(thread_t* handle, void(*start_routine)(void*), void* arg)
{
    __asm__ volatile("mv a3, %0" : : "r" (arg));
    __asm__ volatile("mv a2, %0" : : "r" (start_routine));
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 15"); // 0x0F
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}
int thread_schedule_only(thread_t* handle)
{

    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 16"); // 0x10
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;

}

int thread_exit ()
{
    __asm__ volatile("li a0, 18"); // 0x12
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

void thread_dispatch()
{
    __asm__ volatile("li a0, 19"); //0x13
    __asm__ volatile("ecall");
}
