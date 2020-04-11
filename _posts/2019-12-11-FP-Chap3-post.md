---
title: "FP in cpp chap3"
date: 2019-12-11 08:26:28 -0400
categories: cpp fp study
---

# Chap 3 함수 객체
* duck-typing : 오리 처럼 걷고 오리처럼 꽥꽥 거리면 오리다. -> 함수처럼 호출 될수 있는건 함수 객체다.
* C++ 에서 함수를 정의하는 방법

```cpp
int max(int arg1, int arg2) {} // 전통
auto max(int arg1, int arg2) -> int {} // 후행 반환
```

* 자동 반환 형식 추론
* C++14 부터 반환 유형 생략 가능 -> 컴파일러가 추론함. 좋지만 회사에선 못씀...

```cpp
int answer = 42;
auto ask() { return answer; }           // return type -> int
const auto& ask() { return answer; }    // return type -> const int&

cf)
auto ask(bool flag) {
    if(flag) return 42;
    else return std::string("42");     // 당연히 타입 추론 실패해서 에러
}

auto factorial(int num) {
    if(num == 0) {
        return 1;
    } else {
        return factorial(n-1) * n;       // 분기 순서가 바뀐다면?? 타입추론 전에 재귀 만나서 에러
    }
}
```
 
* auto 는 템플릿 타입 추론하니까 대신에 반환 유형 명세로도 가능

```cpp
decltype(auto) ask() { return answer; } // return type -> int: decltype(answer)
decltype(auto) ask() { return (answer); } // return type -> int: decltype((answer)) 에 대한 참조
decltype(auto) ask() { return (answer + 42); } // return type -> int: decltype(42 + answer)

있을수 있는 문제점 -> lvalue, rvalue -> perfect forwarding 으로 해결
template<typename Object, typename Func>
decltype(auto) call_on_object(Object&& object, Func function) {
    return function(std::forward<Object>(object));
}
```

* 함수 포인터
    * 함수의 주소를 저장
    * runtime polymorphism -> 포인터가 가리키는 함수를 변경
    * 함수 포인터도 함수처럼 호출될수 있으니 얘도 함수 객체
    * 암시적으로 함수 포인터로 변환되는 유형 만들기 보다 우아하게 클래스 만들고 호출 연산자(operator())를 오버로딩 하자
    * 일반 함수 만드는거보다 좋은점 -> 변경 여부에 상관없이 상태를 가질수 있다!!

```cpp
 class older_than {
   private:
     int limit;
   public:
     older_than(int limit) : limit(limit) {}
     bool operator()(const person_t& person) const {
       return person.age() > limit;
     }
 }
 // 이제 이런게 가능
 older_than older_than_12(12);
 older_than older_than_40(40);
 if(older_than_40(person)) {
    // do something
 } else if(older_than_12(person)) {
    // do something
 }
```

* 일반 함수 객체 만들기
    * older_than 의 제약 사항 -> 사람을 받는다. age() 정보를 갖는 모든 타입을 받고 싶다.
    * 객체지향으로 풀어도 되지만 호출연산자를 템플릿 멤버로 만들어서 해결!!

```cpp
 class older_than {
   private:
     int limit;
   public:
     older_than(int limit) : limit(limit) {}
     template<typename T>
     bool operator()(T&& object) const {
       return std::forward<T>(object).age() > limit;
     }
 }
 // 이제 이런게 가능
 older_than older_than_12(12);
 std::count_if(persons.cbegin(), persons.cend(), older_than_12);
 std::count_if(cars.cbegin(), cars.cend(), older_than_12);
 std::count_if(projects.cbegin(), projects.cend(), older_than_12);
```