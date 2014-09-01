#ifndef JM_TIMER_H
#define JM_TIMER_H

#include <ctime>

// this will return the average speed of a function call over a second
double time(void* (*func)()) {
    double count = 0.0;
    auto start = clock();
    while(clock() - start < 1000000) {
        func();
        count++;
    }
    return count / (clock() - start);
}

#endif // define JM_TIMER_H
