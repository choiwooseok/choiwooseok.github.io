---
title: "Strassen"
date: 2020-04-22 00:00:00 -0400
categories: algorithm
---

* [슈트라센](https://ko.wikipedia.org/wiki/%EC%8A%88%ED%8A%B8%EB%9D%BC%EC%84%BC_%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98)

```

SQUARE-MATRIX-MULTIPLY(A, B)
n = A.rows
for i = 1 to n
    for j = 1 to n
        c[i][j] = 0
        for k = 1 to n
            c[i][j] = c[i][j] + a[i][k] * b[k][j]

SQUARE-MATRIX-MULTIPLY-RECURSIVE(A, B)
n = A.rows
if n == 1
    c[1][1] = a[1][1] * b[1][1]
else
    c[1][1] = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A11, B11)
    + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A12, B21)
    c[1][2] = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A11, B12)
    + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A12, B22)
    c[2][1] = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A21, B11)
    + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A22, B21)
    c[2][2] = SQUARE-MATRIX-MULTIPLY-RECURSIVE(A21, B12)
    + SQUARE-MATRIX-MULTIPLY-RECURSIVE(A22, B22)
return c

STRASSEN
P = (A11 + A22)(B11 + B22)
Q = (A21 + A22)B11
R = A11(B12 - B22)
S = A22(B21 - B11)
T = (A11 + A12)B22
U = (A21 - A11)(B11 + B12)
V = (A12 - A22)(B21 + B22)

C11 = P + S - T + V
C12 = R + T
C21 = Q + S
C22 = P + R - Q + U
```

* 이건 내가 쓸일이 없을듯함.