---
title: "[Codility] CyclicRotation"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
#include <algorithm>

// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

vector<int> solution(vector<int> &A, int K) {
    int n = A.size();
    
    if(n <= 1) {
        return A;
    }
    if(K >= n) {
        K %= n;
    }
    std::rotate(A.rbegin(), A.rbegin() + K, A.rend());
    return A;
}
```