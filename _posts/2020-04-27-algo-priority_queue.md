---
title: "우선순위 큐"
date: 2020-04-27 00:00:00 -0400
categories: algorithm
---

```cpp
HEAP-MAXIMUM(A)
    return A[1]

// O log n
HEAP-EXTRACT-MAX(A)
    if A.heap-size < 1
        error "heap underflow"
    max = A[1]
    A[1] = A[A.heap-size]
    A.heap-size = A.heap-size - 1
    MAX-HEAPIFY(A,1)
    return max

HEAP-INCREASE-KEY(A, i, key)
    if key < A[i]
        error "err"
    A[i] = key
    while i > 1 and A[PARENT(i)] < A[i]
        A[i] <-> A[PARENT(i)]
        i = PARENT(i)

MAX-HEAP-INSERT(A, key)
    A.heap-size = A.heap-size + 1
    A[A.heap-size] = -INF
    HEAP-INCREASE-KEY(A, A.heap-size, key)
```