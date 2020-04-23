---
title: "maximum-subarray prob"
date: 2020-04-22 00:00:00 -0400
categories: algorithm
---

* 최대 부분 배열 문제

* naive : n^2 prefix sum 으로 옮겨 가며 최대값 찾기

* 분할정복 :

```
A[low .. mid] A[mid + 1 .. high]
A[low .. high] 의 모든 연속 부분 배열은
  case 0 : A[low .. mid] 에 포함되는 경우 low <= i <= j <= mid
  case 1 : A[mid + 1 .. high] 에 포함되는 경우 mid <= i <= j <= high
  case 2 : 중간값에 걸친 경우 low <= i <= mid < j <= high
case2 -> A[i .. mid]  A[mid + 1 .. j] 

FIND-MAX-CROSSING-SUBARRAY(A, low, mid, high)
left-sum = -INF
sum = 0
for i == mid downto low
  sum = sum + A[i]
  if sum > left-sum
     left-sum = sum
     max-left = i
right-sum = -INF
sum = 0
for j = mid + 1 to high
  sum = sum + A[j]
  if sum > right-sum
     right-sum = sum
     max-right = j
return (max-left, max-right, left-sum + right-sum)

FIND-MAXIMUM-SUBARRAY(A, low, high)
if high == low
  return (low, high, A[low])
else mid = floor (low + high) / 2
  left-low, left-high, left-sum = FIND-MAXIMUM-SUBARRAY(A, low, mid)
  right-low, right-high, right-sum = FIND-MAXIMUM-SUBARRAY(A, mid + 1, high)
  cross-low, cross-high, cross-sum = FIND-MAX-CROSSING-SUBARRAY(A, low, mid, high)

  if left-sum >= right-sum and left-sum >= cross-sum
    return left-low, left-high, left-sum
  elseif right-sum >= left-sum and right-sum >= cross-sum
    return right-low, right-high, right-sum
  else return cross-low, cross-high, cross-sum

```


```cpp
#include <vector>
#include <iostream>
#include <chrono>
#include <tuple>
#include <limits>

std::vector<long long> prefixSum(std::vector<int>& arr) {
    int n = arr.size();
    std::vector<long long> sum(n, 0);
    for (int i = 0; i < n; i++) {
        sum[i] = (i == 0 ? arr[i] : sum[i - 1] + arr[i]);
    }
    return sum;
}

// naive sol n^2
long long maxSubArrSum(std::vector<int>& arr) {
    int n = arr.size();
    std::vector<long long> sum = prefixSum(arr);

    long long ret = 0;
    for(int i = 0; i < n; i++) {
        for(int j = i; j < n; j++) {
            long long sub = 0;
            if(i == 0) {
                sub = sum[j];
            } else {
                sub = sum[j] - sum[i-1];
            }
            std::cout << "(" << i << ", " << j <<  ") " << sub << std::endl;
            ret = std::max(ret, sub);
        }
    }
    return ret;
} 

std::tuple<int, int, long long> find_max_crossing_subarr(std::vector<int>& arr, int low, int mid, int high) {
    long long sum = 0;

    long long left_sum = std::numeric_limits<long long>::min(); // 왼쪽에서 가장 큰 합
    int max_left = 0;
    for(int i = mid; i >= low; i--) { // 왼쪽에서의 최대 부분 배열 찾기
        sum = sum + arr[i];
        if(sum > left_sum) {
            left_sum = sum;
            max_left = i;
        }
    }

    long long right_sum = std::numeric_limits<long long>::min();
    sum = 0;
    int max_right = 0;
    for(int j = mid + 1; j <= high; j++) { // 오른쪽에서의 최대 부분 배열 찾기
        sum = sum + arr[j];
        if(sum > right_sum) {
            right_sum = sum;
            max_right = j;
        }
    }
    return {max_left, max_right, left_sum + right_sum};
}

std::tuple<int, int, long long> find_maximum_subarr(std::vector<int>& arr, int low, int high) {
    if(high == low) {
        return {low, high, arr[low]};
    } else {
        int mid = low + (high - low) / 2;
        std::tuple<int, int, long long> left = find_maximum_subarr(arr, low, mid);
        std::tuple<int, int, long long> right = find_maximum_subarr(arr, mid + 1, high);
        std::tuple<int, int, long long> cross = find_max_crossing_subarr(arr, low, mid, high);
        if(std::get<2>(left) >= std::get<2>(right) && std::get<2>(left) >= std::get<2>(cross)) {
            return left;
        } else if (std::get<2>(right) >= std::get<2>(left) && std::get<2>(right) >= std::get<2>(cross)) {
            return right;
        } else {
            return cross;
        }
    }
}

int main(int argc, char** argv) {
    std::vector<int> arr = {13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7};
    {
        std::chrono::system_clock::time_point start_time = std::chrono::system_clock::now();
        long long ret = maxSubArrSum(arr);
        std::chrono::system_clock::time_point end_time = std::chrono::system_clock::now();
        std::chrono::nanoseconds nano = end_time - start_time;
        std::cout << ret << std::endl;
        std::cout << nano.count() << " ns" << std::endl;
    }

    {
        std::chrono::system_clock::time_point start_time = std::chrono::system_clock::now();
        std::tuple<int, int, long long> ret = find_maximum_subarr(arr, 0, arr.size());
        std::chrono::system_clock::time_point end_time = std::chrono::system_clock::now();
        std::chrono::nanoseconds nano = end_time - start_time;
        std::cout << std::get<0>(ret) << " " << std::get<1>(ret) << " " << std::get<2>(ret) << std::endl;
        std::cout << nano.count() << " ns" << std::endl;
    }
    return 0;
}

```

* 음 책 보고 이해 했으나.. 실제 문제 풀때 적용을 이렇게 할 생각을 할까...