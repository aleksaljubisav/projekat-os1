//
// Created by os on 9/14/23.
//

#include "../h/kBuffer.hpp"
#include "../h/Console.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/printingSys.h"

void* kBuffer::operator new(size_t size)
{
    void* p = MemoryAllocator::getInstance().mem_alloc(size);
    return p;
}
void kBuffer::operator delete(void* p) noexcept
{
    MemoryAllocator::getInstance().mem_free(p);
}

kBuffer::kBuffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    buffer = (char *)MemoryAllocator::getInstance().mem_alloc(sizeof(char) * cap);
    itemAvailable = new Sem(0);
    spaceAvailable = new Sem(_cap);
    mutexHead = new Sem(1);
    mutexTail = new Sem(1);
}

kBuffer::~kBuffer() {
    Con::getInstance().putc('\n');
    printStringSys("Buffer deleted!\n");
    while (getCnt()) {
        char ch = buffer[head];
        Con::getInstance().putc(ch);
        head = (head + 1) % cap;
    }
    Con::getInstance().putc('!');
    Con::getInstance().putc('\n');

    MemoryAllocator::getInstance().mem_free(buffer);
    delete itemAvailable;
    delete spaceAvailable;
    delete mutexTail;
    delete mutexHead;
}

void kBuffer::put(char val) {
    spaceAvailable->wait();

    mutexTail->wait();
    buffer[tail] = val;
    tail = (tail + 1) % cap;
    mutexTail->signal();

    itemAvailable->signal();

}

char kBuffer::get() {
    itemAvailable->wait();

    mutexHead->wait();

    char ret = buffer[head];
    head = (head + 1) % cap;
    mutexHead->signal();

    spaceAvailable->signal();

    return ret;
}

int kBuffer::getCnt() {
    int ret;

    mutexHead->wait();
    mutexTail->wait();

    if (tail >= head) {
        ret = tail - head;
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    mutexHead->signal();

    return ret;
}

int kBuffer::getCap() const {
    return cap;
}
