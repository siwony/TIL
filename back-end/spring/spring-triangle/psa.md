---
layout: post
author: "정시원"
title: "PSA - Portable Service Abstraction"
categories: back-end
date: 2022-06-05
tags: [spring, spring-triangle]
---

# PSA - Portable Service Abstraction
PSA는 `서비스 지향 아키텍처 - SOA`에서 적용되는 설계원칙인 `서비스 추상화 - Service Abstraction`에 휴대용 이라는 뜻을 가진 Portable이 붙어진 용어이다. 

## 1. Service Abstraction - 서비스 추상화
서비스 추상화를 간략하게 설명하자면, 특정 서비스가 추상화 되었다는 의미는 서비스의 내부 구현내용을 모르더라도 해당 서비스를 이용할 수 있다. 

예를 들어 JDBC Driver를 통해 DB에 접근하지만 개발자는 JDBC Driver가 어떻게 구현되어 있는지 알지 않아도 해당 서비스를 사용할 수 있다.

즉 위의 말을 요약하여 정리하면 **추상화 계층을 사용하여 어떤 기술을 내부에 숨기고 개발자에게 편의성을 제공해주는 것**이라고 할 수 있다.

## 2. Portable Service Abstraction
Portable Service Abstraction은 Service Abstraction에서 한발짝 더 나아가 특정 서비스를 사용하는 비즈니스 로직은 그 특정 서비스의 변경을 수정 없이 할 수 있다.

JDBC를 예로 들면 JDBC는 DB벤더마다 여러개의 Driver를 가질 수 있다. 이런 Driver를 변경하고 싶다면 Driver만 병경하면 되고 JDBC를 사용하는 비즈니스 로직은 수정되지 않는다.

즉, **하나의 추상화로 여러 서비스(ex. JDBC Driver)를 묶어둔 것을 PSA이다.**

스프링에서의 추상화된 트랜잭션 관리를 제공한다. 이는 PSA가 활용된 것이다.

### 1. PSA 예시
- Spring Transactional
- Spring Cache
- Spring MVC

## Reference
1. [백기선 - 스프링 제대로 공부했는지 5분안에 확인하는 방법](https://www.youtube.com/watch?v=bJfbPWEMj_c&t=308s)
2. [백기선 - 예제로 배우는 스프링 입문, 12 스프링 PSA](https://www.youtube.com/watch?v=P3vzrqADl8I)
3. https://en.wikipedia.org/wiki/Service_abstraction