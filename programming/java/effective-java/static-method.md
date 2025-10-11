---
layout: post
author: "정시원"
title: "생성자 대신 정적 매소드 사용을 고려해라"
categories: programming
date: 2022-04-19
tags: [java, effective-java]
---

# 생성자 대신 정적 매소드 사용을 고려해라

## 장점
### 객체 생성에 대해 이름을 가질 수 있다.
> 동일한 시그니처의 생성자를 여러개 가질 수 없다.

### 호환 가능한 다른 인스턴스를 리턴할 수 있다.
- 클라이언트에게 구현체를 숨길 수 있다.
- 구현체가 없어도 된다.

> ServiceLoader, 찾아보기

## 단점
- 