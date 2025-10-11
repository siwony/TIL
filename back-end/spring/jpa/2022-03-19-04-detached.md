---
layout: post
author: "정시원"
title: "준 영속 상태"
categories: back-end
date: 2022-03-19
tags: [spring, jpa]
---

# 준 영속 상태 
: **영속 상태의 Entity가 영속성 컨텍스트에서 분리되는 것**
- 영속에서 준 영속으로 바뀌는 상태
- 준 영속상태에서는 영속성 컨텍스트가 제공하는 기능을 사용할 수 없다.

> 앞으로 예제 코드는 다음을 생략한다.
> ```java
>  EntityManager em = emf.createEntityManager();
>  EntityTransaction transaction = em.getTransaction();
>  transaction.begin(); // [트랜잭션] 시작
> ...
>  //(예제 코드 ...)
> ...
> tx.commit();
>  ```

### 준 영속 방법
#### 1. `em.detach(영속된 엔티티 객체)`  
  : 특정 `Entity`만 준 영속상태로 바꾼다.
  ```java
  Member member = em.find(Member.class, 150L); 
  member.setName("siwony_");  

  em.detach(member); //준영속

  tx.commit();  // insert 쿼리문이 날아가지 않는다.
  ```
  - `selete` 쿼리만 날아가고 `insert` 쿼리는 날아가지 않는다.
  - 즉, 영속성 컨텍스트의 기능인 변경 감지(Dirty check)가 작동하지 않는다.

#### 2.`em.clear()`  
  : 영속성 컨텍스트를 완전히 초기화 한다.
  ```java

  Member member = em.find(Member.class, 150L); //select 쿼리 나감
  member.setName("siwony_");  

  em.clear(); //영속성 컨텍스트를 초기화 한다.

  Member member2 = em.find(Member.class, 150L); //select 쿼리 나감
  tx.commit(); 
  ```
  중간에 한번 `em.clear();`를 했기 때문에 select 쿼리가 두 번 나간다.
  > test code를 작성할 때 유용하다.

#### `em.close`
  : **영속성 컨텍스트를 종료한다.**