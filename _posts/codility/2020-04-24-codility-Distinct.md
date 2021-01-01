---
title: "[Codility] Distinct"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
// you can use includes, for example:
// #include <algorithm>
#include <unordered_set>
// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

int solution(vector<int> &A) {
    // write your code in C++14 (g++ 6.2.0)
    std::unordered_set<int> s = {A.begin(), A.end()};
    return s.size();
}
```