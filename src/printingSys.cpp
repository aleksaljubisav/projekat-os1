//
// Created by os on 5/18/22.
//

#include "../h/printingSys.h"
#include "../h/Console.hpp"

//uint64 lockPrint = 0;

//#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
//#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printStringSys(char const *string)
{
    //LOCK();
    while (*string != '\0')
    {
        Con::getInstance().putc(*string);
        string++;
    }
    //UNLOCK();
}

char* getStringSys(char *buf, int max) {
    //LOCK();
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
        cc = Con::getInstance().getc();
        if(cc < 1)
            break;
        c = cc;
        buf[i++] = c;
        if(c == '\n' || c == '\r')
            break;
    }
    buf[i] = '\0';

    //UNLOCK();
    return buf;
}

int stringToIntSys(const char *s) {
    int n;

    n = 0;
    while ('0' <= *s && *s <= '9')
        n = n * 10 + *s++ - '0';
    return n;
}

char digitsSys[] = "0123456789ABCDEF";

void printIntSys(int xx, int base, int sgn)
{
    //LOCK();
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    }

    i = 0;
    do{
        buf[i++] = digitsSys[x % base];
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';

    while(--i >= 0)
        Con::getInstance().putc(buf[i]);

    //UNLOCK();
}