---
title: "[Codility] MaxCounters"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
vector<int> solution(int N, vector<int> &A) {
    std::vector<int> ret(N, 0);
    int max = 0;
    int temp = 0;
    for(int& elem : A) {
        if(1 <= elem && elem <= N) {
            if(ret[elem - 1] < max) {
                ret[elem - 1] = max + 1;
            } else {
                ret[elem - 1]++;
            }
            if(temp < ret[elem - 1]) {
                temp = ret[elem - 1];
            }
            
        } else if(elem == N+1) {
            max = temp;
        }
    }
    
    for(int i = 0; i < N; i++) {
        if(ret[i] < max) {
            ret[i] = max;
        }
    }
    
    return ret;
}
```