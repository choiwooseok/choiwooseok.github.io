---
title: "Tree Traversal"
date: 2020-04-14 00:00:00 -0400
categories: algorithm

---

```cpp
#include <iostream>
#include <sstream>
#include <algorithm>
#include <vector>
#include <queue>
#include <cmath>

enum class INPUT_ORDER {
    PRE, IN, POST, LEVEL
};

bool test(INPUT_ORDER order, const std::string& input,
    const std::string& pre,
    const std::string& in,
    const std::string& post,
    const std::string& level);

template<typename T>
void printVector(const std::vector<T>& arr) {
    for(auto elem : arr) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;
}

class Node {
public:
    char data = 0;
    Node *left = nullptr;
    Node *right = nullptr;
    Node(char data) : data(data) {}
};

void printPreOrder(Node* node, std::stringstream& ss) {
    if(node) {
        ss << std::string(1, node->data);
        printPreOrder(node->left, ss);
        printPreOrder(node->right, ss);
    }
}

void printInOrder(Node* node, std::stringstream& ss) {
    if(node) {
        printInOrder(node->left, ss);
        ss << std::string(1, node->data);
        printInOrder(node->right, ss);
    }
}

void printPostOrder(Node* node, std::stringstream& ss) {
    if(node) {
        printPostOrder(node->left, ss);
        printPostOrder(node->right, ss);
        ss << std::string(1, node->data);
    }
}

void printLevelOrder(Node* node, std::stringstream& ss) {
    if(node) {
        std::queue<Node*> queue;
        queue.push(node);

        std::queue<char> ret;
        while(!queue.empty()) {
            Node* curr = queue.front();
            ss << curr->data;
            if(curr->left) {
                queue.push(curr->left);
            }
            if(curr->right) {
                queue.push(curr->right);
            }
            queue.pop();
        }
    }
}

Node* buildTreeFromPreOrder(std::vector<char>& preOrder) {
    if (preOrder.empty()) {
        return nullptr;
    }

    Node *root = new Node(preOrder.front()); // 시작값이 root 이다.

    if(preOrder.size() == 1) {
        return root;
    }


    // 기준값 : root 제외하고 두번째로 작은 idx
    // begin() + 1 은 root, begin() + 2 는 left 의 root
    // 1 부터 idx 전 : 왼쪽
    // idx 부터 끝까지 : 오른쪽

    int idx = std::min_element(preOrder.begin() + 2, preOrder.end()) - preOrder.begin();
    std::vector<char> leftSub(preOrder.begin() + 1, preOrder.begin() + idx);
    std::vector<char> rightSub(preOrder.begin() + idx, preOrder.end());
    root->left  = buildTreeFromPreOrder(leftSub);
    root->right = buildTreeFromPreOrder(rightSub);
    return root;
}

Node* buildTreeFromInOrder(const std::vector<char>& inorder) {
    if (inorder.empty()) {
        return nullptr;
    }

    if(inorder.size() == 1) {
        return new Node(inorder[0]);
    }

    int idx = inorder.size() % 2 == 1 ? std::floor(inorder.size() >> 1) : inorder.size() >> 1;
    Node *root = new Node(inorder[idx]); // 중앙에 위치한 값이 root이다.

    // 기준값 : 중앙값
    // 시작 ~ 기준 - 1 : 왼쪽
    // 기준 + 1 ~ : 오른쪽

    std::vector<char> leftSub = {inorder.begin(), inorder.begin() + idx};
    std::vector<char> rightSub = {inorder.begin() + idx + 1, inorder.end()};
    // std::cout << "l : ";
    // printVector(leftSub);
    // std::cout << "r : ";
    // printVector(rightSub);

    root->left = buildTreeFromInOrder(leftSub);
    root->right = buildTreeFromInOrder(rightSub);
    return root;
}

Node* buildTreeFromPostOrder(std::vector<char>& postOrder) {
    if (postOrder.empty()) {
        return nullptr;
    }

    Node* root = new Node(postOrder.back());   // 마지막 값이 항상 root 이다.

    if(postOrder.size() == 1) {
        return root;
    }
    postOrder.pop_back(); // root 값 제거
    // 기준값 : 가장 작은 값
    // {D E B F C} => B
    // 시작부터 가장 작은값 까진 왼쪽
    // 나머진 오른쪽

    int idx = std::min_element(postOrder.begin(), postOrder.end()) - postOrder.begin();

    std::vector<char> leftSub(postOrder.begin(), postOrder.begin() + idx + 1);
    std::vector<char> rightSub(postOrder.begin() + idx + 1, postOrder.end());

    // std::cout << "l : ";
    // printVector(leftSub);
    // std::cout << "r : ";
    // printVector(rightSub);

    root->left  = buildTreeFromPostOrder(leftSub);
    root->right = buildTreeFromPostOrder(rightSub);
    return root;
}

Node* buildTreeFromLevelOrder(std::vector<char>& levelOrder) {
    Node* root = nullptr;

    if (levelOrder.empty()) {
        return root;
    }
    std::queue<Node*> q;
    for(char ch : levelOrder) {
        root = [](Node* root, char data, std::queue<Node*>& q) {
            Node* node = new Node(data); 
            if (root == nullptr) {
                root = node;
            } else if (q.front()->left == nullptr) {
                q.front()->left = node; 
            } else { 
                q.front()->right = node; 
                q.pop(); 
            } 
        
            q.push(node); // 다음 child 가 쓸 수 있게.
            return root;
        }(root, ch, q);
    }
    return root;
}

int main(int argc, char** argv) {

    {
        //       A 
        //     /   \ 
        //    B     C
        std::string preOrderStr = "ABC";
        std::string inOrderStr = "BAC";
        std::string postOrderStr = "BCA";
        std::string levelOrderStr = "ABC";
        test(INPUT_ORDER::PRE  , preOrderStr ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::IN   , inOrderStr  ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::POST , postOrderStr,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::LEVEL, levelOrderStr, preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
    }


    {
        //      A 
        //    /   \ 
        //   B     C
        //  /     
        // D
        std::string preOrderStr = "ABDC";
        std::string inOrderStr = "DBAC";
        std::string postOrderStr = "DBCA";
        std::string levelOrderStr = "ABCD";

        test(INPUT_ORDER::PRE  , preOrderStr ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::IN   , inOrderStr  ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::POST , postOrderStr,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::LEVEL, levelOrderStr, preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
    }


    {
        //       A
        //     /   \ 
        //    B     C
        //   / \
        //  D   E
        std::string preOrderStr = "ABDEC";
        std::string inOrderStr = "DBEAC";
        std::string postOrderStr = "DEBCA";
        std::string levelOrderStr = "ABCDE";

        test(INPUT_ORDER::PRE  , preOrderStr ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);

        // in -> [pre, post, level] failed 이유 : 중앙 idx 값을 최상위로 잡았기 때문 한쪽으로 쏠려있으면 X
        // 추가 조건이 더 있어야 한다.
        //       E
        //     /   \ 
        //    B     C
        //   /     /
        //  D     A 
        // test(INPUT_ORDER::IN   , inOrderStr  ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::POST , postOrderStr,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::LEVEL, levelOrderStr, preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
    }

    {
        //       A 
        //     /   \ 
        //    B     C
        //   /     /
        //  D     E
        std::string preOrderStr = "ABDCE";
        std::string inOrderStr = "DBAEC";
        std::string postOrderStr = "DBECA";
        std::string levelOrderStr = "ABCDE";

        test(INPUT_ORDER::PRE  , preOrderStr ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::IN   , inOrderStr  ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::POST , postOrderStr,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);

        // level -> [pre, in, post] failed
        // from level Order below tree will be generated
        //       A              
        //     /  \  
        //    B    C
        //  /  \  
        // D    E
        // test(INPUT_ORDER::LEVEL, levelOrderStr, preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
    }

    // {
    //           A 
    //         /   \ 
    //        B     C
    //       /       \
    //      D         E
    //     std::string preOrderStr = "ABDCE";
    //     std::string inOrderStr = "DBACE";
    //     std::string postOrderStr = "DBECA";
    //     std::string levelOrderStr = "ABCDE";
    //     pre -> in failed
    //     same preOrder Case
    //            A
    //          /   \
    //        B      C
    //       /      /
    //      D      E
    //     test(INPUT_ORDER::PRE  , preOrderStr ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);

    //     in -> [pre, post, level] failed
    //     same inOrder Case
    //            A
    //          /   \
    //        B      E
    //       /      / 
    //      D      C
    //     test(INPUT_ORDER::IN   , inOrderStr  ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);

    //     post -> in failed
    //     same postOrder Case
    //            A
    //          /   \
    //        B      C
    //       /      / 
    //      D      E
    //     test(INPUT_ORDER::POST , postOrderStr,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);

    //     level -> [pre, in, post] failed
    //     from level Order below tree will be generated
    //           A              
    //         /  \  
    //        B    C
    //      /  \  
    //     D    E
    //     test(INPUT_ORDER::LEVEL, levelOrderStr, preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
    // }

    {
        //       A 
        //     /   \ 
        //    B     C
        //   / \   /
        //  D   E F
        std::string preOrderStr = "ABDECF";
        std::string inOrderStr = "DBEAFC";
        std::string postOrderStr = "DEBFCA";
        std::string levelOrderStr = "ABCDEF";

        test(INPUT_ORDER::PRE  , preOrderStr ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::IN   , inOrderStr  ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::POST , postOrderStr,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::LEVEL, levelOrderStr, preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
    }

    {
        //       A 
        //     /   \ 
        //    B     C
        //   / \   / \
        //  D   E F   G
        std::string preOrderStr = "ABDECFG";
        std::string inOrderStr = "DBEAFCG";
        std::string postOrderStr = "DEBFGCA";
        std::string levelOrderStr = "ABCDEFG";

        test(INPUT_ORDER::PRE  , preOrderStr ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::IN   , inOrderStr  ,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::POST , postOrderStr,  preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
        test(INPUT_ORDER::LEVEL, levelOrderStr, preOrderStr, inOrderStr, postOrderStr, levelOrderStr);
    }
    return 0;
}


bool test(INPUT_ORDER order, const std::string& input, const std::string& pre, const std::string& in, const std::string& post, const std::string& level) {
    std::vector<char> inputChars = {input.begin(), input.end()};
    std::stringstream ss;
 
    bool testSuccess = true;

    if (order == INPUT_ORDER::PRE) {
        std::cout << "\nINPUT : " << input << std::endl;
        Node* root = buildTreeFromPreOrder(inputChars);
        {
            printInOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From preOrder to inOrder" << std::endl
                    << "PASSED : "  << std::boolalpha << (result == in) << std::endl;
            ss.str("");
            ss.clear();

            if(result != in) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << in << std::endl;
                testSuccess = false;
            }
        }

        {
            printPostOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From preOrder to postOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == post) << std::endl;
            ss.str("");
            ss.clear();
            if(result != post) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << post << std::endl;
                testSuccess = false;
            }
        }

        {
            printLevelOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From preOrder to levelOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == level) << std::endl;
            ss.str("");
            ss.clear();
            if(result != level) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << level << std::endl;
                testSuccess = false;
            }
        }
    } else if (order == INPUT_ORDER::IN) {
        std::cout << "\nINPUT : " << input << std::endl;
        Node* root = buildTreeFromInOrder(inputChars);

        {
            printPreOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From inOrder to preOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == pre) << std::endl;
            ss.str("");
            ss.clear();
            if(result != pre) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << pre << std::endl;
                testSuccess = false;
            }
        }

        {
            printPostOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From inOrder to postOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == post) << std::endl;
            ss.str("");
            ss.clear();
            if(result != post) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << post << std::endl;
                testSuccess = false;
            }
        }

        {
            printLevelOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From inOrder to levelOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == level) << std::endl;
            ss.str("");
            ss.clear();
            if(result != level) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << level << std::endl;
                testSuccess = false;
            }
        }
    } else if (order == INPUT_ORDER::POST) {
        std::cout << "\nINPUT : " << input << std::endl;
        Node* root = buildTreeFromPostOrder(inputChars);

        {
            printPreOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From postOrder to preOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == pre) << std::endl;
            ss.str("");
            ss.clear();
            if(result != pre) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << pre << std::endl;
                testSuccess = false;
            }
        }

        {
            printInOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From postOrder to inOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == in) << std::endl;
            ss.str("");
            ss.clear();
            if(result != in) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << in << std::endl;
                testSuccess = false;
            }
        }

        {
            printLevelOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From postOrder to levelOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == level) << std::endl;
            ss.str("");
            ss.clear();
            if(result != level) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << level << std::endl;
                testSuccess = false;
            }
        }

    } else if (order == INPUT_ORDER::LEVEL) {
        std::cout << "\nINPUT : " << input << std::endl;
        Node* root = buildTreeFromLevelOrder(inputChars);

        {
            printPreOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From levelOrder to preOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == pre) << std::endl;
            ss.str("");
            ss.clear();
            if(result != pre) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << pre << std::endl;
                testSuccess = false;
            }
        }

        {
            printInOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From levelOrder to inOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == in) << std::endl;
            ss.str("");
            ss.clear();
            if(result != in) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << in << std::endl;
                testSuccess = false;
            }
        }

        {
            printPostOrder(root, ss);
            std::string result = ss.str();
            std::cout << "From levelOrder to postOrder" << std::endl
                    << "PASSED : " << std::boolalpha << (result == post) << std::endl;
            ss.str("");
            ss.clear();
            if(result != post) {
                std::cout 
                    << "RESULT : "  << result << std::endl
                    << "EXPECT : "  << post << std::endl;
                testSuccess = false;
            }
        }

    }
    return testSuccess;
}
```