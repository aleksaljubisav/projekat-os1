//
// Created by os on 5/22/22.
//
#pragma once

#include "../lib/hw.h"

#ifdef __cplusplus
extern "C" {
#endif

void* mem_alloc(size_t size); //kod 0x01

int mem_free(void*); //kod 0x02

/*class _thread {
public:
    void* getRucka() {return rucka;}
    void setRucka(void* r) {rucka = r;}
private:
    void* rucka = nullptr;
}; */
class TCB;
typedef TCB* thread_t;
int thread_create (thread_t* handle, void(*start_routine)(void*), void* arg); //kod 0x11
int thread_create_only(thread_t* handle, void(*start_routine)(void*), void* arg);
int thread_schedule_only(thread_t* handle);
void thread_delete_only(thread_t* handle);

int thread_exit (); // 0x12

void thread_dispatch(); //kod 0x13



#ifdef __cplusplus
}
#endif

