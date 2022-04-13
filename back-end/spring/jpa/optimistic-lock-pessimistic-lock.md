# 비관적 락, 낙관적 락

## 1. 낙관적 락 - Optimistic Lock
데이터 갱신시 충돌이 발생하지 않을 것이라고 낙관적으로 가정하는 방법이다.

- JPA 제공하는 버전 관리 기능을 사용한다.
- 커밋하기 전까지 트랜잭션 충돌을 알 수 없다.

### 1-1. JPA에서의 비관적 락 - @Version
`@Version` 어노테이션은 JPA에서 버전 관리를 위해 제공하는 어노테이션이다.  
```java
@Entity
public class Member{
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Version
    private int version;
}
```
위와 같이 `@Version`어노테이션을 붙이면 version필드가 1씩 자동으로 증가한다.  
그리고 엔터티를 수정할 때 주회 시점의 버전과 수정 시점의 버전이 다르면 예외를 발생시킨다.

`@Version`를 사용하면 최초 커밋만 인정하기 때문에 예외가 발생한다.

이게 가능한 이유는 JPA의 영속상태의 엔터티에 있는 버전과 DB 버전를 비교하고 같으면 버전을 1증가하여 수정한다.
```sql
UPDATE BOARD
SET
    name=?,
    VERSION=? (버전 + 1 증가)
WHERE
    ID=?
    AND VERSION=? (버전 비교)
```
그렇지 않으면 where문에서 조건이 달라지므로 수정할 대상이 없어진다. 이 경우 아래와 같은 예외가 발생한다.


> 낙관적 락 예외
> - javax.persistence.OptimisticLockException - JPA 예외
> - org.hibernate.StaleObjectStateException - 하이버네이트 예외
> - org.springframework.orm.ObjectOptimisticLockingFailureException - 스프링 예외 추상화


#### 주의사항
- 당연하게도 `@Version`이 달린 필드는 JPA가 관리하므로 특수한 상황 외에는 임의로 수정하면 안된다.
    > 벌크 연산 시 버전을 무시한다.
- 버전은 엔터티의 값을 변경하면서 증가한다.
  - 연관관계 필드의 경우, 주인 필드를 수정할 때만 버전이 증가한다.


## 2. 비관적 락 - Pessimistic Lock
> 트랜잭션 충돌이 발생한다고 가정하고 락을 건다.

- DB가 제공하는 락 기능을 사용한다.
  > ex. `select for update`

#### 특징
- 엔터티가 아닌 스칼라 타입을 조회할 때 사용될 수 있다.
- 데이터를 수정하는 즉시 트랜잭션 충돌을 감지할 수 있다.

### 2-1. JPA 비관적 락 (LockModeType)
DB 트랜잭션 락 메커니즘에 의존하는 방법이다.

#### 1. PESSIMISTIC_READ
`dirty read`가 발생하지 않을 떄 `Shared Lock`을 획득하고 데이터가 `UPDATE`, `DELETE`를 방지할 수 있다.
> PESSIMISTIC_READ를 지원하지 않으면 PESSIMISTIC_WRITE로 대체된다.

#### 2. PESSIMISTIC_WRITE
`배타적 잠금 - Exclusive Lock`을 획득하고 데이터를 다른 트랜잭션에서 `READ`, `UPDATE`, `DELETE`하는 것을 방지할 수 있다.

#### 3. PESSIMISTIC_FORCE_INCREMENT
버전 정보를 강제로 증가시킨다.
- 유일하게 버전 정보를 사용한다.
- `PESSIMISTIC_WRITE`와 유사하게 작동하지만 `@Version`이 지정된 Entity와 협력하기 위해 도입되었다.
