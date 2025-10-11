---
layout: post
author: "정시원"
title: "JPA(Java Persistence API)"
categories: back-end
date: 2022-03-19
tags: [spring, jpa]
---

# JPA(Java Persistence API)
: **데이터를 영속화 하는 API**

## JPA사용하기 이전의 문제점  
### SQL를 직접 사용
**SQL 중심적인 개발을 피하기 어렵다**
- 기존 `JDBC`만 사용하면 반복적이며 비슷한 `SQL` 문을 많이 만들어야한다.(ex. CRUD)
    > 개발자가 SQL 매퍼가 되어버린다. 
- 추가적인 요구사항이 들어왔을 때 DB query, 객체 등 의존하는 여러 코드를 수정해야 한다.
    > 만약 컬럼이 하나 더 추가된다면, 가장 먼저 SQL Query를 수정해야 할것이고,  
    > 그다음 Entity 그다음 그와 관련된 로직 등... 수정해야 된다.

### 패러다임의 불일치
> 객체지향 프로그래밍은 추상화, 캡슐화, 정보은닉, 상속, 등 시스템의 복잡성을 제어할 수 있는 다양한 장치들을 제공한다.
> <p align=right>- 어느 객체지향 개발자가</p>

- 객체와 RDB는 다른 데이터구조를 가진다. 즉, 객체로 DB를 조회할 수 없다.
- 객체지향적 설계를 하게 되면 DB table과 JAVA 객체 간의 매핑하는 소모적인 작업을 지속해야 한다.

    <img width=500px src=./img/jpa-table-object-relation.png>

    > 객체 모델은 외래키가 필요 없고 단지 참조만 있으면 되지만  
    > 테이블은 참조가 필요 없고 외래 키만 있으면 된다.


### JPA의 사용이유
- SQL 문을 개발자가 만들지 않기 때문에 **객체 중심적인 개발**을 할 수 있다.
- 특정 **RDBMS 문법에 종속적이지 않은 개발**이 가능하다.
  > **JPA는 RDBMS 벤더가 달라도 설정만 해주면 알아서 쿼리가 나간다!**
- 영속성 컨택스트는 효율적인 SQL 처리에 크게 기여하여 성능상의 이점
- 객체답게 모델링 할수록 SQL과 매핑하는 작업만 늘어나게 되어 SQL에 의존적으로 설계하게 되는 문제를   
  JPA는 객체를 마치 `List`와 같은 `Java Collection`에 저장하듯이 DB에 저장하여 문제를 해결한다.

#### JPA는 특정 DB에 종속적이지 않다.
- 각각의 데이터베이스가 제공하는 SQL 문법과 함수는 조금씩 다르다
    > DB의 방언이라고 한다.
- 가변 문자: MySQL은 `VARCHAR`, Oracle은 `VARCHAR2`
- 문자열을 자르는 함수: SQL 표준은 `SUBSTRING()`, Oracle은
`SUBSTR()`
- 페이징: MySQL은 `LIMIT` , Oracle은 `ROWNUM`

### JPA 구동 방식
<img width=400px src=./img/jpa-work.png>


### JPA의 가장 중요한 2가지
- 객체와 RDB 매핑(ORM)
- 영속성 컨텍스트