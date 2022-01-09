# Spring Framework
*Spring Framework*는 자바 플렛폼을 위한 오픈소스 애플리케이션으로써, **엔터프라이즈급 애플리케이션**을 개발하기 위한 모든 기능들을 종합적으로 제공하는 **경량화**된 솔루션이다

Spring은 특정한 하나의 프레임워크가 아닌 **여러가지 기술들의 모음**이라고 할 수 있다.
> Spring Core


### Spring Framework의 등장 배경
Spring은 *초기 J2EE(Java EE) 사양*의 복잡성으로 2003년에 만들어졌다.

Spring은 JavaEE와 현재의 Jakarta EE를 대체하기 위해 만들어졌다고 생각할 수 있지만, 상호보완적인 관계이다.  
Spring은 Jakarta EE 플랫폼 사양을 수용하지 않으며, 전통적인EE 제품에서 신중하게 선택된 개별 사향들과 통합된다.

Spring의 등장 배경이 되는 JaaEE문제점 중 EJB의 *기술 침투*를 하나 소개하겠다.

#### EJB의 기술 침투 문제
당시 EJB의 개념이 획기적이었기 떄문에 J2EE 서버 개발 밴더들은 EJB 스펙을 구현한 여러 WAS를 출시했다.
> EJB란 Enterprise 개발을 단순화하기 위해 발표한 스펙이다. "비즈니스 객체들을 관리하는 컨테이너를 만들어서 필요할 때 마다 컨테이너로 부터 객체를 받는 식으로 관리하면 좋을 거 같다."라는 생각으로 EJB가 시작되었다.

하지만, 보안, 트랜잭션, 분산 컴퓨팅 등 컨테이너의 여러 서비스를 사용하기 위해 EJB스펙을 무조건 따라야 하고, EJB 컨테이너가 없을 때 WAS의 여러 서비스를 사용할 수 없었다. 또한,

EJB의 스펙을 지키기 위해 사용하려는 메서드보다. 상속 및 구현해야 하므로 불필요한 코드가 늘어났다. 그러면서 벤더마다 EJB 컨테이너를 구현한 내용이 다르므로 다른 컨테이너로 변경하기 어려웠다.

이러한 문제가 발생한 원인은 **비즈니스 로직에 *EJB*라는 특정 기술이 종속되어 있다는 것이다.** 이를 `기술 침투`라고 하는데 EJB의 가장 큰 단점이다.

**Spring은 POJO기반 프레임워크로써 비 기술 침투적이다.**

## Spring의 대표적인 특징
### 1. 경량 컨테이너
Spring은 **불필요하게 무겁지 않다**

경량 컨테이너로서 자바 객체를 직접 관리, 객체 생성, 소멸 같은 **객체의 생명주기 관리**하며, 개발자는 스프링으로부터 필요한 객체 얻어올 수 있다.
- Spring Framework는 여러개의 모듈로 구성되어 필요한 모듈만 이용할 수 있다.
  > Spring MVC없이 Spring JDBC를 사용할 수 있다.

> 경량 컨테이너라는 것은 기준에 따라 달라질 수 있다. JavaEE보다 경량 컨테이너이지만 Guice와 Plexus와 같은 POJO기반 컨테이너와 비교할 때 무거운 컨테이너로 취급된다.



### 2. [POJO - Plain Old Java Object](../../Programming/Java/POJO(Plain-Old-JAVA-Object).md)
Spring 컨테이너에 저장되는 자바 객체는 특정 인터페이스를 구현하거나, 특정 클래스를 상속받지 않아도 된다.

이로인해 개발자는 특정 라이브러리나 JavaEE와 같은 컨테이너의 특정 기술에 종속적이지 않게되어 다음과 같은 장점이 있다.
- 테스트코드 작성이 쉬워진다.

### 3. [IoC - Inversion of Control](IOC(Inversion-Of-Control).md)
> Spring의 핵심이다.

이를 직역하면 *제어의 역전*인데, 이렇게 불리는 이유는 객체(Bean)의 생성, 주입과 같은 **객체의 흐름을 개발자가 아닌 Spring Framework가 제어**하기 때문에 제어권이 개발자에서 프레임워크로 넘어갔다는 의미이다.
> Spring Core의 IoC Container가 이를 담당한다.

IOC는 `DI - Dependency Injection`, `DL - Dependency Lockup`에 의해 구현된다.

### 4. [DI](DI(Dependency-Injection).md) - Dependency Injection
설정파일을 통해 객체 간의 의존관계를 설정할 수 있다. 각각의 계층이나 서비스들 간에 의존성이 존재할 경우, 프레임워크가 서로 연결시켜준다.

- `필드 주입`, `생성자 주입`, `Setter 주입` 방식으로 DI를 지원한다. 
  > 필드 주입은 권장하지 않는다.

### 5. AOP - Aspect Oriented Programming
트랜잭션이나 로깅, 보안과 같이 여러 모듈에서 공통적으로 사용하는 기능의 경우 해당 기능을 분리하여 관리할 수 있다.

로깅과 같은 로직을 비즈니스 로직이 아닌 외부에서 적절한 시기에 처리하므로 개발자는 비즈니스 로직에 집중할 수 있고, 부가적인 로직을 모듈화함으로 응집력이 높아진다.

### 6. 추상화된 트랜잭션 관리 제공
`PlatformTransactionManager`를 추상화하여 추상화된 트랜잭션 관리를 지원하며, 설정파일(xml, java, property 등)을 이용한 선언적인 방식 및 프로그래밍을 통한 방식을 모두 지원한다.  
<img width=600 src="img/transaction-abstract.png">

### 7. 영속성과 관련된 다양한 서비스 제공
hibernate와 같은 데이터베이스 처리 와 같은 프레임워크 혹은 라이브러리를 연결할 수 있는 인터페이스를 제공한다.

### 8. MVC 패턴 - Model view Controller pattern
Model View Controller 구조로 사용자 인터페이스와 비지니스 로직을 분리하여 개발하는 것이다. MVC에서는 Model1과 Model2로 나누어져 있으며 일반적인 MVC는 Model2를 지칭한다.

MVC1은 view와 데이터 처리를 Controller가 담당하고, MVC2는 view와 데이터처리를 각각 분리하는 구조이다.

## 여담
*Spring6*, *SpringBoot3* 부터 java17이상부터 지원한다고 한다.
- https://spring.io/blog/2021/09/02/a-java-17-and-jakarta-ee-9-baseline-for-spring-framework-6

## Reference
- https://docs.spring.io/spring-framework/docs/6.0.x/reference/html/overview.html#overview
- https://docs.spring.io/spring-framework/docs/4.3.x/spring-framework-reference/html/overview.html
- https://blog.outsider.ne.kr/729
- https://khj93.tistory.com/entry/Spring-Spring-Framework%EB%9E%80-%EA%B8%B0%EB%B3%B8-%EA%B0%9C%EB%85%90-%ED%95%B5%EC%8B%AC-%EC%A0%95%EB%A6%AC
- https://blog.naver.com/dktmrorl/222117116193
- https://naming0617.tistory.com/32