---
title: "FP in cpp chap2"
date: 2019-12-11 08:26:28 -0400
categories: cpp fp study
---

# Chap 2 함수형 프로그래밍 시작
## 2.1 함수가 함수를 취한다?
* FP 언어의 주요 기능 : 함수가 일반적인 값처럼 취급될 수 있다.
* 고차원 함수? 다른 함수를 인수로 받거나 새로운 함수를 반환하는 함수
    * ex) people -> filter(people, is_female) -> results
    * 필터는 predicate 를 전달 받을수 있으므로 고차원 함수

```cpp
cf) 표기법
filter: (collection<T>, (T -> bool)) -> collection<T>
transform : (collection<In>, (In -> Out)) -> collection<Out>
```

## 2.2 STL 예제
* STL 에 알고리즘으로 가장한 고차원 함수가 많음!

```cpp
ex)
double average_score(const std::vector<int>& scores) {
    int sum = 0;
    for(int score : scores) {
        sum += score;
    }
    return sum / (double) scores.size();
}

double average_score(const std::vector<int>& scores) {
    return std::accumulate(scores.cbegin(), scores.cend(), 0) / (double) scores.size();
}

double scores_product(const std::vector<int>& scores) {
    return std::accumulate(scores.cbegin(), scores.cend(), 1, std::multiplies<int>());
}
```

* 폴딩? https://en.wikipedia.org/wiki/Fold_(higher-order_function)
* f 가 + 같은 이항 연산자라면 ?? -> 컬렉션의 모든 항목 사이에 연산자를 배치한거랑 똑같다.
* 좌폴딩 우폴딩 다 됨 -> c++ 에서 우폴딩 하려면?? reverse iterator 쓰자
* accumulate -> 덧셈이나 곱셈에 제한되지 않고 여러 알고리즘 구현에 쓸 수 있는 폴딩 개념을 제공
* STL 로 구현 하는게 루프, 분기, 재귀로 구현하는것보다 더 효과적이지 않을수 있음 -> 불필요한 복사가 있을수 있다. 잘 보고 적용하자