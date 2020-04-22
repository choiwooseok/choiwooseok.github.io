---
title: "insertion sort"
date: 2020-04-22 00:00:00 -0400
categories: algorithm
---

* 크기가 작은 정렬에 효율적

```
//pseudo code
for(int j = 2; j < A.length; j++) {
    key = A[j];
    
    // A[j] 를 정렬된 배열 A[1 .. j-1] 에 삽입.
    i = j - 1
    while(i > 0 and A[i] > key) {
        A[i+1] = A[i];
        i = i - 1;
    }
    A[i+1] = key;
}

```

```cpp
#include <vector>
#include <iostream>

template<typename T>
void printVector(std::vector<T>& arr) {
    for(T& elem : arr) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;
}

void insertion_sort(std::vector<int>& arr) {
    if(arr.size() <= 1) {
        return;
    }
    for(int j = 1, n = arr.size(); j < n; j++) {
        int key =  arr[j];
        int i = j - 1;

        while(i >= 0 && arr[i] > key) { // arr[j] 의 위치가 나올때까지 한칸씩 밀어내기
            // printVector(arr);
            arr[i+1] = arr[i];
            i -= 1;
        }
        arr[i+1] = key;
    }
}


int main(int argc, char** argv) {
    std::vector<int> arr = {2, 4, 1, 3, 6, 5};
    insertion_sort(arr);
    printVector(arr);
    return 0;
}

```