---
title: "bubble sort"
date: 2020-04-22 00:00:00 -0400
categories: algorithm
---

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

void bubble_sort(std::vector<int>& arr) {
    for(int i = 0, n = arr.size(); i < n-1; i++) {
        for(int j = 0; j < n-i-1; j++) {
            if(arr[j] > arr[j+1]) {
                std::swap(arr[j], arr[j+1]);
            }
        }
    }
}

int main(int argc, char** argv) {
    std::vector<int> arr = {2, 4, 1, 3, 6, 5};
    bubble_sort(arr);
    printVector(arr);
    return 0;
}
```