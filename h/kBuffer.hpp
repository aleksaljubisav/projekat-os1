//
// Created by os on 9/14/23.
//

#ifndef PROJECT_BASE_REPOSITORY_PREDAJA_KBUFFER_HPP
#define PROJECT_BASE_REPOSITORY_PREDAJA_KBUFFER_HPP


#include "Semaphore.h"

//
class kBuffer {
private:
    int cap;
    char *buffer;
    int head, tail;

    Sem* spaceAvailable;
    Sem* itemAvailable;
    Sem* mutexHead;
    Sem* mutexTail;

public:
    void* operator new(size_t size);
    void operator delete (void* p) noexcept;

    kBuffer(int _cap);
    ~kBuffer();

    void put(char val);
    char get();

    int getCnt();

    int getCap() const;
};


//izmenjen bafer iz javnog testa
#endif //PROJECT_BASE_REPOSITORY_PREDAJA_KBUFFER_HPP
