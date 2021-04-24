#### 목차
- [값 타입](./) &larr;
- [기본값 타입](./17.1-default-type.md)
- [임베디드 타입](./17.2-embedded-type.md)

# 값 타입
: 복잡한 객체 세상을 조금이나마 단순화 하려고 만든 개념이다. 따라서 값타입은 단순하고 안전하게 다룰수 있어야한다.

## JPA의 테이터 타입 분류
### Entity 타입
- `@Entity`로 정의하는 객체
- 데이터가 변해도 식별자가 지속해서 추적하능하다.
- ex) 회원 엔티티의 키나 나이 값을 변경해도 식별자로 인식가능하다.

### 값 타입
- 자바 기존타입이나 객체 &rarr; int, String 등 단순 값으로 사용하는 자바 객체
- 식별자가 없고 값만 있으므로 변경시 추적 불가하다.
- ex) 숫자 100을 200으로 변경하면 완전히 다른 값으로 대체한다.

## 기본값 타입
- 생명주기를 Entity에 의존한다.
- 값 타입을 공유하면 안된다.
- ex) String, name, int age

#### 자바의 기본 타입은 절대 공유를 안한다.
- int, double과 같은 기본 타입(primitive type) 은 절대 공유x
- 기본 타입은 항상 값을 복사한다.
- 래퍼 클래스 혹은 String 같은 특수한 클래스는 공유가능한 객체이지만 변경x

#### 기본타입일 경우
```java
int a = 10;
int b = a;

a = 20;

System.out.println("a = " a); // a = 20 출력
System.out.println("b = " b); // b = 10 출력
```
공유불가능, 변경됨
#### 래퍼 클래스일 경우
```java
Integer a = new Integer(10);
Integer b = a;

//a.setValue(20) // 만약 이렇게 값을 바꾸는 즉 변경할 수 없다.

System.out.println("a = " a); // a = 10 출력
System.out.println("b = " b); // b = 10 출력
```
공유가능, 변경 안됨

## 임베디드 타입
> 결국 객체지향스럽게 개발을 하려고 쓰는것이다.

: 새로운 값 타입을 직접 정의할 수 있다.
- JPA는 임베디드 타입(embedded type)이라 한다.
- 주로 기본 값 타입을 모아서 만들어서 복합 값 타입이라고 한다.
- int, String과 같은 값 타입

### 임베디드 타입 사용법
- `@Embeddable`: 값 타입을 정의하는 곳에 표시
- `@Embedded`: 값 타입을 사용하는 곳에 표시
- 기본 생성자 필수

### 임베디드 에제
#### 요구사항
- 회원 엔티티는 이름, 근무 시작일, 근무 종료일, 주소 도시, 주소 번지, 주소 우편번호를 가진다. 
    >  근데 이렇게 하면 뭔가 근무시작일 및 종료일, 주소 도시, 번지, 우편번호 를 뭔가 공통적으로 묶어서 클래스타입을 만들고 싶지 않는가?

  <img width=100px src=./img/embedded-member.png>

- 다음과 같이 회원 엔티티는 이름, 근무 기간, 집 주소를 가진다. &rarr; 좀더 추상화를 해봤다.  
  <img width=300px src=./img/embedded-member-2.png>

#### 최종 설계
<img width=450px src=./img/embedded-type-modling.png>

- 결국 그냥 클래스를 쪼갠것이다
  
#### 임베디드 타입과 테이블 메핑
<img width=450px src=./img/embedded-type-table-mapping.png>

- DB입장에서는 변경할것이 없다. &rarr; DB는 테이터를 잘 다루기만 하면 되니까...
- 하지만 객체는 데이터 뿐만아니라 매서드라고 하는 기능, 행위까지 들고 있기 때문에 이렇게 묶어서 얻는 이득이 많다.

#### 코드
```java
// Period 기간 entity 
@Embeddable
@Getter @Setter
public class Period{

    private LocalDateTime startDate;
    private LocalDateTime endDate;
}

// Address 주소 entity
@Embeddable
@Getter @Setter
public class Address{

    private String city;
    private String street;
    private String zipcode;
}

// Member entity
@Entity
@Getter @Setter
public class Member{
    
    @Id @GeneratedValue
    private Long id;

    private String username;

    @Embedded
    private Period period;

    @Embedded
    private Address address;
}
```


### 임베디드 타입 장점
- 재사용할 수 있다.
- 높은 증집도
- `Perid.isWrok()`처럼 해당 값 타입만 사용하는 의미 있는 메소드를 만들 수 있다.
- 임베디드 타입을 포함한 모든 값 타입은, 값 타입을 소유한 엔티 티에 생명주기를 의존함

### 결국 임베디드란?
- 엔티티의 값일 뿐이다.
- **임베디드 타입을 사용하기 전과 후에 매핑하는 테이블은 같다.**
- 객체와 테이블을 아주 세밀하게(find-grained) 매핑하는것이 가능하다.
- 잘 설계한 ORM 애플리케이션은 매핑한 테이블 수보다 클래스의 수가 더 많다.