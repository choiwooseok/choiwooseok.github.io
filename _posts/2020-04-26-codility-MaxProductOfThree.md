---
title: "[Codility] MaxProductOfThree"
date: 2020-04-26 00:00:00 -0400
categories: algorithm-prob
---

```cpp
#include <algorithm>

int solution(vector<int> &A) {
    std::sort(A.begin(), A.end());
    int n = A.size();
    return std::max(A[0] * A[1] * A[n-1], A[n-1] * A[n-2] * A[n-3]);
}
```