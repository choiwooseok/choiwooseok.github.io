---
title: "[Codility] Brackets"
date: 2020-04-24 00:00:00 -0400
categories: algorithm-prob
---


```cpp
#include <stack>
#include <map>
#include <string>
// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

int solution(string &S) {
    // write your code in C++14 (g++ 6.2.0)
    std::stack<char> st;
    std::map<char, char> pairs = {
        {'(', ')'},
        {'{', '}'},
        {'[', ']'}
    };
    for(char ch : S) {
        if(pairs.find(ch) != pairs.end()) {
            st.push(ch);
        } else {
            if(st.empty()) {
                return 0;
            } else if(ch == pairs[st.top()]) {
                st.pop();
            } else {
                return 0;
            }
        }
    }
    return st.empty() ? 1 : 0;
}
```