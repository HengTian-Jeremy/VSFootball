#ifndef Threading_h
#define Threading_h

#include <pthread.h>

class Mutex {
public:
    Mutex();
    ~Mutex();

    void lock();
    void unlock();
private:
    pthread_mutex_t mutex;

    friend class Condition;
};


class Condition {
public:
    Condition();
    ~Condition();

    void signal();
    void wait(Mutex& mutex);
    void timedWait(Mutex& mutex, int delay_ms);
private:
    pthread_cond_t cond;
};


class Thread {
public:
    Thread();
    ~Thread();

    void start();

    virtual void run() = 0;

    int join();
private:
    pthread_t thr;

    static void* mainThread(void* thread);
};

#endif
