# Eager/LAZY loading
### 과연 Member만 조회할때 Team도 조회해야 할까?
<img width=400px src=./img/when-member-get-team.png>

- 단순히 Member만 조회하는 로직에서는 굉장히 비효율적이다.
- Member를 조회하는데 Team을 조회하는 비효율적인 상황이 일어난다.

**&rarr; LAZY(지연) loading을 이용하여 이 부분을 해결할 수 있다.**

### LAZY
: 연관된 엔티티를 즉시(Eager)로 가져오는것이 아닌 Proxy(대리자) 객체를 통해 필요할때만 연관된 엔티티를 가져오는것  
`fetch = FetchType.LAZY`  
> 비즈니스 로직에서 연관된 엔티티를 조회하는 경우가 별로 없는경우

<img width=450px src=./img/lazy-loading.png>

```java
@Entity
public class Member {

@Id @GeneratedValue 
private Long id;

@Column(name = "USERNAME")
private String name; 

@ManyToOne(fetch = FetchType.EAGER) //** @JoinColumn(name = "TEAM_ID")
private Team team;
//etc....
}
```
- 실제로 LAZY를 통해 조회를하면 Team의 프록시 객체를 조회한다.  
  &rarr; Proxy객체는 아무값도 없다.

### 1. LAZY를 사용한 프록시를 통한 조회
<img width=450px src=./img/lazy-proxy-find.png>

```java
Team team = member.getTeam(); // 프록시 객체
team.getTeam // 실제 Team을 사용하는 시점에서 초기화 -> 이때 쿼리를 날린다.
```
- Member 단독으로 조회할 경우에는 LAZY가 효율적이다.
- Member가 90%정도 단독으로 사용한다면 LAZY가 효율적이다.
- 하지만 Member와 Team을 동시에 조회해야 할 경우가 엄청 많은경우 EAGER(즉시) loading이 이득이다.

### EAGER
: 한방쿼리를 날려 연관된 엔티티를 한꺼번에 조회한다. &rarr; Proxy가 필요 없다.  
`fetch = FetchType.EAGER`  
> 비즈니스 로직에서 연관된 엔티티를 조회하는 경우가 많은 경우

<img width=450px src=./img/eager-loading.png>

### 1. EAGER를 사용한 조회
<img width=400px src=./img/eager-find.png>

- JPA 구현체는 가능하면 조인을 사용하여 SQL을 한번에 함께 조회한다.

### 2. EAGER 주의 사항 - 실무경험 공유 
- **가급적 지연 로딩만 사용하자(특히 실무에서)**
- 즉시로딩을 적용하면 예상치 못한 SQL이 발생한다.
  > 연관된 테이블이 10개 이상이라고 생각해보자 끔찍하다.
- **즉시로딩은 JPQL에서 N + 1 문제를 발생한다.** &rarr; 그냥 LAZY로 설정하고 FETCH JOIN을 사용하자.
  1. 만약 `select m from Member m` 라는 JPQL을 사용하면 &rarr; 대충 쿼리가 select * form member 이런식으로 나간다..
  2. Member를 조회했지만 연관된 엔티티가 EAGER로 되어있다.
  3. 그러면 다시한번 연관된 엔티티를 조회하기 위해 query가 또나온다.
    > N + 1: (1)처음 쿼리를 날리면 (N)개의 쿼리가 따라온다.
- `@OneToMany`, `@ManyToMany`는 기본이 지연로딩이다.

## 마무리 - 실무 
#### 모든 연관관계에 지연 로딩을 사용해라
#### 실무에서 즉시 로딩을 사용하지 마라 &rarr; 상상치 못한 쿼리가 나간다.
#### JPQL fetch 조인이나, 엔티티 그래프 기능을 사용해라
