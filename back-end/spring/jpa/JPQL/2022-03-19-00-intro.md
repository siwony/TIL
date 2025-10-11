---
layout: post
author: "정시원"
title: "객체지향 쿼리 언어"
categories: back-end
date: 2022-03-19
tags: [spring, jpa, JPQL]
---

# 객체지향 쿼리 언어
### JPA는 다양한 쿼리 방법을 지원한다.
- **JPQL**
- JPA Criteria
- **QueryDSL**
- 네이티브 SQL
- JDBC API 직접사용, MyBatis, SpringJdbcTemplate 함께 사용

### 하지만 JPA만으로 모든 문제들을 해결 할 수는 없다.
- JPA를 사용하면 엔티티 객체를 중심으로 개발한다.
- 검색을 할 때도 테이블이 아닌 엔티티 객체를 대상으로 검색한다.
- 모든 DB 데이터를 객체로 변환하여 검색하는 것은 불가능하다.
- 애플리케이션이 필요한 데이터만 DB에서 불러오려면 결국 검색 조건이 포함된 SQL이 필요하다.

## JPQL
: 객체 지향 SQL
- JPA는 SQL을 추상화한 JPQL이라는 객체 지향 쿼리 언어를 제공한다.
- 데이블이 아닌 객체를 대상으로 검색하는 객체 지향 쿼리이다.
- SQL을 추상화해서 특정 DB SQL에 의존하지 않는다.

### 예제
```java
String jpql = "select m From Member m where m.age > 18";

List<Member> result = em.createQuery*jpql, Member.class).getResultList();
```
`실행된 SQL`
```sql
select 
    m.id as id,
    m.age as age,
    m.USERNAME as USERNAME,
    m.TEAM_ID as TEAM_ID
from Member m
where m.age>18
```

## Criteria
> 너무 복잡하고 실용성이 없다 QueryDSL을 사용권장한다.
- 문자가 아닌 자바코드로 JPQL을 작성할 수 있다
- JPQL 빌더 역활을한다
- JPA 공식 기능

## queryDSL
> 일단 JPQL 먼저하면 쉽다. 기능전 JPQL - 김영한 
- 문자가 아닌 자바코드로 JPQL을 작성할 수 있다
- JPQL 빌더 역활을한다
- 컴파일 시점에 문법 오류를 찾을 수 있다
- 동적쿼리 작성이 편리하다.
- **실무사용이 권장된다.**

## 네이티브 SQL 소개
- JPA가 제공하는 SQL을 직접 사용하는 하는 기능이다.
- JPQL로 해결할 수 없는 특정 DB에 의존적인 기능일때 사용한다.
- ex. 오라클 CONNECT BY, 특정 DB만 사용하는 SQL 힌트

