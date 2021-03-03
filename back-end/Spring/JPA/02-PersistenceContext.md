# 영속성 컨텍스트 - 내부 동작
> 영속성 컨텍스트는 JPA를 이해 하는데 가장 중요하다.
### Entity Manager Factory 와 EntityManager
<img width=400px src=./img/entity-manager-factory.png>

1. 고객이 요청을 할떄마다 Entity Manager Factory 를 통해 EntityManager를 생성한다.
2. EntityManager는 내부적으로 커넥션풀을 사용해서 DB를 사용하게 된다.
  
**주의**
- Entity Manager Factory는 하나만 생성해서 애플리케이션 전체에서 공유
- Entity Manager는 쓰레드간에 공유x (사용하고 버려야 한다)
- JPA의 모든 데이터 변경은 트랜잭션 안에서 실행한다.

### 영속성 컨텍스트
: **entity를 영구히 저장하는 환경** 
- ``ex) EntityManger.persist(entity)``  
    entity를 영속성 컨텍스트 안에 집어넣는다.
- 영속성 컨텍스트는 논리적인 개념 즉, 눈에보이지 않는다.
- EntityManager를 통해 영속성 컨텍스트에 접근한다.

### Entity의 생명주기
- ### 비영속(new/transient)  
: 영속성 컨텍스트와 전혀 관계가 없는 **새로운** 상태  
<img width=400px src=./img/not-persistence.png>

```java
//객체만 생성한 상태(비영속)
Mamber mamber = new Mamber();
member.setId("member1");
member.setUsername("회원 1");
```

- ### 영속(managed)  
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

- ### 준영속(detached)  
: 영속성 컨텍스트에 저장되었다가 **분리**된 상태  
```java
//회원 엔티티를 영속성 컨텍스트에서 분리, 준영속 상태
em.detach(member);
```
- ### 삭제(removed)  
: **삭제**된 상태  
```java
//객체를 삭제한 상태(삭제)
em.remove(member);
```

### 영속성 컨텍스트 장점
- **1차 캐시**
- **동일성(identity)보장**
- **트랜잭션을 지원하는 쓰기 지연**  
  **(transactional write-behind)**
- **변경 감지(Dirty Checking)**
- **지연 로딩(Lazy Loading)**