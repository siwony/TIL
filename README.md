# Today I Learned
오늘 새롭게 배운 혹은 삽질한 경험을 간단한 글들을 마크다운 문서로 정리 해 보자! `start - Dec 12 2020`  
## 분류
### GIT
- [.Ds_store 모두 .gitignore](Git/ds-store-ignore.md)
- [커밋되지 않거나 저장되지 않은 모든 변경사항 취소 및 삭제](/Git/rm-unstaged.md)
- [Cache 삭제](Git/cache-remove.md)

## CS(Computer Science) 
- [소프트웨어 생명주기(software life cycle)](CS/swlc.md)
- [소프트웨어 테스트](CS/img/kinds-of-test.jpg)
- [직렬화(serialization)](CS/data-serialization.md)
- [동시성 & 병렬성 - Concurrency & Parallelism](CS/concurrency-parallelism.md)
### Memory
- [메모리 구조](CS/Memory/memory-structure.md)
- [캐시 메모리](CS/Memory/cache.md)

### [자료구조]((CS/DataStructure/data-structure.md))
- [추상 자료형 - Abstract Data Type](CS/DataStructure/ADT/adt.md)
#### 선형 구조
- [list](CS/DataStructure/linear/list/list.md)
  - [순차 리스트](CS/DataStructure/linear/list/sequential-list.md)
  - [연결 리스트](CS/DataStructure/linear/list/linked-list.md)
    > Singly Linked List, Circular Linked List, Doubly Linked List

### 네트워크
- [OSI 7계층 - ~~물데네 전세표응~~](CS/Network/osi-layer-seven.md)

### OOP 객체지향 프로그래밍
- [Object Orinted Programing 한눈에 보기](CS/OOP/OOP.md) 
- [General Responsibility Assignment Software Patterns](CS/OOP/GRASP.md)

## Programming
- [소프트웨어 개발 3개의 KEY원칙 (DRY, KISS, YAGNI)](Programming/sw-dev-key-principle.md)
- [DDD](Programming/DDD.md)
- [TDD & BDD](Programming/TDD-BDD.md)

### [JAVA](Programming/Java/01-java.md)
- [Java의 기본 배경 지식 - JVM, JDK, JRE](Programming/Java/jvm-jdk-jre.md)
- [JAVA ubuntu 설치](Programming/Java/java-install-ubuntu.md)

#### [JVM(Java Virtual Machine)](Programming/Java/JVM/jvm.md)
- [JVM 구조](Programming/Java/JVM/jvm-structure.md)
- [Class Loader](Programming/Java/JVM/class-loader.md)
- [바이트 코드 조작 예시](Programming/Java/JVM/byte-code-operation.md)

#### 문법 및 기능
- [JAVA 데이터형](Programming/Java/grammar/02-java-Data-type.md)
- [JAVA 배열](Programming/Java/grammar/03-array.md)
- [JAVA scope, static](Programming/Java/grammar/05-scope-static.md)
- [JAVA enum](Programming/Java/grammar/06-enum.md)
- [JAVA package](Programming/Java/grammar/07-package.md)
- [annotation](Programming/Java/grammar/07-package.md)
  - [annotation processor](Programming/Java/byte-code-controller-way/annotation-processer.md)
- [Enumeration 와 Iterator](Programming/Java/enumeration-iterator.md)
- [Exception](Programming/Java/exception.md)
- [Wrapper Class](Programming/Java/wrapper-class.md)
- [Guava 자바 라이브러리](Programming/Java/google-quava.md)

#### Java 8
- [JAVA interface](Programming/Java/interface.md)
  - [함수형 인터페이스 - FunctionalInterface](Programming/Java/grammar/java8/functional-interface.md)
  - [람다 표현식 - Lambda Expression](Programming/Java/grammar/java8/lambda-expression.md)
  - [메소드 레퍼런스 - Method Reference](Programming/Java/grammar/java8/method-reference.md)
- [Stream](Programming/Java/api/java8/stream.md)
- [Optional](Programming/Java/api/java8/optional.md)
- [Java8 Date/Time API](Programming/Java/api/java8/date-time.md)

#### [JAVA 동시성 프로그래밍](Programming/Java/concurrent/concurrent-programming.md)
  - [Thread Pool](Programming/Java/concurrent/thread-pool.md)
  - [Executor Framework](Programming/Java/concurrent/executor-framework.md)
  - [Callable과 Future](Programming/Java/concurrent/callable-future.md)
  - [CompletableFuture](Programming/Java/concurrent/completable-future.md)

#### 바이트 코드를 조작하는 다양한 방법
- [Reflection - 리플렉션](Programming/Java/byte-code-controller-way/reflection.md)
- [Dynamic Proxy - 다이나믹 프록시](Programming/Java/byte-code-controller-way/dynamic-proxy.md)
  - [클래스 기반의 프록시 생성방법](Programming/Java/byte-code-controller-way/dynamic-proxy.md)
- [Annotation - 어노테이션](Programming/Java/byte-code-controller-way/annotation.md)
  - [Annotation Processor](Programming/Java/byte-code-controller-way/annotation-processer.md)

#### etc...
- [POJO - 오래된 방식의 간단한 자바객체](Programming/Java/POJO(Plain-Old-JAVA-Object).md)
- [Java Beans](Programming/Java/java-beans.md)

#### [Java EE](BE/JavaEE/javaee.md)
- [Servlet](BE/JavaEE/servlet.md)

#### JAVA Design Pattern
- [디자인패턴?](Programming/Java/Design-pattern/Design-Pattern.md)
- [전략패턴(Strategy Pattern)](Programming/Java/Design-pattern/Strategy-Pattern.md)
- [어뎁터패턴(Adepter Pattern)](Programming/Java/Design-pattern/Adepter-Pattern.md)
- [싱글톤패턴(Singleton Pattern)](Programming/Java/Design-pattern/Singleton-Pattern.md)
- [프록시패턴(Proxy Pattern)](Programming/Java/Design-pattern/Proxy-Pattern.md)
- [데코레이터 패턴(Decorator Pattern)](Programming/Java/Design-pattern/Decorator-Pattern.md)
- [옵저버 패턴(Observer Pattern)](Programming/Java/Design-pattern/Observer-Pattern.md)

## 알고리즘
- [퀵정렬](Algorithm/QuickSort.md)

## DevOps
- [DevOps](DevOps/DevOps.md)
- [ELK stack](DevOps/elk-stack.md)
  > Elasticsearch, Logstash, Kibana

### AWS
- [aws EC2](DevOps/aws/awsEC2.md)
- [EC2를 이용한 간단한 Spring Boot server 배포](DevOps/aws/simple-spring-boot-aws.md)
- [CI/CD](DevOps/aws/CI-CD.md)

### Docker
- [Docker](DevOps/docker/Docker.md)
- [Docker install](DevOps/docker/docker-install.md) - ubuntu
- [container, image 삭제](DevOps/docker/container-rm.md)
- [container root로 접속하기](DevOps/docker/container-root.md)
  > `List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)` 해결

### Jenkins
- [Jenkins install](DevOps/jenkins/jenkins-install.md) - ubuntu

## BackEnd
- [Payload](BE/payload.md)

### Build Tool
- [Build Tool](BE/BuildTool/build-tool.md)
#### Gradle
- [Gradle](BE/BuildTool/gradle/gradle.md)
- [(SpringBoot Project) Maven에서 Gradle로 Build Tool migration!](BE/BuildTool/gradle/maven-to-gradle-migration.md)
- [build.gradle plugins{...}방식 에러해결](BE/BuildTool/gradle/build-gradle-plugins-allowed%20befor-plugins-block.md)
  > only buildscript {} and other plugins {} script blocks are  
  > allowed before plugins {} blocks, no other statements are allowed   
  > 애러해결

#### Maven
- [plugin-not-found 에러 해결 - 버전이 명시가 되어있지 않을때](BE/BuildTool/maven/plugin-not-found.md)
### Spring 
- [DI(DependencyInjection)](BE/Spring/DI(Dependency-Injection).md)
- [IoC](BE/Spring/IOC(Inversion-Of-Control).md)
- [Spring 구조](BE/Spring/DTO,DAO,Entity-class.md)
- [Bean](BE/Spring/Bean.md)
  - [Bean 라이프사이클](BE/Spring/bean-life-cycle.md)
- [Logging](BE/Spring/Logging.md)


### SpringBoot  
- [Logback](BE/Spring/SpringBoot/logback.md)
- [File Req, Res처리](BE/Spring/SpringBoot/SpringBootFile-req-res-prosessing.md)
- [CORS 이슈 해결](BE/Spring/SpringBoot/cors.md)

#### charset 문제
- [모든 요청에 대해 UTF-8 charset 적용](BE/Spring/SpringBoot/KoreanGarbled.md)
- [S3 버킷의 자원 위치를 가리키는 URL이 character set이 UTF-8이 아니여서 생긴 문제](BE/Spring/URL-utf-8-problem.md)

### Spring MVC
- [Command Object - 커맨드 객체](BE/Spring/SpringMVC/command-object.md)
- [HTTP POST 메서드와 Content-Type](BE/Spring/post-and-content-type.md)
  > feat. Content type 'application/x-www-form-urlencoded;charset=UTF-8' not supported

### &nbsp; SpringSecurity
- [SpringSecurity](BE/Spring/SpringSecurity/spring-security.md)
- [CSRF(사이트간 요청위조)](BE/Spring/SpringSecurity/CSRF.md)

## &nbsp; JPA
- [Entity](BE/Spring/JPA/Entity.md)
- [JPA Auditing으로 생성일/수정일 자동화](BE/Spring/JPA/Auditing.md)
- [QueryDSL?](BE/Spring/JPA/QueryDSL.md)
- [01 JPA?](BE/Spring/JPA/01-JPA.md)
- [02 영속성 컨텍스트?](BE/Spring/JPA/02-PersistenceContext.md)
- [03 플러시(flush)](BE/Spring/JPA/03-flush.md)
- [04 준 영속 상태](BE/Spring/JPA/04-detached.md)
- [05 DB schema 자동 생성](BE/Spring/JPA/05-DB-schema-auto-create.md)
- [06 객체와 테이블 매핑](BE/Spring/JPA/06-object-table-mapping.md)
- [07 기본키 매핑](BE/Spring/JPA/07-pk-mapping.md)
  - [07-1 데이터 중심 설계(실습)](BE/Spring/JPA/07.1-db-driven-design.md)
- [08 연관관계 맵핑(기초)](BE/Spring/JPA/08-relationship-mapping-foundation.md)
  - [08-1 연관관계 매핑 시작(실전)](BE/Spring/JPA/08.1-relationship-mapping-start.md)
- [09 다양한 연관관계](BE/Spring/JPA/09-various-relationship.md)
  - [09-1 다양한 연관관계 매핑(실전)](BE/Spring/JPA/09.1-various-relationship-mapping.md)
- [10 연관관계 맵핑(고급) - 상속관계 매핑](BE/Spring/JPA/10-relationship-mapping-advanced.md)
- [11 @MappedSuperclass](BE/Spring/JPA/11-mapped-superclass.md)
  - [11.1 상속관계 매핑(실전)](BE/Spring/JPA/11.1-inherit-relationship-mapping.md)
- [12 Proxy](BE/Spring/JPA/12-proxy.md)
- [13 Eager/LAZY loading](BE/Spring/JPA/13-eager-loading-and-lazy-loading.md)
- [14 영속성 전이(cascade)](BE/Spring/JPA/14-cascade.md)
- [15 고아 객체(ORPAN)](BE/Spring/JPA/15-orpan.md)
  - [15-1 연관관계 관리(실전)](BE/Spring/JPA/15.1-relationship-manage.md)
- [16 JPA 데이터 타입](BE/Spring/JPA/16-value-type.md)
  1. [기본값 타입](BE/Spring/JPA/16.1-default-type.md)
  2. [임베디드 타입(embedded-type)](BE/Spring/JPA/16.2-embedded-type.md)
  3. [값 타입과 불변 타입](BE/Spring/JPA/16.3-value-and-immutable.md)
  4. [값 타입 비교](BE/Spring/JPA/16.4-value-type-compare.md)
  5. [값 타입 컬렉션](BE/Spring/JPA/16.5-value-type-collection.md)
  6. [JPA 데이터 타입 정리](BE/Spring/JPA/16.6-organize.md)
  7. [JPA 값 타입(실습)](BE/Spring/JPA/16.7-value-type-mapping.md)
#### JPQL 객체지향 쿼리 언어
- [00 JPQL intro](BE/Spring/JPA/JPQL/00-intro.md)
- [01 JPQL](BE/Spring/JPA/JPQL/01-JPQL.md)
- [02 프로젝션](BE/Spring/JPA/JPQL/02-projection.md)
- [03 페이징](BE/Spring/JPA/JPQL/03-paging.md)

#### [Querydsl](BE/Spring/Querydsl/querydsl.md)

#### Spring DATA JPA
- [00 Intro](BE/Spring/JPA/DataJPA/00-intro.md)
- [01 공통인터페이스](BE/Spring/JPA/DataJPA/01-comman-repository.md)
- [02 쿼리 메소드 기능](BE/Spring/JPA/DataJPA/02-query-method.md)
- [Custom Repository](BE/Spring/JPA/DataJPA/custom-repository.md)

### &nbsp; Node.js
- [node.js 설치 및 개발환경 세팅](BE/NodeJS/how-to-install-nodeJs.md)
- [MySQL 연결](BE/NodeJS/Connect-MySql.md)
- [ORM모듈 Sequelize 사용하기(모델만들기)](BE/NodeJS/sequelize.md)

### &nbsp;[SSH](DevOps/ssh/ssh.md)
- [REMOTE HOST IDENTIFICATION HAS CHANGED 에러 해결](BE/SSH/remote-host-identification-has-changed-error.md)

### &nbsp; DataBase
- [RDB 란?](DataBase/relational-database.md)

### &nbsp; MySQL
- [MySQL 설치](DataBase/MySQL/how-to-install-mysql.md)
- [MySQL 실행관련 명령어](DataBase/MySQL/mysql-run-command.md)
- [mysql 명령어](DataBase/MySQL/mysql-command.md)

## Web
- [HTTP](Web/http.md)
- [API](Web/api.md)
- [REST API](Web/RESTAPI.md)
- [Domain](Web/domain.md)
- [DNS](Web/dns.md)
- [서버기반 인증 & 토큰기반 인증](Web/tokenAuth-serverAuth.md)
- [Cookie, Session](Web/cookie-and-session.md)
- [URI,URL,URN](Web/URI-URL-URN.md)
- [Web Socket](Web/web-socket.md)
- [WAS](Web/was.md)

## Book
- [README](Book/README.md)
- [객체지향 사실과 오해](Book/object-orientation-facts-and-misconceptions/README.md)
- [쉽게 배우는 소프트웨어 공학 - GSM CS교재](Book/쉽게-배우는-소프트웨어-공학./README.md)

## 기타
- [개발용어 정리](ETC/dev-terminology.md)
- [Component](ETC/component.md)