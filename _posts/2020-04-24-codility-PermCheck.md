---
title: "[Codility] PermCheck"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
// you can use includes, for example:
#include <algorithm>

// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

int solution(vector<int> &A) {
    // write your code in C++14 (g++ 6.2.0)
    std::sort(A.begin(), A.end());
    if(A.front() != 1) {
        return 0;
    }
    for(int i = 0, n = A.size(); i < n-1; i++) {
        if(A[i+1] - A[i] != 1) {
            return 0;
        }
    }
    return 1;
}
```