---
title: "[Codility] OddOccurrencesInArray"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
#include <algorithm>
#include <unordered_map>
// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

int solution(vector<int> &A) {
    // write your code in C++14 (g++ 6.2.0)
    std::unordered_map<int, int> m;
    for(int& elem : A) {
        m[elem]++;
    }
    for(auto& elem : m) {
        if(elem.second % 2 == 1) {
            return elem.first;
        }
    }
    return -1;
}
```