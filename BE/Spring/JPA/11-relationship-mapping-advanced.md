# 고급매핑 - 상속관계 매핑
> JPA는 DB의 **슈퍼타입/서브타입** 과 같은 **어떠한 논리적 기법을 어떤 3개가지 방법으로 매핑을 하던 모든 매핑을 지원한다.**
### 상속관계 매핑
: 객체의 상속과 구조와 DB의 슈퍼타입 서브타입 관계를 매핑하는것   
<img width=550px src=./img/inheritance-relationship-mapping.png>

: 객체의 상속, 구조, DB의 슈퍼타입 서브타입 관계를 매핑한다.
- 객체는 상속관계가 있지만, DB는 상속관계가 없다.
- **슈퍼타입 서브타입 관계라는 모델링 기법**이 객체 상속과 유사하다.

### 상속관계 매핑의 종류
- 조인 전략 &rarr; 각각 테이블로 변환
- 단일 테이블 전략 &rarr; 통합 테이블로 변환
- 구현 클래스마다 테이블 전략 &rarr; 서브타입 테이블로 변환

### 1. 조인 전략
: 각각 테이블로 변환한다.  
> 굉장히 정규화된 방법이다. 설계를 기본적으로 깔고 들어가야한다.  

<img width=500px src=./img/join-strategy.png>

- `@Inheritance(strategy = InheritanceType.JOINED)`
- 슈퍼타입 테이블의 PK를 서브타입 테이블의 PK겸 FK로 둔다.
- 그후 상위 테이블은 조인할 테이터를 구분할 수 있는 구분 컬럼을 둔다.

#### 장점
- 테이블을 정규화 할 수 있다
- FK 참조 무결성 제약조건 활용가능하다
- 저장공간이 효율화 된다.

#### 단점
- 조회시 조인을 많이 사용한다. &rarr; 성능 저하
  >근데 그렇게 크게 문제가 될건 아니다. - 김영한
- 조회 쿼리가 복잡하다.
- 데이터 저장시 INSERT SQL 2번 호출한다.

#### 예시 코드
```java
@Entity
@Inheritance(strategy = InheritanceType.JOINED) 
@DiscriminatorColumn // 무슨타입인지 컬럼추가
public abstract class Item{

    @Id @GeneratedValue
    private Long id;

    private String name;
    private int price;
}

@Entity
@DiscriminatorValue("A") //이렇게 DTYPE을 지정 할 수 있다.
public class Album extends Item{

    private String artist;
}

@Entity
public class Movie extends Item{

    private String director;
    private String actor;
}

@Entity
public class Book extends Item{

    private String author;
    private String isbn;
}
```

### 2. 단일 테이블 전략
: 통합 테이블로 변환한다. &rarr; 걍 다 합쳐버린다.  
> 테이블은 단순하지만 객체지향적으로 상속하게 되어있을수 있다.

<img width=500px src=./img/single-table-strategy.png>

- 성능적으로 좋다. 쿼리도 적게 나간다.
- 테이블이 단일 테이블이라 내가 무슨 타입인지 모르므로 기본으로 DTYPE이 들어간다.  
  >조인 전략은 어쨌든 DTYPE없어도 내가 무엇인지 찾을 수 있지만...

#### 장점
- 일반적으로 조회 성능이 빠르다. &rarr; 조인이 필요 없으므로 
- 조회 쿼리가 단순하다.

#### 단점
- 데이터 무결성에 문제가 있다. &rarr; 자식 엔티티가 매핑한 컬럼은 모두 null을 허용한다.
- 조회 성능이 오히려 느려질 수 있다. &rarr; 단일 테이블에 모든 것을 저장하므로 테이블이 커질 수 있기때문
  > 이정도 임계점을 넘기가 힘들다

#### 예시코드
> 그냥 상위 Entity에 `Inheritance(strategy = InheritanceType.SINGLE_TABLE)` 를 해주면 된다.
```java
@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE) 
//@DiscriminatorColumn // 이거 없어도 DTYPE이 넣어진다. 필수적으로 생성된다.
public abstract class Item{

    @Id @GeneratedValue
    private Long id;

    private String name;
    private int price;
}
```


### 3. 구현 클래스마다 테이블 전략
: 서브타입 테이블로 변환한다. &rarr; 중복되어도 그대로 사용한다.   
**이 전략은 DB설계자와 ORM 전문가 둘 다 추천하지 않는다!**
> 너무 비효율적이다. 모든 테이블을 다 찾아야된다. 이건 쓰면 안된다!
 
<img width=600px src=./img/each-implements-class-table-strategy.png>

- 중간의 아이템을 만들지 않고 중복되는 컬럼을 각각의 테이블에 넣는다.


#### 장점
- 서브 타입을 명확하게 구분해서 처리할 때 효과적
- NotNull 제약조건을 사용할 수 있다.

#### 치명적인 단점
- 여러 자식 테이블을 함께 조회할때 성능이 느리다. &rarr; UNION SQL QUERY를 날려야한다.
- 자식 테이블을 통합해서 쿼리하기 어렵다 &rarr; 변경이라는 관점에서 보면 엄청 안좋다.

#### 예시코드
```java
@Entity
@Inheritance(strategy = InheritanceType.TABLE_TER_CLASS) 
//@DiscriminatorColumn  의미가 없다. 테이블 자체가 다르다.
public abstract class Item{

    @Id @GeneratedValue
    private Long id;

    private String name;
    private int price;
}
```

### DTYPE
: 상속관계 매핑시 부모 클레스에서 자식 클래스를 구분할 컬럼명이다.
- `@DiscriminatorColumn`
- DTYPE의 기본값은 각 자식의 클래스명이다.
- `@DiscriminatorValue("사용자지정값")` 처럼 자식테이블에 지정해 줄 수 있다.

**DTYPE 필요한 이유**
- 객체에서 봤을때는 무엇을 조인해야되는지 알 수 있다.
- 하지만 DB에 쿼리를 날렸을때 어떠한 테이블로 인하여 값이 들어왔는지모른다.  
  (Album? Movie? Book?)
- DTYPE은 운영상 있는게 좋다.