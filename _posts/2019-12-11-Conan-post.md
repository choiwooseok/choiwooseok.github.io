---
title: "코난 C/C++ package manager"
date: 2019-12-11 08:26:28 -0400
categories: cpp package-manager
---

* [conan home page](https://conan.io/)

* 왜 써야하는가
    * third-party 직접 빌드해서 사용하기 귀찮..
    * 버전 관리도 되고
    * 옵션에 따라 로컬 빌드도 되고
    * 리모트에 원하는 빌드 산출물이 있다면 그냥 가져오고 끝
    * CMake 에 추가하기 짱 쉽다.
    
* 설치방법

```
git clone https://github.com/conan-io/conan.git
cd conan
pip install -r conans/requirements.txt

or 

python3 -m pip install conan
```

* 프로젝트에 적용하기

* 가져올 third 파티 적기

```
conanfile.txt

[requires]
gtest/1.8.1@bincrafters/stable
[generators]
cmake
```

* 빌드할 root CMakeLists.txt 에 conan package 셋팅하기

```
conanfile.txt 있는 디렉터리에서

mkdir build && cd build
conan install ..


하고 root CMakeLists.txt 에서 두줄 추가

INCLUDE(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()
```

* 3rd 라이브러리 검색하기

```
conan search boost/* -r=conan-center

Existing package recipes:

boost/1.64.0@conan/stable
boost/1.65.1@conan/stable
boost/1.66.0@conan/stable
boost/1.67.0@conan/stable
boost/1.68.0@conan/stable
boost/1.69.0@conan/stable
boost/1.70.0
boost/1.70.0@conan/stable
boost/1.71.0
boost/1.71.0@conan/stable
```