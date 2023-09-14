//
// Created by os on 5/29/22.
//

#include "../h/syscall_cpp.hpp"

void* operator new (size_t size)
{
    void* p = mem_alloc(size);
    return p;
}
void operator delete (void* p) noexcept
{
    mem_free(p);
}

Thread::~Thread() { thread_delete_only(&myHandle); }

Thread::Thread ()
{
    thread_create_only(&myHandle, threadWrapper, this);
}

Thread::Thread (void (*body)(void*), void* arg)
{
    thread_create_only(&myHandle, body, arg);
    //threadWrapper(&myHandle, body, arg); valjda ne treba
}


int Thread::start ()
{

    return thread_schedule_only(&myHandle);
}

void Thread::join()
{
    thread_join(myHandle);
}

void Thread::threadWrapper(/*thread_t* handle, void (*body)(void*),*/ void* arg)
{
    ((Thread*)arg)->run();
}

void Thread::dispatch ()
{
    thread_dispatch();
}

Semaphore::Semaphore (unsigned init)
{
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore ()
{
    sem_close(myHandle);
}

int Semaphore::wait ()
{
    return sem_wait(myHandle);
}
int Semaphore::signal ()
{
    return sem_signal(myHandle);
}

int Thread::sleep(time_t time)
{
    return time_sleep(time);
}

PeriodicThread::PeriodicThread(time_t period) : period(period) {}

void PeriodicThread::terminate()
{
    period = 0;
}

char Console::getc ()
{
    return ::getc();
}

void Console::putc(char c)
{
    ::putc(c);
}