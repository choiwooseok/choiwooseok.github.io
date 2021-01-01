---
title: "[Codility] BinaryGap"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
int solution(int N) {
    // write your code in C++14 (g++ 6.2.0)
    int zeroCnt = -1;
    int ret = 0;
    while(N > 0) {
        if((N & 1) == 1) {
            zeroCnt = 0;
        } else if(zeroCnt != -1) {
            zeroCnt++;
        }
        ret = std::max(ret, zeroCnt);
        N /= 2;
    }
    return ret;
}
```