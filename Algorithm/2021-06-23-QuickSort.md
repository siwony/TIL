---
layout: post
author: "정시원"
title: "퀵 정렬"
categories: Algorithm
date: 2021-06-23
tags: []
---

# 퀵 정렬
- **`분할 정복(Divide & Conquer)`** 에 기초한 알고리즘이다.
  > 작은 문제들로 나눠서 해결한 뒤, 해결된 작은 문제들로 큰 문제를 해결한다.

- **`피봇(Pivot)` 이라는 기준점**으로 덩어리를 나누는 것으로 분할을 수행한다.
  > Pivot 값 선정에 따라 일부 속도가 달라질 수 있다.

- **in-place 정렬이다.**
  >추가적인 공간을 요구하지 않고 주어진 배열 안에서 정렬을 시도한다.

- **`불안정 정렬(UnStable Sort)`** 이다.  
  > 중복된 값의 경우 입력순서 보장하지 않고 무작위로 뒤섞은 상태에서 정렬 하는것을 의미한다. [참고](https://3.ly/a9PWw)

### 정의
**퀵정렬은 정렬할 전체 원소에 대해서 정렬을 수행하지 않는다.**  
1. `Pivot`를 하나 선정한다.
2. `Pivot`를 중심으로 전체 원소들을 왼쪽 부분집합과 오른쪽 부분집합으로 **분할(Divide)** 한다.
3. 왼쪽 부분 집합에는 기준 값보다 작은 원소들을 이동시키고,  
   오른쪽 부분 집합에는 기준 값보다 큰 원소들을 이동시킨다.
4. 나누어진 두 개의 작은 리스트에 대해 재귀적으로 위의 과정을 반복합니다.ㅊ


### C언어를 이용한 퀵정렬의 구현 - 오름차순
> 여기서는 Pivot를 정렬할 리스트의 시작점으로 설정하겠습니다.
```C
#include <stdio.h>

void swap(int *arr,int a, int b){
    int tmp = arr[a];
    arr[a] = arr[b];
    arr[b] = tmp;
}

void qsort(int *arr, int start, int end){
	//분할된 원소가 0개이거나 1개 일때까지 함수 호출 
	if(start >= end) return;
	
	int pivot = start;	
	int left = pivot+1;
	int right = end;
	int temp;
	
	while(left<=right){// Left Right 교차하거나 같을때 종료
		while(left<=end && arr[left] <= arr[pivot]) //피봇 보다 큰 값 만날 때 까지
			++left;
		while(right>start && arr[right] >= arr[pivot]) //피봇 보다 작은 값 만날 때 까지
			--right;
		
		//위에서 계산된 left와 right가 만나거나 엇갈리면 종료
		if(left>=right) break;
		
		//두 원소 교환 
		swap(arr, left, right);
	}
	
	//피봇 정렬 완료 
	swap(arr, right, pivot);

	qsort(arr, start, right-1);	//피봇 중심으로 왼쪽부분 분할
	qsort(arr, right+1, end);	//피봇 중심으로 오른쪽부분 분할
}

int main(){
	
	int i;
	//1~10 무작위 배열
	int arr[7] = {5, 3, 7, 6, 2, 1, 4};
	
	//배열, [0], [6]
	qsort(arr, 0, 6);
	
	//출력 
	for(i = 0;i < 7;++i){
		printf("%d ", arr[i]);
	}
	
	return 0;
}
```