---
layout: post
author: "정시원"
title: "Spring Transaction Propagation - 스프링 트랜잭션 전파속성"
categories: back-end
date: 2022-07-12
tags: [spring, transaction]
---

# Spring Transaction Propagation - 스프링 트랜잭션 전파속성
트랜잭션을 시작하거나 기존 트랜잭션에 참여하는 방법을 결정하는 속성이다.

#### 스프링이 지원하는 전파속성
스프링이 지원하는 전파 속성은 다음과 같다.
1. Required (기본값)
2. Supports
3. Mandatory
4. Requires new
5. Not supported
6. Never
7. Nested

### 1. Required
미리 시작 된 트랜잭션이 있으면 참여하고, 없으면 새로 시작한다.
- 기본 속성
- 모든 트랜잭션 매니저가 지원
- 트랜잭션이 시작 된 후 다른 트랜잭션 경계가 설정된 메소드를 호출하면 같은 트랜잭션으로 묶인다.

### 2. Supports
이미 시작된 트랜잭션이 있다면 참여하고, 없다면 트랜잭션 없이 진행한다.

### 3. Mandatory
이미 시작된 트랜잭션이 있으면 참여한다. 시작된 트랜잭션이 없으면 예외가 발생한다.
- 독립적으로 트랜잭션을 진행하면 안되는 경우 사용한다.

### 4. Requires new
항상 새로운 트랜잭션을 시작한다.
- 이미 진행중인 트랜잭션은 잠시 보류하고 새로운 트랜잭션을 시작한다.
- 이전 트랜잭션과 별도로 동작한다.

### 5. Not supported
트랜잭션을 사용하지 않는다.
- 이미 진행중인 트랜잭션이 있으면 보류시킨다.

### 6. Never
트랜잭션을 사용하지 않도록 강제한다. 이미 트랜잭션이 진행중이면, 예외를 발생한다.

### 7. Nested
이미 실행중인 트랜잭션이 있으면, 중첩 트랜잭션을 시작한다.
- 상위 트랜잭션은 하위 트랜잭션에 영향을 주지만, 하위 트랜잭션의 결과에 영향을 끼치지 않는다.

## Reference
- https://mangkyu.tistory.com/169
- https://www.youtube.com/watch?v=SUQxXg229Xg