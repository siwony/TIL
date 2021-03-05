# 플러시(flush)
: **영속성 컨텍스트의 변경내용을 DB에 반영**
### 플러시 발생
- 변경 감지(Dirty check)
- 수정된 엔티티 쓰기 지연 SQL 저장소에 등록
- 쓰기 지연 SQL 저장소의 쿼리를 DB에 전송(등록, 수정, 삭제 쿼리)  
  **1차 캐시가 비워지는것이 아니다.**
    
### 플러시 방법
- **`em.flush()` - 직접 호출**
- **트랜잭션 커밋 - 플러시 자동호출**
  `transaction.commit`
- **JPQL Query 실행 - 플러시 자동 호출**
    ```java
    em.persist(memberA);
    em.persist(memberB);

    //중간에 JPQL 실행
    query = em.createQuery("selete m from Member m" , Member.class);
    List<Member> members= query.getResultList();
    ```
    JPQL를 실행하면 DB에서 조회를 하기 떄문에 쓰기 지연 SQL 저장소에 있는 쿼리를 DB에 날리고 JPQL문을 실행한다. 