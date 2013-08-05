#include "Threads.h"
#include <string.h>
#include <sys/time.h>

Mutex::Mutex()
{
    pthread_mutex_init(&mutex, 0);
}


Mutex::~Mutex()
{
    pthread_mutex_destroy(&mutex);
}


void
Mutex::lock()
{
    pthread_mutex_lock(&mutex);
}


void
Mutex::unlock()
{
    pthread_mutex_unlock(&mutex);
}


Condition::Condition()
{
    pthread_cond_init(&cond, 0);
}


Condition::~Condition()
{
    pthread_cond_destroy(&cond);
}


void
Condition::signal()
{
    pthread_cond_signal(&cond);
}


void
Condition::wait(Mutex& mutex)
{
    pthread_cond_wait(&cond, &mutex.mutex);
}


void
Condition::timedWait(Mutex& mutex, int delay_ms)
{
    timeval now;
    gettimeofday(&now, 0);
    timespec t;
    t.tv_sec = now.tv_sec + (delay_ms / 1000);
    t.tv_nsec = (now.tv_usec*1000) + ((delay_ms % 1000) * 1000000);
    while (t.tv_nsec >= 1000000000) {
        t.tv_nsec -= 1000000000;
        t.tv_sec++;
    }
    pthread_cond_timedwait(&cond, &mutex.mutex, &t);
}


Thread::Thread()
{
    memset(&thr, 0, sizeof(pthread_t));
}


Thread::~Thread()
{
}


void
Thread::start()
{
    pthread_create(&thr, 0, mainThread, this);
}


int
Thread::join()
{
    return pthread_join(thr, 0);
}


void*
Thread::mainThread(void* thread)
{
    Thread* th = (Thread*)thread;
    th->run();
    return 0;
}

