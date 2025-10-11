---
layout: post
author: "정시원"
title: "Optional"
categories: programming
date: 2022-03-29
tags: [java, api, java8]
---

# Optional
### 등장 배경
#### null에 대한 문제점
- 지속적인 `NPE - NullPointException` 방어가 필요하다.
- NPE를 방어할 코드를 지속적으로 추가해야 하므로 비즈니스 로직이 복잡해진다.

#### JAVA8 이전에 메서드에서 존재하지 않는값(null)을 리턴할 수 있을 때 처리하는 방법
- 예외를 던진다. &rarr; 비용이 발생한다.
  - stack trace를 출력한다.
  - 만약 다른 예외로 throw시 추가적인 로직을 작성해야 한다.
- null을 리턴한다. &rarr; 비용 문제가 없지만 그 코드를 사용하는 개발자는 주의해야 한다.(ex. NPE)

#### 함수형 프로그래밍에서 영감을 얻다.
Java는 `존재하지 않는 값`을 표현하기위해 null을 사용한다면,  
Scala나 Haskell같은 함수형 언어들은 `존재할지 안 할지 모르는 값`을 표현할 수 있는 별개의 타입을 가지고 있다.  
&rarr; 이를 보고 영감을 받아 `Optional`이 탄생했다.

**`Optional`은 `존재할지 안 할지 모르는 값`을 다룰 수 있는 여러가지 기능들을 제공한다.**
## Optional
: `"null이 될 수도 있는 객체”`을 감싸고 있는 일종의 Wrapper Class이다.
- NPE를 유발할 수 있는 null을 직접 다루지 않아도 된다.
- 명시적으로 해당 변수가 null일 수도 있다는 가능성을 표현할 수 있다.
  > null에 대한 처리를 강제할 수 있다.

### 기본적인 사용 방법
#### Optional 변수
- 제네릭을 지원하기 때문에 선언시 명시한 타입 파라미터에 따라 감쌀 수 있다.
```java
Optional<Member> optMember;  // Member타입을 감싸는 Optional
OptionalInt maybeInteager;  // int타입의 Optional
```

### 주의할 점
#### 1. 리턴값으로만 사용하는 것을 권장한다.
> 메소드 매개변수 타입, 맵의 키 타입, 인스턴스 필드타입으로 사용하지 말자.

#### 2. Optional을 리턴하는 메소드에서 null을 리턴하지 말자.
- `Optional`자체가 해당 값이 `"존재할지 안 할지 모르는 값"`이므로 Null를 반환하면 안된다.
  > 개발에 큰 혼선을 야기한다. &rarr; Optional이 제공하는 기능을 사용하하면 NPE가 발생한다.
#### 3. 기본타입(primitive type)용 Optional이 따로 존재하므로 기본타입을 사용하고 싶으면 사용한다. 
- `OptionalInt`, `OptionalLong` 등...
  > 그냥 `Optional`를 사용하면 내부적으로 Auto boxing/unboxing이 일어나므로 오버해드가 발생한다.
#### 4. `Collection`, `Map`, `Stream Array`, `Optional`은 Opiontal로 감싸지 말자.
- 값이 비어있다는 것을 표현할 수 있는 객체이므로 `Optional`를 사용할 필요가 없다.

### Optional API 사용 방법
#### Optional 만들기
- `Optional.of(T type)`
- `Optional.ofNullable(T type)`
- `Optional.empty(T type)`

#### Optional속 값의 유무
- `isPresent()`
- `isEmpty() (Java11 부터 추가)`

예시
```java
Member member = null;
Optional<Member> optMember = Optional.of(member);
System.out.println(optMember.isPresent()); // false
System.out.println(optMember.isEmpty()); // true
```

#### Optional에 있는 값 가져오기
- `get()`
  > 만약 해당 값이 비어있다면 `NoSuchElementException`이 발생한다.  
  하지만 `get()`으로 바로 꺼내는 방식보다 앞으로 나올 방식으로 값을 꺼내 사용하는 것을 지양해야 한다.

예시
```java
Member getMember1 = Optional.of(new Member).get();

Member member = new null();
Member getMember2 = Optional.ofNullable(member).get(); //NoSuchElementException
Member getMember3 = Optional.of(member).get(); // NullPointException
```
#### Optional에 값이 있는 경우에 해당 식을 실행하기
- `ifPresent(Consumer)`
  
예시
```java
Optional<Member> optMember = Optional.of(new Member("siwony"));
Member nullMember = null;
Optional<Member> optNullmember = Optional.ofNullalbe(nullMember);

optMember.ifPresent(member -> System.out.println(member.getName)) // siwony출력
optNullmember.ifPresent(member -> System.out.println(member.getName) // 아무것도 출력되지 않음
```

#### Optional에 값이 있으면 가져오고 없는 경우에 T를 리턴하라.
- `orElse(T)`  

예시
```java
Member nullMember = null;
Optional<Member> optNullmember = Optional.ofNullalbe(nullMember);
Member newMember = optNullmember.orElse(new Member("siwony"));
System.out.println(newMember.getName()) // siwony 출력
```
- `orElse`에 넘겨준 인수는 어쩃든 어떠한 연산을 무조건한다. (임의의 값을 넘겨주기 때문)
- 상수의 값을 넘겨줄 때 사용한다.
  > 동적으로 어떠한 작업을 통해 값을 반환하기 원하면 `orElseGet`를 사용하는게 좋다.

#### Optional에 값이 있으면 가져오고 없는 경우에 해당 Supplier를 실행후 어떤 값을 리턴해라
- `orElseGet(Supplier)`
  
예시
```java
Optional<Config> optConfig = Optional.of(new Config("start"));
// 만약 config가 null이라면 status가 ready인 config 객체를 반환한다.
Config config = optConfig.orElseGet(() -> new Config("ready")); 
System.out.println(config.status); // start반환
```
- 어떠한 값을 동적으로 처리한 후 값을 반환하고 싶을 때 사용한다.

#### Optional에 값이 있으면 가져오고 없는 경우에 해당 Exception을 throw해라
- `orElseThrow(Supplier)`

예시
```java
Optional<Member> optMember = memberRepository.findByUsername("siwony");
//만약 member가 조회가 되지 않으면 MemberNotFound라는 Exceptionn(사용자 지정 Exception)을 던진다
Member member = optMember.orElseThrow(() -> new MemberNotFoundException()); 
//만약 Exception을 인수로 넘겨주지 않으면 NoSuchElementException가 발생한다.
Member member = optMember.orElseThrow();  
```
- 기본값은 `NoSuchElementException`

#### Optional에 들어있는 값 걸러내기
- `filter(Predicate)`

예시
```java
Optional<Member> optMember = memberRepository.findByUsername("siwony");
//member의 getAge()의 반환값이 18이 아니면 emtpy Optionl를 반환한다.
Optional<Member> member = optMember.filter(mmeber -> member.getAge() != 18);
```
- filter를 사용할 Optional은(optMember) 해당 객체(member)가 비어있지 않다는 가정하여 사용한다.

#### Optional에 들어있는 값 변환하기
- 무조건 Optional타입을 반환한다.
- 특정 element를 다른 형식으로 반환한다.
1. `map(Function)`
  
예시
```java
Optional<Member> optMember = memberRepository.findByUsername("siwony");
//member의 getAge()의 반환값이 18이 아니면 emtpy Optionl를 반환한다.
Optional<Integer> member = optMember.map(meber -> member.getAge());
```

2. `flatMap(Function)`
> Optional 안에 들어있는 인스턴스가 Optional인 경우에 사용한다.

예시
```java
Optional<Member> optMember = memberRepository.findByUsername("siwony");

// map을 사용하는 경우
Optional<Optional<Plan>> member = optMember.map(meber -> member.getPlan());

// flatMap을 사용하는 경우
Optional<Plan> member = optMember.flatMap(meber -> member.getPlan());
```