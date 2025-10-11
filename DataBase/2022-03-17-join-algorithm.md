---
layout: post
author: "정시원"
title: "조인 알고리즘"
categories: DataBase
date: 2022-03-17
tags: []
---

# 조인 알고리즘
- Nested Roop Join - 중첩 반복 조인
- Sort Merge Join - 정렬 병합 조인
- Hash Join - 해시 조인

## 1. Nested Roop Join
두개의 테이블의 행을 각각 모두 확인하여 조인하는 방법
> 중첩 for문st

### 1-1. 특징
- 한 레코드씩 순차적으로 접근한다.
- Random Access 위주의 접근한다.
- 주로 소량의 데이터를 조인하기 위해 사용한다.

## 2. Sort Merge Join
두개의 테이블을 조인 칼럼으로 정렬하여 조인하는 방법  
- Nested Roop Join과 수행 과정이 크게 다르지 않다.

### 2-2. 특징
- 조인 컬럼으로 정렬 후 조인을 수행한다.
- 정렬할 데이터가 많다면 부담이 크다.
- Non-Equal Join시 자주 사용한다.
- PGA 영역을 이용하여 정렬작업을 하기 때문에 `래치 - Latch`를 확득할 필요가 없어 인텍스를 통해 Table Access하는 것 보다 빠르다.

## 3. Hash Join
해싱 함수 기법을 활용하여 조인을 수행하는 방식이다.
- Sort Merge Join를 보안하기 위한 조인 방식
- Equal Join만 가능하다.

### 3-1. 특징
- Hash Join 역시 PGA 영역을 이용하기 떄문에 빠르게 결과를 얻을 수 있다.
- Outer Table의 해시 키 칼럼에 중복값이 거의 없을 때 사용한다.
- 대량의 데이터를 조인할 때 주로 사용한다.
  > 소량의 데이터를 조인시 오히려 I/O성능이 나빠질 수 있다.

