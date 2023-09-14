//
// Created by os on 5/22/22.
//

#include "../h/syscall_c.h"

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

void thread_delete_only(thread_t* handle)
{
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 14"); // 0x0E
    __asm__ volatile("ecall");
    //int retValue;
    //__asm__ volatile("mv %0, a0" : "=r" (retValue));
    //return retValue;

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

void thread_join(thread_t handle)
{
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 20"); //0x14
    __asm__ volatile("ecall");
}

///////////////////////////////////////////////////////////////////////////////////////////////////


int sem_open(sem_t* handle, unsigned init) //0x21
{
    __asm__ volatile("mv a2, %0" : : "r" (init));
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 33");
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

int sem_close(sem_t handle) //0x22
{
    __asm__ volatile("mv a1, %0" : : "r" (handle));
    __asm__ volatile("li a0, 34");
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

int sem_wait(sem_t id) //0x23
{
    __asm__ volatile("mv a1, %0" : : "r" (id));
    __asm__ volatile("li a0, 35");
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

int sem_signal(sem_t id) //0x24
{
    __asm__ volatile("mv a1, %0" : : "r" (id));
    __asm__ volatile("li a0, 36");
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

int time_sleep(time_t time) //0x31
{
    if(time == 0) return 0;
    __asm__ volatile("mv a1, %0" : : "r" (time));
    __asm__ volatile("li a0, 49");
    __asm__ volatile("ecall");
    int retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

char getc()
{
    __asm__ volatile("li a0, 65"); //0x41
    __asm__ volatile("ecall");
    char retValue;
    __asm__ volatile("mv %0, a0" : "=r" (retValue));
    return retValue;
}

void putc(char c)
{
    __asm__ volatile("mv a1, %0" : : "r" (c));
    __asm__ volatile("li a0, 66"); //0x42
    __asm__ volatile("ecall");
}
