---
layout: post
author: "정시원"
title: "플러시(flush)"
categories: back-end
date: 2022-03-19
tags: [spring, jpa]
---

# 플러시(flush)
: **영속성 컨텍스트의 변경내용을 DB에 반영하는 것**
- 영속성 컨텍스트를 비우지 않는다.
- 영속성 컨텍스트의 변경내용을 DB에 동기화한다.
- `transaction`이라는 작업 단위가 중요하다. -> 커밋 직전에만 동기화 하면 된다.

> 앞으로 예제 코드는 다음을 생략합니다.
> ```java
>  EntityManager em = emf.createEntityManager();
>  EntityTransaction transaction = em.getTransaction();
>  transaction.begin(); // [트랜잭션] 시작
> ...
>  //(예제 코드 ...)
> ...
> tx.commit();
>  ```

### 플러시 발생 시 일어나는 일들
- 변경 감지(Dirty check)
- 수정된 엔티티 쓰기 지연 SQL 저장소에 등록
- 쓰기 지연 SQL 저장소의 쿼리를 DB에 전송(등록, 수정, 삭제 쿼리)  
  > **1차 캐시가 비워지는것이 아니다.**
    
### 플러시를 발생시키는 방법
- `em.flush()` - 직접 호출
- 트랜잭션 커밋 - 플러시 자동호출
  `transaction.commit`
- `JPQL Query` 실행 - 플러시 자동 호출
    ```java
    em.persist(memberA);
    em.persist(memberB);

    //중간에 JPQL 실행
    query = em.createQuery("selete m from Member m" , Member.class);
    List<Member> members= query.getResultList();
    ```
    `JPQL`를 실행하면 DB에서 조회하므로 쓰기 지연 SQL 저장소에 있는 쿼리를 DB에 날리고 `JPQL`문을 실행한다. 

### 플러시 모드 옵션
- `FlushModeType.AUTO` (기본값)  
  : `commit` 이나 `query`를 실행할 때 `플러시`  

- `FlushModeType.COMMIT`  
  : 커밋할 때만 플러시

COMMIT옵션을 사용할 일이 별로 없다. - 김영한
  