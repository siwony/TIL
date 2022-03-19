# SpringBoot
Spring Famework는 아래 세 가지의 특성을 이용해 결합도를 낮추는 방식으로 Application을 개발할 수 있다.
- Dependency Injection
- Inversion of Control
- Aspext Oriented Programming

하지만 Spring(Spring Famework)의 환경 설정은 EJB보다 나아졌다 하더라도 여전히 복잡하다.
> Transaction Manager, Hibernate Datasource, Entity Manager, Session Factory 등...

Spring Boot는 최소한의 작업으로 Spring Famework를 사용하기 위해 등장했다.

> Spring Boot makes it easy to create stand-alone,  
> production-grade Spring based Applications that you can "just run".  
> 
> Spring Boot는 "그냥 실행할 수 있는" 프로덕션 등급의 Spring 기반 애플리케이션을 쉽게 만들 수 있다.


### 주요 특징
#### 1. 'starter' 의존성 제공
빌드 구성을 단순화 하기위해 'starter'의존성을 제공한다.
> spring-boot-starter-{라이브러리 이름}

#### 2. 라이브러리 버전 자동관리
Spring Framework에서 버전을 수동적으로 관리했다면 Spring Boot에서는 Spring 라이브러리 뿐만 아니라 서드파티 라이브러리들도 호환되는 버전으로 알아서 관리해준다.

#### 3. SpringFramework 설정 자동화
`@EnableAutoConfiguration` 어노테이션을 선언하면 Spring에서 자주 사용했던 설정들을 알아서 등록한다.

#### 4. 내장 Tomcat, Netty
SpringBoot는 Starter의존성에 WAS를 내장하고 있으므로 WAR file로 배포할 필요가 없다.
> Tomcat은 `spring-boot-starter-web`의존성에, Netty는 `spring-boot-starter-webflux`의존성에 내장되어 있다.

#### 5. Spring Actuaor를 제공한다. 
메트릭, 상태 확인 및 외부 구성과 같은기능을 제공한다.

#### 6. XML설정과 code 생성을 요구하지 않는다.

### SpringBoot의 목표
- **Spring 개발에 대해 빠르고**, 광범위하게 적용할 수 있는 환경
- **기본값 설정**이 있지만 설정을 바꿀 수 있다.
- **대규모 프로젝트**에 공통적인 비 기능 제공 (보안, 모니터링 등..)
- **XML 구성 요구사항**이 전혀 없다.

### SpringBoot는 Spring initializr로 프로젝트를 다운받을 수 있다.
link: https://start.spring.io


## Reference
- https://spring.io/projects/spring-boot
- https://www.bottlehs.com/springboot/%EC%8A%A4%ED%94%84%EB%A7%81-%EB%B6%80%ED%8A%B8-%EC%86%8C%EA%B0%9C/