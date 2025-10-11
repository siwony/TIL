---
layout: post
author: "정시원"
title: "Java Beans"
categories: programming
date: 2022-03-29
tags: [java]
---

# Java Beans
> EJB(Enterprise Java Beans)와 전혀 다르다.

**자바빈즈(Java Beans)** 는 자바(Java)로 작성된 소프트웨어 컴포넌트를 일컫는 말로 데이터 표현을 목적으로하는 자바 클래스다.
- Java Beans클래스는 `Java Beans Convention`를 지켜야 한다.
- 주로 GUI에서 사용한다.
- 이 모든 규칙을 따를 필요는 없다.
  > GUI툴을 사용할 거 아니라면
 
오늘날 우리는 클래스들의 특정 프로퍼티에 접근하는 여러 프레임워크가 있다. ex. Spring, JPA, thymleaf  
이러한 툴들이 이런 객체들의 프로퍼티에 접근하기 위해 어떠한 메서드에 접근해야 하는지 일관적인 방법이 필요하다.  
이미 Java Bean규약에 정의되어 있으므로 이 규약을 일부 따르고 있다.

## Java Beans Convention
- JavaBeans의 목적은 여러가지 객체를 하나의 객체(Bean)에 담기 위함이다.
- JavaBeans의 규칙을 다른사람과 협업을 하기 위한 프로토콜이라고 이해하는게 편하다.
  > JavaBeans의 규칙에 따르는 툴들이 규칙에 따라 객체에 접근 할 수 있다. ex. jackson 라이브러리


### 1. 모든 필드는 `private`이며, `getter`/`setter`메서드를 통해서만 접근이 가능하다.
- 필드에 대한 완벽한 제어를 하기위함이다
- `캡슐화 - Encapsulation`를 지키기 위함이다.

#### boolean값은 어떤 형식으로 getter와 setter를 만들어야 할까?
만약 User라는 객체가 있고 이 User가 만료되어 있는지 확인하기 위해 `expired`라는 boolean형 값을 가진다고 해보자
```java
public class User{
  ...
  boolean expired = false;
  ...
}
```
그러면 어떻게 getter를 만들어야 할까? 그냥 `getExpired`라고 하면 될까?

하지만, JavaBeans spec에서는 boolean의 getter를 만들 떄 is를 사용한다.   
그러면 `expired`의 getter는 `isExpired`가 된다.

### 2. Argument가 없는(no-argument) public 생성자가 존재한다.
> 개인적으로 불변 객체를 만드는 방법과 반대인 거 같아서 부정적인 의견이다. 
- 생성자에 Argument가 없다면 필요한 데이터만 할당해주면 된다.
- 기본 생성자로 객체를 생성하고, `getter`/`setter`를 호출해 할당하면 Argument에 관여받지 않고 할당이 가능하다.
- 리플렉션을 통한 객체를 생성하기 쉽다.

### 3. `java.io.Serializable`인터페이스를 구현한다. 
- 우리는 메모리에 존재하는 객체를 영속화하여 사용할 수 있다.
  > DB에 저장, file에 저장, 네트워크 정보 전송 등...
- File I/O, 통신을 할 떄 사용하는 Stream으로 변환 해야 한다.
  > 이 작업을 직렬화(Serialization)이라고 부른다,
- 다른 Builder에서 편리하게 공통의 Convention을 지키면서 사용하기 위해서 `java.io.Serializable`인터페이스를 구현한다.

## 특징

### 장점
- Bean의 속성, 이벤트, 메소드는 다른 애플리케이션에 노출이 가능하다.
- Bean을 구성하는데 도움이 되는 보조 프로그램이 제공될 수 있다.
- Bean의 설정정보는 영속성 저장소에 저장하고 복원할 수 있다.

### 단점
- 기본 생성자가 있는 클래스는 유효하지 않은 상태에서 인스턴스화 될 수 있다.
    - 수동으로 생성하는 경우 이러한 문제가 생길 수 있다.
    - 컴파일러가 이러한 문제를 감지하지 못한다.
- 불변 객체가 제공하는 이점이 없다.
  > Bean은 기본적으로 변경가능하다.
- 모든 `속성 - property`에 대해 `getter`를 만들고 대부분의 `property`에 대해 `setter`를 만들어야 하는 경우 많은 양의 코드가 생긴다.
  > 그래서 Lombok를 사용한다.
