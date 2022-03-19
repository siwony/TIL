# 프로젝션
: SELECT 절에 조회할 대상을 지정하는것
- 프로잭션으로 관리되는 Entity는 모두다 영속성 컨텍스트에 관리된다.
### 프로젝션 대상
### 1. 엔티티
#### **`SELECT m FROM Member m`**
```java
List<Member> result = 
  em .createQuery("SELECT m FROM Member m", Member.class).getResulteList();

Member findMember = result.get(0);
findMember.setAge(20) //업데이트 쿼리가 나간다 즉 영속성 컨텍스트에 관리가 된다.
```
> JPQL에서 조회한 Member는 영속성 컨텍스트에 관리된다.  
> &rarr; Age를 변경했더니 업데이트 쿼리가 나갔다.

#### `SELECT m.team FROM Member m`
> Memeber에서 Team을 가져오려면 결국 Member와 Team을 join해야한다.
```java
//List<Team> result = em .createQuery("SELECT m.team FROM Member m", Team.class).getResulteList(); // 명시적조인
//
List<Team> result = 
  em .createQuery("SELECT t FROM Member m join m.team t", Team.class).getResulteList();
```
- `SELECT m.team FROM Member m`과 같이 **묵시적 조인**을 하지 않는게 좋다.
  >나중에 운영하면서 쿼리를 튜닝해야 할떄가 생긴다.
- `SELECT t FROM Member m join m.team t` 와 같이 **명시적 조인**을 하자

### 2. 임베디드
#### `SELECT m.address FROM Member m`
>address는 city, street, zipcode를 가지고 있는 임베디드 타입이다.
- `select address from Address a` 와 같이 사용할 수 없다 **어디에 소속되어 있는지 명시 줘야한다.**

### 3. 스칼라 타입
#### `SELECT m.username, m.age FROM Member m` 
- DISTINCT로 중복 제거 &rarr; 중복된 데이터 제거
  ```java
  em.createQuery("select distinct m.username, m.age from Member").getResultList();
  ```
  
### 여러 값 조회
`SELECT m.username, m.age FROM Member m`
#### 1. Query 타입으로 조회
> 가장 권장하지 않는다. 너무 귀찮다.
```java
List resultList = 
  em.createQuery("SELECT m.username, m.age FROM Member m").getResultList();

Object o = resultList.get(0);
Object [] result = (Obejct[]) o;
System.out.println("username = " + result[0]) // username = 조회된_유저이름
System.out.println("age = " + result[1]) // username = 조회된_유저나이
```
#### 2. Object[] 타입으로 조회
> 이것도 권장하지 않는다.
```java
List<Obejct[]> resultList = 
  em.createQuery("SELECT m.username, m.age FROM Member m").getResultList();

Object[] result = resultList.get(0);
System.out.println("username = " + result[0]) // username = 조회된_유저이름
System.out.println("age = " + result[1]) // username = 조회된_유저나이
```
#### 3. new 명령어로 조회
> 제일 간단하다.  
`SELECT new jpabook.jpql.UserDTO(m.username, m.age) FROM Member m`  
- 패키지 명을 포함한 전체 클래스 명을 입력해야한다. &rarr; 문자열이기 때문에 무조건 클래스명을 명시해야 한다.
- 순서와 타입이 일치하는 생성자 필요하다.
**MemberDto**
```java
@Getter @Setter
public class MemberDto{
  private String username;
  private int age;

  public MemberDto(String username; int age){
    this.username = username;
    this.age = age;
  }
}
```
**결과**
```java
List resultList = 
  em.createQuery("SELECT new foo.MemberDto(m.username, m.age) FROM Member m").getResultList();

MemberDto memberDto = result.get(0);

System.out.println("username = " + memberDto.getUsername()) // username = 조회된_유저이름
System.out.println("age = " + memberDto.getAge()) // username = 조회된_유저나이
```