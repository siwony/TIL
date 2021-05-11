# 쿼리 메소드 기능
> 만약 findByUsername같이 Entity 종속적인 기능을 사용하려면 어떻게 해야 할까? Spring JPA는 쿼리 메소드라는것을 제공한다.
#### 쿼리 메소드 기능 3가지
- 메소드 이름으로 쿼리 생성
- 메소드 이름으로 JPA NamedQuery 호출
- `@Query` 어노테이션을 사용해서 리파지토리 인터페이스에 쿼리 직접 정의

### 메소드 이름으로 쿼리 생성
: 메소드 이름을 분석하여 JPQL 쿼리를 실행한다.

이름과 나이를 기준으로 회원을 조회하려면?
#### 순수 JPA Repository 코드
```java
 public List<Member> findByUsernameAndAgeGreaterThan(String username, int age) {
      return em.createQuery("select m from Member m where m.username = :username
  and m.age > :age")
              .setParameter("username", username)
              .setParameter("age", age)
              .getResultList();
}
```

#### Spring Data JPA
```java
public interface MemberRepository extends JpaRepository<Member, Long> {
    List<Member> findByUsernameAndAgeGreaterThan(String username, int age);
}
```
- 쿼리 메소드 필터 조건: [공식문서 참고](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#jpa.query-methods.query-creation)
- 조회: find...By, read...By, get...By
  > findHelloBy 처럼 ...에 식별하기 위한 내용(설명)이 들어가도 된다.  
  > 자세한건 공식문서
- `COUNT`: count...By 반환타입 `long`
- `EXISTS`: exists...By 반환타입 `boolean`
- 삭제: delete...By, remove...By 반환타입 `long`
- `DISTINCT`: `findDistinct`, `findMemberDistinctBy`
- `LIMIT`: `findFirst3`, `findFirst`, `findTop`, `findTop3`

> 참고: 필드명이 변경되면 인터페이스에서도 똑같이 변경해줘야 한다.  
> 그렇지 않으면 애플리케이션 시작 시점에 에러가 나온다.  
> 이러한점이 JPA큰 장점이다.

### 메소드 이름으로 JPA NamedQuery 호출
: JPA의 NamedQuery를 호출할 수 있다.
> 실무에서 사용할 일이 별로 없다.  
> 대신 `@Query`를 사용하여 Repository 메소드에 쿼리를 직접 정의한다.

#### `@NamedQuery` 어노테이션으로 Named 쿼리 정의
```java
@Entity
@NamedQuery(
    name="Member.findByUsername",
    query="select m from Member m where m.username = :username"
)
public class Member{
    ...
}
```
#### JPA를 직접 사용해서 Named 쿼리 호출
```java
public class MemberRepository {
    public List<Member> findByUsername(String username) {
        ...
        List<Member> resultList = 
        em.createNamedQuery("Member.findByUsername", Member.class)
                .setParameter("username", username)
                .getResultList();
    }
}
```
#### DATA JPA를 사용하여 Named 쿼리 호출
```java
@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
//    @Query(name = "Member.findByUsername") //생략가능하다. 알아서 위에 선언된 Member를 찾아간다.
    List<Member> findByUsername(@Param("username") String username);
}
```
- Spring Data JPA는 선언한 "도메인 클래스 + . + 메서드 이름' 으로 Named 쿼리를 찾아서 실행한다.
- 실행할 Named 쿼리가 없으면 메서드 이름으로 쿼리 생성 전략을 사용한다.
- 필요하면 전략을 변경 가능하지만 권장x
  > [참고](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#repositories.query-methods.query-lookup-strategies) 

### @Query를 사용하여 Repository 매서드에 쿼리 정의하기
> 가장 권장하는 방식이다.  
> 메소드 이름으로 쿼리 생성 기능은 파라미터가 증가하면 메서드 이름이 매우 지저분해진다.  
> **복잡하면 주로 `@Query`를 통해 실무에서 많이 사용한다.**

#### 메서드에 JPQL 쿼리 작성
```java
public interface MemberRepository extends JpaRepository<Member, Long> {
    @Query("select m from Member m where m.username= :username and m.age = :age")
    List<Member> findUser(@Param("username") String username, @Param("age") int
    age);
}
```
- `@org.springframework.data.jpa.repository.Query` 어노테이션을 사용한다.
- 실행할 메서드에 정적 쿼리를 직접 작성하므로 이름 없는 Named 쿼리라 할 수 있음
- **JPA Named 쿼리처럼 애플리케이션 실행 시점에 문법 오류를 발견할 수 있다!**

### DTO 조회하기
예제 DTO
```java
@Data
  public class MemberDto {
      private Long id;
      private String username;
      private String teamName;
      public MemberDto(Long id, String username, String teamName) {
          this.id = id;
          this.username = username;
          this.teamName = teamName;
      }
}
```
예제 Repository
```java
    @Query("select new com.study.datajpa.dto.MemberDto(m.id, m.username, t.name) from Member m join m.team t")
    List<MemberDto> findMemberDto();
```
- JPA `new` 명령어를 사용하고, 생성자가 맞는 DTO가 필요하다.  
  &rarr; JPA와 사용방식이 동일하다.

### 파라미터 바인딩
#### 위치기반
> 실무에서 사용하지 않는다. 가독성및 유지보수성이 매우 떨어진다.
```sql
select m from Member m where m.username = ?0
```

#### 이름기반
```sql
select m from Member m where m.username = :name
```

파라미터 파인딩
```java
public interface MemberRepository extends JpaRepository<Member, Long>{

    @Query("select m from Member m where m.username = :name")
    Member findMembers(@Param("name") String username);
}
```

#### 컬렉션 파라미터 바인딩
`Collection` 타입으로 in절을 지원한다.
```java
    @Query("select m from Member m where m.username in :names")
    List<Member> findByNames (@Param("names") Collection<String> names);
```

### 반환타입
> Spring Data JPA는 여러 반환타입을 지원한다.
```java
List<Member> findListByUsername(String username); //컬렉션
Member findMemberByUsername(String username) //단건
Optional<Member> findOptionalMemberByUsername;
```

#### 컬렉션 
> List 등...

- 결과가 없을떄는 빈 빈 컬렉션을 반환한다. &rarr; null에대한 보장을 해준다.

#### 단건 조회
- 결과 없음: null 반환
- 결과가 2건 이상 : `javax.persistence.NonUniqueResultException` 예외 발생

#### 참고 단건 조회결과가 없을때 JPA와 data JPA의 차이
>Spring Data JPA는 내부에서 JPQL의 `Query.getSingleResult()` 메서드를 호출한다.  
>조회 결과가 없으면 `javax.persistence.NoResultException` 예외가 하지만  
>스프링 데이터는 JPA는 예외를 무시하고 대신 null을 반환한다.