//
// Created by os on 5/22/22.
//
#pragma once

#include "../lib/hw.h"

#ifdef __cplusplus
extern "C" {
#endif

void* mem_alloc(size_t size);
int mem_free(void*);

class CCB;
typedef CCB* thread_t;
int systemCall(); // za C API funkcije sa najvise 4 argumenta
int thread_create(thread_t* handle, void (*start_routine)(void*), void* arg);



#ifdef __cplusplus
}
#endif

