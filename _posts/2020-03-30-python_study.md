---
title: "python 기본 공부 codewars fundamental 풀면서 몰랐던거 필요할때마다 찾아본 내용 정리"
date: 2020-03-25 00:00:00 -0400
categories: python flask
---

* 수정 및 추가중

- python 기본 공부 codewars fundamental 풀면서 몰랐던거 필요할때마다 찾아본 내용 정리
  - stl 로 생각하고 얘가 있을까 싶은건 다 있는듯?.. 감으로 찍으면 있다..
  - tuple : () 로 둘러쌈 리스트는 [], 튜플과 리스트 다른점 튜플은 값 변경 불가능
  
```python
  t1 = ()
  t2 = (1,)
  t3 = (1, 2, 3)
  t4 = 1, 2, 3
  t5 = ('a', 'b', ('ab', 'cd'))
```

  - list slicing

```
a[ start : end : step ]
step이 양수일 때 : 오른쪽으로 step만큼 이동하면서 가져옴.
step이 음수일 때 : 왼쪽으로 step만큼 이동하면서 가져옴.

 a = ['a', 'b', 'c', 'd', 'e']
 a[::2]
 =>
 ['a', 'c', 'e']

holy ... 너무 좋잖아
```

- dictionary key check 일단 느낌대로 in 으로 했는데 다른 사람들 제출 목록에서 return value_dict.get(param.lower(), 'Beer')
를 줄 수 있는걸 봤다.

'key' in mydict         elapsed time 1.07 sec<br>
mydefaultdict['key']    elapsed time 1.07 sec<br>
mydict.get('key')       elapsed time 1.84 sec<br>

get 으로 가져오는게 왜 더 느리지?? 어차피 hash table 인데??? 신기..<br>
-> 찾아보고 적어 놓을것 <br>
예상 : get 을 사용한 변수에 대한 타입추론?<br>
-> 아닌듯..<br>
첫번째면 T / F<br>
두번째면 val or keyError<br>
세번째면 val or Default(None) -> 얘는 객체라서 느린걸까. optional 이니까 box unbox 해주느라 그런건가 생각됨.<br>

```
일단 doc 확인

key in d
Return True if d has a key key, else False.

d[key]
Return the item of d with key key. Raises a KeyError if key is not in the map.

If a subclass of dict defines a method __missing__() and key is not present, the d[key] operation calls that method with the key key as argument. The d[key] operation then returns or raises whatever is returned or raised by the __missing__(key) call. No other operations or methods invoke __missing__(). If __missing__() is not defined, KeyError is raised. __missing__() must be a method; it cannot be an instance variable:


get(key[, default])
Return the value for key if key is in the dictionary, else default. If default is not given, it defaults to None, so that this method never raises a KeyError.
```

- 진수 변환

```
int(str(num), base)
```

- 몫 나머지

```
a = 7
b = 5
print(a//b, a%b) // 내답
print( *divmod(a, b) ) // 근데 이런것도 됨

>>> import dis
>>> dis.dis(compile('divmod(n, d)', '', 'exec'))
  1           0 LOAD_NAME                0 (divmod)
              3 LOAD_NAME                1 (n)
              6 LOAD_NAME                2 (d)
              9 CALL_FUNCTION            2
             12 POP_TOP             
             13 LOAD_CONST               0 (None)
             16 RETURN_VALUE        
>>> dis.dis(compile('(n // d, n % d)', '', 'exec'))
  1           0 LOAD_NAME                0 (n)
              3 LOAD_NAME                1 (d)
              6 BINARY_FLOOR_DIVIDE 
              7 LOAD_NAME                0 (n)
             10 LOAD_NAME                1 (d)
             13 BINARY_MODULO       
             14 BUILD_TUPLE              2
             17 POP_TOP             
             18 LOAD_CONST               0 (None)
             21 RETURN_VALUE        
```

- 문자열

```
정렬
ljust
center
rjust

import string 

string.ascii_lowercase # 소문자 abcdefghijklmnopqrstuvwxyz
string.ascii_uppercase # 대문자 ABCDEFGHIJKLMNOPQRSTUVWXYZ
string.ascii_letters #대소문자 모두 abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
string.digits # 숫자 0123456789
```