---
title: "[Codility] FrogRiverOne"
date: 2020-04-26 00:00:00 -0400
categories: algorithm-prob
---

* 1 ~ X 까지 다 거쳤을때 X에 도달한 최소 idx

```cpp
#include <unordered_set>

int solution(int X, vector<int> &A) {
    // write your code in C++14 (g++ 6.2.0)
    int n = A.size();
    std::unordered_set<int> s;
    for(int i = 0; i < n; i++) {
        if(A[i] <= X) {
            s.insert(A[i]);
        }
        if(s.size() == X) {
            return i;
        }
    }
    
    return -1;
}
```