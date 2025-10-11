---
layout: post
author: "정시원"
title: "JPQL"
categories: back-end
date: 2022-03-19
tags: [spring, jpa, JPQL]
---

# JPQL
: Java Persistence Query Language
- JPQL은 객체지향 쿼리 언어다. &rarr; **엔티티 객체를 대상으로 쿼리한다.**
- SQL을 추상화하여 특정DB SQL에 의존하지 않는다.
- 결국 SQL로 변환된다.

### 문법
- ex. select m from Member as m where m.age > 18
- 엔티티와 속성은 대소문자를 구분한다 (Member, age)
- JQL 키워드는 대소문자 구분x
- 엔티티의 이름을 사용한다.
- 별명은 필수다!(m) (as는 생략가능)

### 집합과 정렬
```sql
select
    COUNT(m),   //회원수
    SUM(m.age), //나이 합
    AVG(m.age), //평균 나이
    MAX(m.age), //최대 나이
    MIN(m.age)  //최소 나이
from Member m
```
- GROUP BY HAVING
- ORDER BY

### TypeQuery, Query
#### TypeQuery 
: 반환 타입이 명확할 때 사용
```java
//예시
TypeQuery<Member> query1 =
    em.createQuery("select m from Member m", Member.class);
TypeQUery<member> query2 = 
    em.createQuery("select m.username from Member m", Member.class);
```

#### Query
: 반환 타입이 명확하지 않을 때 사용
```java
Query query = 
    em.createQuery("select m.username, m.age from Member m"); // 반환을 String,이랑 Int처럼 달라서 타입 정보를 받을 수 없다.
```

### 결과 조회 API
#### 결과가 여러개 일때
`query.getResultList()  `
- 리스트를 반환한다.
- 결과가 없으면 빈 리스트를 반환한다.

#### 결과가 하나 일때
`query.getSingleResult()`
- 결과가 없으면 : javax.persistence.NoResultException
- 둘 이상이면 : javax.persistence.NonUniqueResultException

### 파라미터 바인딩
#### 이름 기준
```java
em.query("select m from member m where m.username:username")
.query.setParameter("username", usernameParam);
```

#### 위치 기준
> 권장하지 않는다.
```java
em.query("select m from Member m where m.username=?1")
query.setParameter(1, usernameParam);
```