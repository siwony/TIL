---
layout: post
author: "정시원"
title: "연관관계가 필요한이유"
categories: back-end
date: 2022-03-19
tags: [spring, jpa]
---

# 연관관계가 필요한이유
### 객체를 테이블에 맞추어 모델링
**연관관계가 없는 객체**

<img width=450px src=./img/non-object-relationship.png>

### 객체를 테이블에 맞춰 모델링
**참조 대신 외래 키를 그대로 사용**
```java
@Entity
public class member{

    @Id @GeneraterValue
    private Long id;

    @Column(name = "USERNAME") 
    private String name;

    @Column(name = "TEAM_ID")
    private Long teamId;

}
@Entity
public class Team{
    @Id @GeneratedValue 
    private Long id; 
    private String name;
    //etc.....
}
```

#### 외래키 식별자를 그대로 다룬다.
```java
//팀 저장
Team team = new Team();
team.setName("TeamA"); em.persist(team);

//회원 저장
Member member = new Member();
member.setName("member1");
member.setTeamId(team.getId()); 
em.persist(member);
```

#### 식별자로 다시 조회하므로 객체지향적인 방법이 아니다.
```java
//조회
Member findMember = em.find(Member.class, member.getId());
//연관관계가 없음
Team findTeam = em.find(Team.class, team.getId());
```
### 연관관계가 필요한 이유
- 테이블은 외래키로 조인을 사용해서 연관된 테이블을 찾는다.
  
- 객체는 참조를 사용하여 연관된 객체를 찾는다.
- 서로 데이터를 저장하는 방식이 다르다.  
&rarr; 즉, 객체를 테이블에 맞추어 데이터 중심으로 모델링하면, 협력 관계를 만들 수 없다.


## 단방향 연관관계 
### 객체 지향 모델링
#### ORM Mapping
<img width=450px src=./img/object-oriented-modling.png>

#### 객체의 참조와 테이블의 외래 키를 매핑
```java
@Entity
public class Member {
    @Id @GeneratedValue
    private Long id; 

    @Column(name = "USERNAME") 
    private String name; 

    @ManyToOne
    @JoinColumn(name = "TEAM_ID")
    private Team team; 
    // etc...
```

#### 연관관계 저장 연관관계 저장
```java
//팀 저장
Team team = new Team();
team.setName("TeamA"); 
em.persist(team);

//회원 저장
Member member = new Member(); 
member.setName("member1");
member.setTeam(team); //단방향 연관관계 설정, 참조 저장 em.persist(member);
```

#### 객체 그래프 탐색
> 참조로 연관관계 조회한다.
```java
//조회
Member findMember = em.find(Member.class, member.getId());
//참조를 사용해서 연관관계 조회
Team findTeam = findMember.getTeam();
```
#### 연관관계 수정
```java

// 새로운 팀B
Team teamB = new Team(); 
teamB.setName("TeamB"); 
em.persist(teamB);

// 회원1에 새로운 팀B 설정 member.setTeam(teamB);
member.setTeam(teamB);
```
## 양방향 연관관계
<img width=450px src=./img/bidirectional-mapping.png>

- 테이블은 외래키만 있으면 서로 관계를 알 수 있다 &rarr; 애초에 양방향이라는 개념이 없다.
- 객체는 각각 참조하는 객체를 세팅해줘야 한다.
### 1. 객체 지향 모델링
#### Team 엔티티에 컬렉션 추가
```java
@Entity
public class Team{
    @Id @GeneratedValue
    private Long id;
    private String name;

    //반대편(MEMBER)에team 변수로 매핑된다. (연관관계의 주인은 반대편(MEMBER.team이다.))
    @OneToMany(mappedBy = "team")
    List<Member> mebmers = new ArrayList<Member>();
}
```
 #### 반대 방향으로 객체 그래프 탐색
```java
//조회
Team findTeam = em.find(Team.class, team.getId());
//역방향 조회
int memberSize = findTeam.getMembers().size();
```

### 2. 객체와 테이블이 관계를 맺는 차이
<img width=450 src=./img/difference-of-obejct-and-table.png>

- **객체는 연관관계가 2개이다.**
    - 회원 &rarr; 팀 연관관계 1개(단방향)
    - 팀 &rarr; 회원 연관관계 1개(단방향)
- **테이블은 연관관계가 1개이다.**
    - 회원 &harr; 팀의 연관 관계 1개(양방향)
        > 애초에 Table은 양방향이라는 개념이 존재하지 않는다.

### 3. 객체의 양방향 관계
- **객체의 양방향 관계는 사실 서로 다른 방향 관계 2개이다.**
- 객체를 양방향으로 참조하려면 단방향 2개를 만들어야 한다.

    **예시**
    - `A` &rarr; `B` (`a.getB()`)
    - `B` &rarr; `A` (`b.getA()`)
    ```java
    class A{
        B b;
    }
    class b{
        A a;
    }
    ```
### 4. 테이블의 양방향 관계
- 외래키 하나로 두 테이블의 연관관계 관리
- `MEMBER.TEAM_ID` 기본키 하나로 연관관계를 맻는다 &rarr; 양쪽으로 조인할 수 있다.

```sql
SELECT *
FROM MEMBER M
JOIN TEAM T ON M.TEAM_ID = T.TEAM_ID

SELECT *
FROM TEAM T
JOIN MEMBER M ON T.TEAM_ID = M.TEAM_ID
```

### 5. 연관관계의 주인(Owner)
> 양방향 매핑은 둘 중 하나로 외래키를 관리해야 한다.

**1. 양방향 매핑 규칙**
- 객체의 두 관계 중 하나를 연관관계의 주인으로 지정
- **연관관계의 주인만이 외래 키를 관리(등록, 수정)**
- **주인이 아닌쪽은 읽기만 가능하다.** &rarr; 조회만 가능하다.
- 주인은 `MappedBy` 속성 사용 x 

**2. 주인을 누구로?**  
: **외래키가 있는 곳을 주인으로 정한다.**
- 여기서는 `Member.team`이 연관관계의 주인이다.
- 주로 N(다) 쪽이 연관관계의 주인이 된다.  
- 비즈니스 로직을 기준으로 연관관계의 주인을 선택하면 안 된다.

<img width=450px src=./img/who-is-owner.png>

### 6. 양방향 연관관계에서 많이 하는 실수
#### 연관관계의 주인에 값을 입력하지 않았다 &rarr; 역방향
```java
Team team = new Team(); 
team.setName("TeamA"); 
em.persist(team);

Member member = new Member();
member.setName("member1")

//역방향(주인이 아닌 방향)만 연관관계 설정 
team.getMembers().add(member);

em.persist(member);
```
|ID|USERNAME|TEAM_ID|
|--|--------|-------|
|1| member1 | **null**|

#### 양방향 매핑시 연관관계의 주인의 값을 입력해야 한다.
&rarr; 순수한 객체 관계를 고려하면 항상 양쪽다 값을 입력해야 한다.
- 그렇지 않으면 객체지향 스럽지 않다.

- 양쪽에 값이 세팅되어있지 않으면 한 객체에는 값이 존재하지만,  
 반대쪽 객체에는 값이 없는 대참사가 일어난다.  
    &rarr; 나중에 테스트할 때 Empty 나 null 등 이상하게 값을 가져온다.
```java
Team team = new Team(); 
team.setName("TeamA"); 
em.persist(team);

Member member = new Member();
member.setName("member1");


team.getMembers().add(member); //연관관계의 주인에 값 설정
member.setTeam(team); 
em.persist(member);
```
|ID|USERNAME|TEAM_ID|
|--|--------|-------|
|1| member1 | 2|

### 7. 양방향 연관관계의 주의점
- **순수 객체 상태를 고려해서 항상 양쪽에 값을 세팅하자.**
- 연관관계 편의 매서드를 생성하자.(추천)
    ```java
        public class Member{
            //etc,,,

            public void setTeam(Team team){
                this.team = team;
                test.getMembers().add(this);
            }

            //etc,,,
        }
    ```
    - `setTeam` 같은 네이밍보다 `changeTeam같은` 네이밍을 권장한다.  
    &rarr; 뭔가 중요한 로직이구나 라는 것을 알아차리기 위해
    - 한 개만생성하자 &rarr; 두객체중 아무곳이나 만들어도 된다.
- 무한루프를 조심하자.  
    ex) `toString()`, `lombok`, `JSON` 생성라이브러리
    - `lombok`에서 `toString()` 생성 쓰지마라
    - `Controller`에 절대로 `Entity`를 반환하지 마라 &rarr; `DTO`로 변환하여 반환한다.

### 양방향 연관관계 정리
- **단방향 매핑만으로 이미 연관관계 매핑은 완료됐다.**  
    &rarr; 기본적으로 단방향 매핑으로 다 끝내자

- 양방향 매핑은 객체 그래프 탐색 기능이 추가된 것뿐이다.
- JPQL에서 역방향으로 탐색할 일이 많다
- 단방향 매핑을 잘 하고 양방향은 필요할 때 추가해도 된다 &rarr; 테이블은 변화가 없다.
- 양방향 연관관계는 그렇게 이득이 되는 것은 없다. &rarr; 걱정거리만 늘어난다.