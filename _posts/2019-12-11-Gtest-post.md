---
title: "Gtest"
date: 2019-12-11 08:26:28 -0400
categories: cpp unit-test
---

# Google Test
* 단위 테스트, 통합테스트, 시나리오 테스트 가능

* ASSERT_\* 와 EXPECT_\* 의 차이
    * ASSERT 는 조건문이 참이 아닌경우 바로 테스트 종료
    * EXPECT 는 참이 아니면 그 케이스는 실패고 다음 테스트 진행

* 기본 테스트 수행 예시

* 전체 테스트를 detect 해줄 main 이 있어야됨

```cpp
#include <gtest/gtest.h>
 
int main(int argc, char** argv)
{
    ::testing::InitGoogleTest(&argc,argv);
 
    return RUN_ALL_TESTS();
}
```

* 테스트를 작성

```cpp
TEST(test_case_name, test_name)
{
    //... test body ...
}

int Factorial(int n);
 
TEST(FactorialTest, HandlesZeroInput) {
    EXPECT_EQ(1, Factorial(0));
}
 
TEST(FactorialTest, HandlesPositiveInput) {
    EXPECT_EQ(1, Factorial(1));
    EXPECT_EQ(2, Factorial(2));
    EXPECT_EQ(6, Factorial(3));
    EXPECT_EQ(40320, Factorial(8));
}

```

* 공통 데이터로 테스트가 하고 싶다!
    * Fixture를 만들면 됨

```cpp
class Emp{
private:
  int sal;
public:
  Emp();
  ~Emp();
  void setSal(int sal);
  int getSal();
  void increaseSal(int rate);
  void decreaseSal(int rate);
}

class Fixture : public ::testing::Test{
public:
  Emp* emp;
  Fixture();
  ~Fixture();
  virtual void SetUp();     // 각 테스트 케이스 수행전 호출됨
  virtual void TearDown();  // 테스트 종료시 자원정리는 여기서
};

TEST(FixtureTest, 무조건성공){
  ASSERT_TRUE(true)
}

TEST_F(Fixture, 인상){
  emp->setSal(10);
  EXPECT_EQ(10, emp->getSal());
  emp->increaseSal(10);
  EXPECT_EQ(11, emp->getSal());
}

TEST_F(Fixture, 삭감){
  emp->decreaseSal(100);
  EXPECT_EQ(0, emp->getSal());
}

```

* 테스트 그룹을 묶고 싶다! 필터링을 해서 선택한 테스트수트만 돌리고 싶다.

```cpp
TEST(ContainerTestSuite, QueueTest)
{
        ...
}
TEST(ContainerTestSuite, ListTest)
{
        ...
}
TEST(NetworkTestSuite, SomeTest)
{
        ...
}

실행인자를 아래와 같이주면 됨
--gtest_filter=NetworkTestSuite.*

```

* 테스트에 파라미터를 넘기고 싶다

```cpp
#include <gtest/gtest.h>
#include <cstring>
 
using namespace std;
 
// Function under test...
bool acceptName(const char* name)
{
  char *result = strstr(name, "eek");
  if(result == NULL){
    return false;
  }
  return true;
}
 
// A new one of these is create for each test
class MyStringTest : public testing::TestWithParam<const char*>
{
public:
  virtual void SetUp(){}
  virtual void TearDown(){}
};
 
INSTANTIATE_TEST_CASE_P(InstantiationName,
                        MyStringTest,
                        ::testing::Values("meek", "geek", "freek"));
 
TEST_P(MyStringTest, acceptsEekyWords)
{
  ASSERT_TRUE(acceptName(GetParam()));
}

```