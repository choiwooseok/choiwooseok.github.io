---
title: "[Codility] MissingInteger"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
#include <algorithm>

int solution(vector<int> &A) {
    // write your code in C++14 (g++ 6.2.0)
    A.erase(std::remove_if(A.begin(), A.end(), [](int elem){ return elem <= 0; }), A.end());
    std::sort(A.begin(), A.end(), std::less<int>());
    auto last = std::unique(A.begin(), A.end());
    A.erase(last, A.end());
    
    if(A.empty()) {
        return 1;
    }
    if(A.size() == 1) {
        return A.back() != 1 ? 1 : A.back() + 1;
    } else {
        if(A.front() != 1) {
            return 1;
        }
        
        for(int i = 0, n = A.size(); i < n; i++) {
            if(A[i+1] - A[i] != 1) {
                return A[i] + 1;
            }
        }
        return A.back() + 1;
    }
}
```