---
layout: post
author: "정시원"
title: "영속성 컨텍스트 - 내부 동작"
categories: back-end
date: 2022-03-19
tags: [spring, jpa]
---

# 영속성 컨텍스트 - 내부 동작
> 영속성 컨텍스트는 JPA를 이해하는데 가장 중요하다.
### Entity ManagerFactory 와 EntityManager
<img width=500px src=./img/entity-manager-factory.png>

1. 고객이 요청할 때마다 `EntityManagerFactory`를 통해 `EntityManager`를 생성한다.
2. `EntityManager`은 내부적으로 커넥션 풀을 사용해서 DB를 사용하게 된다.
  
**주의**
- `EntityManagerFactory`는 하나만 생성해서 애플리케이션 전체에서 공유해야 한다.
- `Entity Manager`은 `Threed` 간 공유하면 안 된다.
  > 사용하고 버려야 한다.
- JPA의 모든 데이터 변경은 트랜잭션 안에서 실행한다.

### 영속성 컨텍스트
: **`entity`를 영구히 저장하는 환경** 
- ``ex) EntityManger.persist(entity)``  
- `Entity`를 영속성 컨텍스트 안에 넣는다.
- 영속성 컨텍스트는 논리적인 개념 즉, 눈에 보이지 않는다.
- `EntityManager`를 통해 영속성 컨텍스트에 접근한다.

## Entity의 생명주기
### 1. 비영속(new/transient)  
: 영속성 컨텍스트와 전혀 관계가 없는 **새로운** 상태  
<img width=400px src=./img/not-persistence.png>

```java
//객체만 생성한 상태(비영속)
Mamber member = new Member();
member.setId("member1");
member.setUsername("회원 1");
```

### 2. 영속(managed)  
: 영속성 컨텍스트에 **관리** 되는 상태

<img width=400px src=./img/managed.png>

```java
// 객체를 생성한 상태 (비영속)
Member member = new Member();
member.setId("member1");
member.setUsername("회원1");
EntityManager entityManager = entityManagerFactory.createEntityManager();
entityManager.getTransaction().begin();
// 객체를 저장한 상태 (영속)
entityManager.persist(member);  //이떄 쿼리가 날라가지 않는다.
```

### 3. 준영속(detached)  
: 영속성 컨텍스트에 저장되었다가 **분리**된 상태  
```java
//회원 엔티티를 영속성 컨텍스트에서 분리, 준영속 상태
em.detach(member);
```
### 4. 삭제(removed)  
: **삭제**된 상태  
```java
//객체를 삭제한 상태(삭제) 이는 DB에서도 삭제가 된다.
em.remove(member);
```

## 영속성 컨텍스트 장점

### 1차 캐시
- 한 트랜잭션 내에서만 사용 가능하다. 즉 트랜잭션이 종료되면 사라진다.
- JPA에서는 조회시 영속성 컨텍스트를 먼저 조회한다.
<img align=center width=450px src=./img/1st-cash.png>

```java
Mamber member = new Mamber();
member.setId("member1");
member.setUsername("회원 1");

//1차 캐시에 저장
em.parsist(member);
//1차 캐시에서 조회
Member findMember = em.find(Memeber.class, "member1")
```
<img align=center width=450px src=./img/1st-cash-db.png>

```java
Member findMember2 = em.find(Member.class, "member2");
```

### 동일성(identity)보장
- 1차 캐시로 반복 가능한 읽기(REPEATABLE READ) 등급의 트랜잭션 격리 수준을 DB가 아닌 애플리케이션 차원에서 제공 한다.
- 같은 트랜잭션 내에서만 동일성을 보장한다.
```java
Member a = em.find(Member.class, "member1");
Member b = em.find(Member.class, "member1");

System.out.println(a == b); //동일성 비교 true
```

### 트랜잭션을 지원하는 쓰기 지연 - transactional write-behind
- JPA는 commit을 하기 전까지 insert query를 날리지 않아 최적화할 여지를 준다.
- 그래서 버퍼링 같은 기능을 한다. (쿼리를 모았다가 한 번에 날린다.)
<p float=left>
<img width=400px src=./img/persist-lazy.png>
<img width=400px src=./img/persist-lazy-commit.png>
</p>


```java
EntityManager em = emf.createEntityManager();
EntityTransaction tx = em.getTransaction();

//엔티티 매니저는 데이터 변경시 트랜잭션을 시작해야 한다.
tx.begin(); // [트랜잭션] 시작
em.persist(memberA);
em.persist(memberB);

//여기까지 INSERT SQL을 데이터베이스에 보내지 않는다.
//커밋하는 순간 데이터베이스에 INSERT SQL을 보낸다.
tx.commit(); // [트랜잭션] 커밋
```
### 변경 감지(Dirty Checking)
<img width=450px src=./img/dirty-checking.png>

1. 커밋된 시점에서 내부적으로 `flush()`가 호출된다.
2. `1차 캐시`의 스냅샷과 `entity`를 비교하여 객체가 변경되었는지 비교한다.
3. 2번에서 변경사항이 나오면 쓰기 지연 `SQL 저장소`에 쿼리를 미리 만들어 저장한다.
4. DB에 `update query`를 반영한다.
5. DB에 `commit` 한다.
```java
EntityManager em = emf.createEntityManager();
EntityTransaction tx = em.getTransaction();
tx.begin(); // 트랜잭션 시작

// 영속 엔티티 조회
Member memberA = em.find(Member.class, "memberA");

// 영속 엔티티 데이터 수정
memberA.setUsername("hi");
memberA.setAge(10);

/** 
/* em.update(member) 이런 코드가 있어야 하지 않을까?
/* Dirty Checking덕분에 안해도 된다.
**/

tx.commit(); // 트랜잭션 커밋
```

### Entity 삭제
```java
//삭제 대상 엔티티 조회
Member memberA = em.find(Member.class, "memberA");
em.remove(memberA); //엔티티 삭제
```