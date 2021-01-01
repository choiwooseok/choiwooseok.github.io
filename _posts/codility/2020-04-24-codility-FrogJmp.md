---
title: "[Codility] FrogJmp"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
// you can use includes, for example:
// #include <algorithm>
#include <cmath>
// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

int solution(int X, int Y, int D) {
    return std::ceil((Y-X) / static_cast<double>(D));
}
```