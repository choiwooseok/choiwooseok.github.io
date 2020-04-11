---
title: "FP in cpp chap1"
date: 2019-12-11 08:26:28 -0400
categories: cpp fp study
---

# Chap 1 함수형 프로그래밍 소개
* OOP
    * 데이터 추상화
* FP
    * 함수 추상화
    * 무엇을 하는 방식 X -> 무엇을 해야 하는지에 관심
    * 부수 효과를 없애고 순수 함수를 만들어 모듈화 수준을 높이는 프로그래밍 패러다임

* 부수 효과?
    * 외부의 상태를 변경, 함수로 들어온 인자의 상태를 직접 변경
* 순수 함수?
    * 부수효과가 없는 함수, 외부 상태를 변경하지 않으며 동일한 인자를 주었을때 항상 같은 값을 리턴

* 파일 목록을 받아 line 수 계산하는 함수가 필요하다!
 
* 함수적으로 사고하기
    * 명령형 스타일로 코드 작성 -> 함수형 스타일 : 비생산적
    * 입력, 출력 맵핑을 위해 어떤 변환을 수행해야하는가에 집중

```
            open_file                    count_lines
version.h --------------> file contents -------------->  result
```

```cpp
std::vector<int> count_lines_in_files(const std::vector<std::string>& files) {
    return files | transform(open_file)
                 | transform(count_lines);
}
```