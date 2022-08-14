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

#ifdef __cplusplus
}
#endif

