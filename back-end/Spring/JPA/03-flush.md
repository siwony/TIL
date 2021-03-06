# 플러시(flush)
: **영속성 컨텍스트의 변경내용을 DB에 반영**
- 영속성 컨텍스트를 비우지 않는다.
- 영속성 컨텍스트의 변경내용을 DB에 동기화한다.
- `transaction`이라는 작업 단위가 중요하다. -> 커밋 직전에만 동기화 하면됨

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

### 플러시 모드 옵션
`em.setFlushmode(FlushModeType.COMMIT)`
- **`FlushModeType.AUTO`** (기본값)  
  **commit 이나 query를 실행할 때 플러시**  
- **`FlushModeType.COMMIT`**  
  **커밋할 때만 플러시**  
  >사용할 경우가 별로 없다. 그냥 기본값으로 써라! - 김영한
  