---
title: "[Codility] TapeEquilibrium"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
#include <limits>
#include <vector>
// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

std::vector<int> prefixSum(std::vector<int>& A) {
    int n = A.size();
    std::vector<int> sum(n, 0);
    for(int i = 0; i < n; i++) {
        if(i == 0) {
            sum[i] = A[0];
        } else {
            sum[i] = sum[i-1] + A[i];
        }
    }
    return sum;
}

int solution(vector<int> &A) {
    // write your code in C++14 (g++ 6.2.0)
    
    int n = A.size();
    if(n == 2) {
        return std::abs(A[1] - A[0]);
    }
    
    int min = std::numeric_limits<int>::max();
    std::vector<int> sum = prefixSum(A);

    for(int i = 0; i < n-1; i++) {
        min = std::min(min, std::abs(sum[i] - (sum[n-1] - sum[i])));
    }
    return min;
}
```