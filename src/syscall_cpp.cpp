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

Thread::~Thread()
{ }

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

void Thread::threadWrapper(/*thread_t* handle, void (*body)(void*),*/ void* arg)
{
    ((Thread*)arg)->run();
}


//Thread::~Thread ();

void Thread::dispatch ()
{
    thread_dispatch();
}

//int Thread::sleep (time_t);