---
title: "balanced brackets"
date: 2019-12-11 08:26:28 -0400
categories: algorithm
---

```cpp
std::string isBalanced(std::string s) {
    std::stack<char> st;
    std::map<char, char> pairs = { {'(', ')'}, {'{', '}'}, {'[', ']'} };
    for(char ch : s) {
        if(pairs.find(ch) != pairs.end()) {
            st.push(ch);
        } else {
            if(st.empty()) {
                return "NO";
            } else if(ch == pairs[st.top()]){
                st.pop();
            } else {
                return "NO";
            }
        }
    }
    return st.empty() ? "YES" : "NO";
}

```