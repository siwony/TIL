---
layout: post
author: "정시원"
title: "Junit5"
categories: programming
date: 2022-04-16
tags: [java, junit]
---

# Junit5
Java의 대표적인 단위 테스트 코두
- Java8+
- 대체제: TestNG, Spock
- Junit5부터 class, method에 public를 붙여주지 않아도 된다.

## Junit 모듈
- Platform: 테스트를 실행해주는 런처 제공, TestEngine API 제공
- Jupiter: TestEngine API 구현체로 JUnit5 제공
- Vintage: Junit4, 3를 지원하는 TestEngine 구현체

``