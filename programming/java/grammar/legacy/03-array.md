---
layout: post
author: "정시원"
title: "Array"
categories: programming
date: 2022-04-05
tags: [java, grammar, legacy]
---

# Array
### 배열 선언
```java
///////////1차원///////////
int[] arr1 = new int[100];
int[] arr2 = new int[]{1, 2, 3, 4};
int[] arr3 = {1,2,3,4};
///////////2차원///////////
int[][] arr4 = new int[3][4];

int[][] arr5 = new int[3][];
arr5[0] = new int[1]

```
### 배열 사용
**array.length**
> 배열 크기 반환

**for each**  
``for(타입 값을 받아줄 변수명 : 출력하고 싶은 자료구조)``
```java
int[] arr = {1, 2, 3}
for(int i : arr)
    System.out.println(i)
//출력: 
//1 2 3
```