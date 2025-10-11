---
layout: post
author: "정시원"
title: "버블 정렬 - Bubble Sort"
categories: Algorithm
date: 2022-01-30
tags: []
---

# 버블 정렬 - Bubble Sort
- 서로 인접한 두 원소를 검사하여 정렬하는 알고리즘이다.
- 시간 복잡도 : O(N^2)

연산이 가장 많아 정렬 알고리즘 중에서 상대적으로 가장 느리고 효율성이 떨어진다.

## 구현 코드
```java
private static int[] solution(final int arrLen, final int[] arr) {
    for (int i = 1; i < arrLen; i++) {
        int temp = arr[i], j;
        for (j = i - 1; j >= 0; j--) {
            if(arr[j] > temp) arr[j + 1] = arr[j];
            else break;
        }
        arr[j + 1] = temp;
    }
    return arr;
}

public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    final int arrLen = sc.nextInt();
    final int[] arr = new int[arrLen];
    for (int i = 0; i < arrLen; i++)
        arr[i] = sc.nextInt();

    for(int i : solution(arrLen, arr))
        System.out.print(i + " ");
}
```