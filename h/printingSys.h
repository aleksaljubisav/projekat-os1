#ifndef _PRINTINGSYS_H_
#define _PRINTINGSYS_H_

#include "../lib/console.h"
#include "../lib/hw.h"

typedef unsigned long uint64;

extern "C" uint64 copy_and_swap(uint64 &lock, uint64 expected, uint64 desired);

void printStringSys(char const *string);

char* getStringSys(char *buf, int max);

int stringToIntSys(const char *s);

void printIntSys(int xx, int base=10, int sgn=0);

#endif // _PRINTINGSYS_H_

