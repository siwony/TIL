---
layout: post
author: "정시원"
title: "Google Guava"
categories: programming
date: 2022-03-29
tags: [java]
---

# Google Guava
### 배경
FCM를 통해 push 알람로직을 작성하는 중 관련 API의 코드를 뜯어보는 중 Guava에 대한 언급이 있어 찾아보게 되었다.

### Guava란?
구글리 작성한 Java 오픈소스 라이브러리 이다. 
- 유용한 유틸리티 함수와 클래스를 다양하게 제공한다,
- Apache Commons 프로젝트의 대안이 될 수 있다
- Java8 버전 이후 Guava에서 제공하던 기능을 유사하게 제공하게 됨에따라 역할이 다소 모호해졌다.

> Apache Commons Lang + Apache Commons Collections + 유용한 유틸 => Google Guava

### 장점
- 버그 발생률을 현저히 줄일 수 있다.
- 장황하고 비효율적인 코드를 줄일 수 있다.
- 개발 표준을 준수하는 코드를 작성할 수 있다.
- 위의 장점들로 인해 생상성이 증가한다.