---
layout: post
author: "정시원"
title: "이진 탐색 트리 - Binary Search Tree"
categories: cs
date: 2022-03-19
tags: [data-structure, non-linear, tree]
---

# 이진 탐색 트리 - Binary Search Tree
`이진 탐색 - binary search`와 `연결리스트 - linked list`를 결합한 자료구조이다.

이진 탐색의 효율적인 탐색 능력을 유지하면서, 빈번한 자료 입력과 삭제를 가능하도록 고안되었다.

이진 탐색의 경우 탐색에 소요되는 시간 복잡성은 `O(log n)`으로 빠르지만 말 그대로 탐색이므로 자료의 입력, 삭제가 불가능하다.  
연결리스트의 경우 자료 입력, 삭제에 필요한 시간복잡성은 `O(1)`로 효율적이지만 탐색시 `O(n)`의 시간 복잡성이 발생한다.

### 규칙
> 모든 왼쪽 자식들 <= n < 모든 오른쪽 자식들
1. key는 중복을 허용하지 않는다.
2. 왼쪽 노드의 키 < 루트 노드의 키 < 오른쪽 노드의 키
3. 왼쪽과 오른쪽 서브 트리도 이진 탐색 트리이다.

### 특징
- 탐색, 삽입, 삭제 연산에 대한 **평균 시간복잡도는 `O(logN)`** 이다.\
- 이진 탐색 트리는 `편향 트리 - Skewed Tree`가 될 수 있다. 그리하여 **최악의 시간 복잡도가 `O(N)`** 이다
  - 저장 순서에 따라 계속 한 쪽으로만 노드가 추가되는 경우가 발생하기 때문이다.
  - 이를 해결하기 위해 레드블랙트리, AVL트리가 있다.


### 이진 탐색 트리의 ADT
- 검색 : `retreive(key)`
- 삽입 : `insert(key)`
- 삭제 : `delete(key)`


## Refrenece
- https://ratsgo.github.io/data%20structure&algorithm/2017/10/22/bst/
- https://velog.io/@adam2/TREE#%EC%9D%B4%EC%A7%84-%ED%83%90%EC%83%89-%ED%8A%B8%EB%A6%ACbinary-search-tree
- https://velog.io/@agugu95/%EC%9D%B4%EC%A7%84-%ED%8A%B8%EB%A6%AC%EC%9D%98-%EA%B7%A0%ED%98%95-RED-BALCKAVL