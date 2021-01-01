---
title: "[Codility] PermMissingElem"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```python
def solution(A):
    # write your code in Python 3.6
    n = len(A);
    sum2 = (n+1) * (n+2) / 2
    sum1 = sum(A);
    return int(sum2 - sum1)
```