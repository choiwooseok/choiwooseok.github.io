---
title: "프로그래머스 가장 먼 노드"
date: 2020-04-14 00:00:00 -0400
categories: algorithm-prob

---

```cpp
#include <string>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Graph {
private:
    int num_node;
    std::vector<std::vector<int> > adj;

public:
    Graph(int num_node) : num_node(num_node) {
        adj.resize(num_node + 1);
    }
    
    void addEdge(int v, int w) {
        adj[v].push_back(w);
    }
   
    int bfs() {
        std::vector<bool> visited(num_node + 1, false);
        std::queue<int> q;
        std::vector<int> dist(num_node + 1, 0);
        
        q.push(1); // 시작 idx
        visited[1] = true;
        dist[1] = 0;
        
        while(!q.empty()) {
            int curr = q.front();
            q.pop();
            for(int i = 0; i < adj[curr].size(); i++) { // 인접한 애들 다 가보기
               if(visited[adj[curr][i]] == false) {
                   visited[adj[curr][i]] = true;
                   q.push(adj[curr][i]);
                   dist[adj[curr][i]] = dist[curr] + 1;
               }
            }                        
        }
        
        int max = *std::max_element(dist.begin(), dist.end());
        return std::count(dist.begin(), dist.end(), max);
    }
};

int solution(int n, vector<vector<int>> edge) {
    int answer = 0;
    Graph g(n);
    for(auto& src_dst : edge) {
        g.addEdge(src_dst[0], src_dst[1]);
        g.addEdge(src_dst[1], src_dst[0]);
    }
    
    return g.bfs();
}
```