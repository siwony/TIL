# Today I Learned

오늘 새롭게 배운 혹은 삽질한 경험을 간단한 글들을 마크다운 문서로 정리 해 보자! `2020-12-12 ~ 2024-02-18`  

해당 repository 는 [my-blog](https://github.com/siwony/my-blog)로 이전되었습니다.
[https://github.com/siwony/my-blog](https://blog.siwony.xyz/)를 이용해주세요

## GIT

- [.Ds_store 모두 .gitignore](Git/2021-03-28-ds-store-ignore.md)
- [커밋되지 않거나 저장되지 않은 모든 변경사항 취소 및 삭제](/Git/2021-05-16-rm-unstaged.md)
- [Cache 삭제](Git/2021-05-22-cache-remove.md)

## Algorithm

- [버블 정렬 - Bubble Sort](Algorithm/2022-01-30-bubbl-sort.md)
- [선택 정렬 - Selection Sort](Algorithm/2022-01-30-selection-sort.md)
- [퀵 정렬 - Quick Sort](Algorithm/2021-06-23-QuickSort.md)
- [동적 계획법 - Dynamic Programming](Algorithm/2022-03-17-dynamic-programming.md)
- [정렬 알고리즘 정리](Algorithm/2022-03-17-sort-algorithm-summary.md)

### 1. 그래프 탐색

- [너비 우선 탐색 - BFS](Algorithm/graph-search/2022-03-17-bfs.md)

## Operating System

### 1. Linux

- [특정 port를 사용하고 있는 프로세스 종료하는 명령어](OS/Linux/2021-05-18-certain-port-kill.md)
- [데몬 프로세스 - Daemon Processe](OS/Linux/2021-08-10-daemon-process.md)

### 2. Virtualization

- [하이퍼바이저 - Hypervisor](OS/Virtualization/2021-07-29-hypervisor.md)

## Computer Science

- [소프트웨어 생명주기(software life cycle)](cs/2022-03-19-swlc.md)
- [소프트웨어 테스트](cs/img/kinds-of-test.jpg)
- [직렬화(serialization)](cs/2022-03-19-data-serialization.md)
- [동시성 & 병렬성 - Concurrency & Parallelism](cs/2022-03-19-concurrency-parallelism.md)
- [IPC - Inter process Comunication](cs/2022-03-19-ipc.md)

### 1. Memory

- [메모리 구조](cs/Memory/2022-03-19-memory-structure.md)
  - [스텍 프레임](cs/Memory/2022-03-19-stack-frame.md)
- [캐시 메모리](cs/Memory/2022-03-19-cache.md)

### 2. [자료구조](cs/data-structure/2022-03-19-data-structure.md)

- [추상 자료형 - Abstract Data Type](cs/data-structure/ADT/2022-03-19-adt.md)

#### 2-1. 선형 구조

- [list](cs/data-structure/linear/list/2022-03-19-list.md)
  - [순차 리스트](cs/data-structure/linear/list/2022-03-19-sequential-list.md)
  - [연결 리스트](cs/data-structure/linear/list/2022-03-19-linked-list.md)
    > Singly Linked List, Circular Linked List, Doubly Linked List

#### 2-2. 비 선형 구조

- [그래프 - graph](cs/data-structure/non-linear/graph/2022-03-19-graph.md)
- [트리 - tree](cs/data-structure/non-linear/tree/2022-03-19-tree.md)
  - [B+트리](cs/data-structure/non-linear/tree/2022-03-19-b-plus-tree.md)
  - [B트리](cs/data-structure/non-linear/tree/2022-03-19-b-tree.md)

### 3. 네트워크

- [OSI 7계층 - ~~물데네 전세표응~~](cs/Network/2022-03-19-osi-layer-seven.md)

### 4. 객체지향 프로그래밍

- [Object Orinted Programing 한눈에 보기](cs/OOP/2022-03-19-OOP.md) 
- [General Responsibility Assignment Software Patterns](cs/OOP/2022-03-19-GRASP.md)

## Programming

- [소프트웨어 개발 3개의 KEY원칙 (DRY, KISS, YAGNI)](programming/2022-03-17-sw-dev-key-principle.md)
- [DDD](programming/2022-03-17-DDD.md)
- [TDD & BDD](programming/2022-03-17-TDD-BDD.md)
- [API](programming/2022-03-17-api.md)
- [VO 사실과 오해](programming/2024-02-18-VO_사실과_오해.md)

### 1. [JAVA](programming/java/01-java.md)

- [Java 버전 변경 - MacOS](programming/java/2022-03-29-java-version-change.md)
- [Java의 기본 배경 지식 - JVM, JDK, JRE](programming/java/2022-03-29-jvm-jdk-jre.md)
- [JAVA ubuntu 설치](programming/java/2022-03-29-java-install-ubuntu.md)

#### 1-1. [JVM - Java Virtual Machine](programming/java/JVM/2022-03-29-jvm.md)

- [JVM 구조](programming/java/JVM/2022-03-29-jvm-structure.md)
- [Class Loader](programming/java/JVM/2022-03-29-class-loader.md)
- [바이트 코드 조작 예시](programming/java/JVM/2022-03-29-byte-code-operation.md)

#### 1-2. 문법 및 기능

- [annotation](programming/java/grammar/07-package.md)
  - [annotation processor](programming/java/byte-code-controller-way/2022-03-29-annotation-processer.md)
- [String](programming/java/api/2022-03-29-string.md)
- [Enumeration 와 Iterator](programming/java/enumeration-iterator.md)
- [Exception](programming/java/2022-03-29-exception.md)
- [Wrapper Class](programming/java/2022-03-29-wrapper-class.md)
- [try-with-resources](programming/java/grammar/2022-04-05-try-with-resources.md)
- [향상된 for 루프 - enhanced for loop](programming/java/grammar/2022-04-20-enhanced-for-loop.md)
- [직렬화 - Serialization](programming/java/2022-04-26-serialization.md)
- [가변인수 - varargs](programming/java/2022-05-02-varargs.md)

#### 1-3. Java 8

- [JAVA interface](programming/java/2022-03-29-interface.md)
  - [함수형 인터페이스 - FunctionalInterface](programming/java/grammar/java8/2022-03-29-functional-interface.md)
  - [람다 표현식 - Lambda Expression](programming/java/grammar/java8/2022-03-29-lambda-expression.md)
  - [메소드 레퍼런스 - Method Reference](programming/java/grammar/java8/2022-03-29-method-reference.md)
- [Stream](programming/java/api/java8/2022-03-29-stream.md)
  - [Stream.sort는 stable하지 않아요!](programming/java/api/java8/2022-03-29-stream.md)
- [Optional](programming/java/api/java8/2022-03-29-optional.md)
- [java8 Date/Time API](programming/java/api/java8/2022-03-29-date-time.md)

#### 1-4. [JAVA 동시성 프로그래밍](programming/java/concurrent/2022-03-29-concurrent-programming.md)

- [Thread Pool](programming/java/concurrent/2022-03-29-thread-pool.md)
- [Executor Framework](programming/java/concurrent/2022-03-29-executor-framework.md)
- [Callable과 Future](programming/java/concurrent/2022-03-29-callable-future.md)
- [CompletableFuture](programming/java/concurrent/2022-03-29-completable-future.md)

#### 1-5. JAVA 동시성 프로그래밍의 이슈를 해결하는 방법

- [volatile - 가시성 이슈를 해결하는 키워드](programming/java/concurrent/2022-03-29-volatile.md)
- 경쟁상태를 해결하는 방법
  - [synchronized 키워드](programming/java/concurrent/2022-03-29-synchronized.md)
  - [Atomic API](programming/java/concurrent/2022-03-29-atomic.md)
  - Mutex, Semaphore
- [Thread Local - 스레드 로컬](programming/java/concurrent/2022-03-29-thread-local.md)

#### 1-6. 바이트 코드를 조작하는 다양한 방법

- [Reflection - 리플렉션](programming/java/byte-code-controller-way/2022-03-29-reflection.md)
- [Dynamic Proxy - 다이나믹 프록시](programming/java/byte-code-controller-way/2022-03-29-dynamic-proxy.md)
  - [클래스 기반의 프록시 생성방법](programming/java/byte-code-controller-way/2022-03-29-dynamic-proxy.md)
- [Annotation - 어노테이션](programming/java/byte-code-controller-way/2022-03-29-annotation.md)
  - [Annotation Processor](programming/java/byte-code-controller-way/2022-03-29-annotation-processer.md)

#### 1-7 JCF - Java Collection Framework

- [List 순회중 만난 `ConcurrentModificationException`](programming/java/java-collection-framework/2022-04-20-ConcurrentModificationException.md) - 미완성

#### 1-8. [Java EE](back-end/java-ee/2022-03-19-javaee.md)

- [Servlet](back-end/java-ee/2022-03-19-servlet.md)

#### 1-9. JAVA Design Pattern

- [디자인패턴?](programming/java/Design-pattern/2022-03-29-Design-Pattern.md)
- [전략패턴(Strategy Pattern)](programming/java/Design-pattern/2022-03-29-Strategy-Pattern.md)
- [어뎁터패턴(Adepter Pattern)](programming/java/Design-pattern/2022-03-29-Adepter-Pattern.md)
- [싱글톤패턴(Singleton Pattern)](programming/java/Design-pattern/2022-03-29-Singleton-Pattern.md)
- [프록시패턴(Proxy Pattern)](programming/java/Design-pattern/2022-03-29-Proxy-Pattern.md)
- [데코레이터 패턴(Decorator Pattern)](programming/java/Design-pattern/2022-03-29-Decorator-Pattern.md)
- [옵저버 패턴(Observer Pattern)](programming/java/Design-pattern/2022-03-29-Observer-Pattern.md)
- [퍼사드 패턴(Facade Pattern)](programming/java/Design-pattern/2022-03-29-facade-pattern.md)
- [템플릿 메서드 패턴(Template Method Pattern)](programming/java/Design-pattern/2022-03-29-template-method-pattern.md)
- [템플릿 콜백 패턴(Template Callback Pattern)](programming/java/Design-pattern/2022-03-29-template-callback-pettern.md)

#### 1-10. Reference

- [Java reference와 GC](programming/java/memory/2022-06-28-referenece.md)
- [WeakHashMap](programming/java/memory/2022-06-28-weak-hash-map.md)

#### etc...

- [POJO - 오래된 방식의 간단한 자바객체](programming/java/2022-06-26-pojo.md)
- [Java Beans](programming/java/2022-03-29-java-beans.md)
- [Guava 자바 라이브러리](programming/java/2022-03-29-google-quava.md)
- [인스턴스화를 막는 방법](programming/java/2022-05-02-defence-of-instantiate.md)

#### 1-10. junit

- [Junit5](programming/java/junit/2022-04-16-junit5.md)

### 2. [Kotlin](programming/kotlin/2022-04-29-kotlin.md)

- [Kotlin 키워드](programming/kotlin/2022-04-29-keyword.md)
- [엘비스 연산자 - Elvis Operation](programming/kotlin/2022-05-13-elvis-operation.md)
- [Java의 try-with-resource와 Kotlin의 use function](programming/kotlin/2022-05-16-try-with-resource-use-fun.md)
- [식(expression)과 문(statement)](programming/kotlin/2022-09-24-expression-statement.md)

## DevOps

- [DevOps](DevOps/2021-02-06-DevOps.md)
- [ELK stack](DevOps/2021-08-12-elk-stack.md)
  > Elasticsearch, Logstash, Kibana

### 1. Prometheus

- [Prometheus Quick Start with Docker](DevOps/prometheus/2022-02-06-prometheus-quick-start-with-docker.md)

### 2. AWS

- [aws EC2](DevOps/aws/2021-08-12-awsEC2.md)
- [EC2를 이용한 간단한 Spring Boot server 배포](DevOps/aws/2021-08-12-simple-spring-boot-aws.md)
- [CI/CD](DevOps/aws/2021-08-12-CI-CD.md)

### 3. Docker

- [Docker](DevOps/docker/2021-05-29-Docker.md)
- [Docker install](DevOps/docker/2021-05-29-docker-install.md) - ubuntu
- [container, image 삭제](DevOps/docker/2021-05-29-container-rm.md)
- [container root로 접속하기](DevOps/docker/2021-05-29-container-root.md)
  > `List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)` 해결

### 4. Jenkins

- [Jenkins install](DevOps/jenkins/2021-05-29-jenkins-install.md) - ubuntu

## BackEnd

- [Payload](back-end/2021-03-11-payload.md)

### 1. [Spring Framework](back-end/spring/2022-03-19-spring.md) 

- [DI(DependencyInjection)](back-end/spring/2022-03-19-DI(Dependency-Injection).md)
- [Spring 구조](back-end/spring/2022-03-19-DTO,DAO,Entity-class.md)
- [Bean](back-end/spring/2022-03-19-Bean.md)
  - [Bean 라이프사이클](back-end/spring/2022-03-19-bean-life-cycle.md)
- [Logging](back-end/spring/2022-03-19-Logging.md)

#### 1-1. Spring Triangle(IoC, AOP, PSA) - 스프링 3대 요소

- [IoC - Invertion of Controll](back-end/spring/spring-triangle/2022-06-05-ioc.md)
- [AOP - Aspect Oriented Programming](back-end/spring/spring-triangle/2022-06-05-aop.md)
- [PAS - Portable Service Abstraction](back-end/spring/spring-triangle/2022-06-05-psa.md)


### 2. [SpringBoot](back-end/spring/spring-boot/2022-03-19-SpringBoot.md)

- [Logback](back-end/spring/spring-boot/2022-03-19-logback.md)
- [File Req, Res처리](back-end/spring/spring-boot/2022-03-19-SpringBootFile-req-res-prosessing.md)
- [CORS 이슈 해결](back-end/spring/spring-boot/2022-03-19-cors.md)

#### 2-1. charset 문제

- [모든 요청에 대해 UTF-8 charset 적용](back-end/spring/spring-boot/2022-03-19-KoreanGarbled.md)
- [S3 버킷의 자원 위치를 가리키는 URL이 character set이 UTF-8이 아니여서 생긴 문제](back-end/spring/2022-03-19-URL-utf-8-problem.md)

### 3. Spring MVC

- [Command Object - 커맨드 객체](back-end/spring/spring-mvc/2022-03-19-command-object.md)
- [HTTP POST 메서드와 Content-Type](back-end/spring/spring-mvc/2022-03-19-post-and-content-type.md)
  > feat. Content type 'application/x-www-form-urlencoded;charset=UTF-8' not supported
- [SpringMVC는 XML, JSON과 같은 데이터를 어떻게 반환할까? (작성중)](back-end/spring/spring-mvc/2022-04-20-view-resolver-message-converter.md)
  > 부제: ViewResolver와 MessageConverter
- [Bean Validator에서 검증에 실패한 필드를 @RestControllerAdvice를 통해 알려주자!](back-end/spring/spring-mvc/2022-06-04-bean-validator-with-rest-controller-advice.md)

### 4. SpringSecurity

- [SpringSecurity](back-end/spring/spring-security/2022-03-19-spring-security.md)
- [CSRF(사이트간 요청위조)](back-end/spring/spring-security/2022-03-19-CSRF.md)
- [CORS해결기 근데 Spring Security를 곁들인](back-end/spring/spring-security/2022-07-04-cors.md)

### 5. Build Tool

- [Build Tool](back-end/build-tool/2022-03-19-build-tool.md)

### 6. Transaction

- [스프링 트랜잭션 전파옵션](back-end/spring/transaction/2022-07-12-propagation.md)

#### 5-1. Gradle

- [Gradle](back-end/build-tool/gradle/2022-03-19-gradle.md)
- [(SpringBoot Project) Maven에서 Gradle로 Build Tool migration!](back-end/build-tool/gradle/2022-03-19-maven-to-gradle-migration.md)
- [build.gradle plugins{...}방식 에러해결](back-end/build-tool/gradle/build-gradle-plugins-allowed%20befor-plugins-block.md)
  > only buildscript {} and other plugins {} script blocks are  
  > allowed before plugins {} blocks, no other statements are allowed   
  > 애러해결
- [(SpringBoot Project) 빌드후 생기는 Jar파일의 이름을 변경하는 방법](back-end/build-tool/gradle/2022-06-04-jarfile-rename.md)
- [(SpringBoot Project) plan jar 파일](back-end/build-tool/gradle/2023-07-26-plan-jar-ignore.md)

#### 5-2. Maven

- [plugin-not-found 에러 해결 - 버전이 명시가 되어있지 않을때](back-end/build-tool/maven/2022-03-19-plugin-not-found.md)

### 6. JPA

- [Entity](back-end/spring/jpa/2022-03-19-Entity.md)
- [JPA Auditing으로 생성일/수정일 자동화](back-end/spring/jpa/2022-03-19-Auditing.md)
- [비관적/낙관적 락](back-end/spring/jpa/2022-04-13-optimistic-lock-pessimistic-lock.md)
- [QueryDSL?](back-end/spring/jpa/2022-03-19-QueryDSL.md)
- [01 JPA?](back-end/spring/jpa/2022-03-19-01-JPA.md)
- [02 영속성 컨텍스트?](back-end/spring/jpa/2022-03-19-02-PersistenceContext.md)
- [03 플러시(flush)](back-end/spring/jpa/2022-03-19-03-flush.md)
- [04 준 영속 상태](back-end/spring/jpa/2022-03-19-04-detached.md)
- [05 DB schema 자동 생성](back-end/spring/jpa/2022-03-19-05-DB-schema-auto-create.md)
- [06 객체와 테이블 매핑](back-end/spring/jpa/2022-03-19-06-object-table-mapping.md)
- [07 기본키 매핑](back-end/spring/jpa/2022-03-19-07-pk-mapping.md)
  - [07-1 데이터 중심 설계(실습)](back-end/spring/jpa/2022-03-19-07.1-db-driven-design.md)
- [08 연관관계 맵핑(기초)](back-end/spring/jpa/2022-03-19-08-relationship-mapping-foundation.md)
  - [08-1 연관관계 매핑 시작(실전)](back-end/spring/jpa/2022-03-19-08.1-relationship-mapping-start.md)
- [09 다양한 연관관계](back-end/spring/jpa/2022-03-19-09-various-relationship.md)
  - [09-1 다양한 연관관계 매핑(실전)](back-end/spring/jpa/2022-03-19-09.1-various-relationship-mapping.md)
- [10 연관관계 맵핑(고급) - 상속관계 매핑](back-end/spring/jpa/2022-03-19-10-relationship-mapping-advanced.md)
- [11 @MappedSuperclass](back-end/spring/jpa/2022-03-19-11-mapped-superclass.md)
  - [11.1 상속관계 매핑(실전)](back-end/spring/jpa/2022-03-19-11.1-inherit-relationship-mapping.md)
- [12 Proxy](back-end/spring/jpa/2022-03-19-12-proxy.md)
- [13 Eager/LAZY loading](back-end/spring/jpa/2022-03-19-13-eager-loading-and-lazy-loading.md)
- [14 영속성 전이(cascade)](back-end/spring/jpa/2022-03-19-14-cascade.md)
- [15 고아 객체(ORPAN)](back-end/spring/jpa/2022-03-19-15-orpan.md)
  - [15-1 연관관계 관리(실전)](back-end/spring/jpa/2022-03-19-15.1-relationship-manage.md)
- [16 JPA 데이터 타입](back-end/spring/jpa/2022-03-19-16-jpa-data-type.md)
  1. [기본값 타입](back-end/spring/jpa/2022-03-19-16.1-default-type.md)
  2. [임베디드 타입(embedded-type)](back-end/spring/jpa/2022-03-19-16.2-embedded-type.md)
  3. [값 타입과 불변 타입](back-end/spring/jpa/2022-03-19-16.3-value-and-immutable.md)
  4. [값 타입 비교](back-end/spring/jpa/2022-03-19-16.4-value-type-compare.md)
  5. [값 타입 컬렉션](back-end/spring/jpa/2022-03-19-16.5-value-type-collection.md)
  6. [JPA 데이터 타입 정리](back-end/spring/jpa/2022-03-19-16.6-organize.md)
  7. [JPA 값 타입(실습)](back-end/spring/jpa/2022-03-19-16.7-value-type-mapping.md)
- [벌크 연산](back-end/spring/jpa/2022-04-20-bulk-operation.md)

#### 6-1. JPQL 객체지향 쿼리 언어

- [Fetch Join](back-end/spring/jpa/JPQL/2022-04-19-fetch-join.md)
- [00 JPQL intro](back-end/spring/jpa/JPQL/2022-03-19-00-intro.md)
- [01 JPQL](back-end/spring/jpa/JPQL/2022-03-19-01-JPQL.md)
- [02 프로젝션](back-end/spring/jpa/JPQL/2022-03-19-02-projection.md)
- [03 페이징](back-end/spring/jpa/JPQL/2022-03-19-03-paging.md)

#### 6-2. [Querydsl](back-end/spring/querydsl/2022-03-19-querydsl.md)

#### 6-3. Spring DATA JPA

- [00 Intro](back-end/spring/jpa/data-jpa/2022-03-29-00-intro.md)
- [01 공통인터페이스](back-end/spring/jpa/data-jpa/2022-03-29-01-comman-repository.md)
- [02 쿼리 메소드 기능](back-end/spring/jpa/data-jpa/2022-03-29-02-query-method.md)
- [Custom Repository](back-end/spring/jpa/data-jpa/2022-03-29-custom-repository.md)

### 7. Node.js

- [node.js 설치 및 개발환경 세팅](back-end/nodejs/2022-03-19-how-to-install-nodeJs.md)
- [MySQL 연결](back-end/nodejs/2022-03-19-Connect-MySql.md)
- [ORM모듈 Sequelize 사용하기(모델만들기)](back-end/nodejs/2022-03-19-sequelize.md)

### 8. [SSH](DevOps/ssh/2021-12-04-ssh.md)

- [REMOTE HOST IDENTIFICATION HAS CHANGED 에러 해결](back-end/ssh/2022-03-19-remote-host-identification-has-changed-error.md)

## Database

- [트랜잭션 격리수준](DataBase/2022-01-18-db-transcation-isolation-level.md)
- [관계형 데이터베이스 - Relational Database?](DataBase/2020-12-20-relational-database.md)
- [조인 알고리즘](DataBase/2022-03-17-join-algorithm.md)
- [옵티마이저 - Optimizer](DataBase/2022-03-15-optimizer.md)

### 1. SQL 전문가 가이드

1. [데이터 모델링의 이해](DataBase/data-modeling/2022-02-06-understanding-data-modeling.md)
2. [엔터티 - Entity](DataBase/data-modeling/2022-01-30-entity.md)
3. [데이터 모델과 성능](DataBase/data-modeling/2022-02-03-data-model-and-performance.md)
   1. [정규화](DataBase/data-modeling/2022-02-03-normalization-and-performance.md)
   2. [반정규화](DataBase/data-modeling/2022-02-14-denormalization.md)
   3. [인덱스](DataBase/data-modeling/2022-02-22-index.md)
   4. [분산 데이터베이스](DataBase/data-modeling/2022-02-22-distributed-database.md)

### 2. [SQL - Structured Query Language](DataBase/sql/2022-02-24-sql.md)

- [서브쿼리](DataBase/sql/2022-02-24-sub-query.md)
- [윈도우 함수 - window funtion](DataBase/sql/2022-03-02-window-funtion.md)
- [CASE 표현식](DataBase/sql/2022-03-02-case-expression.md)
- [조인 - Join](DataBase/sql/join.md)


### 3. MySQL

- [MySQL 설치](DataBase/MySQL/2020-12-20-how-to-install-mysql.md)
- [MySQL 실행관련 명령어](DataBase/MySQL/2020-12-20-mysql-run-command.md)
- [mysql 명령어](DataBase/MySQL/2020-12-20-mysql-command.md)

### 4. Oracle
- [Oracle11g Quick Start with docker](DataBase/oracle/2022-02-22-oracle11g-quick-start-with-doker.md)
- [옵티마이저 - Optimaizer](DataBase/2022-03-15-optimizer.md)

### 5. MongoDB

- [Mongodb](DataBase/mongodb/2022-03-15-mongodb.md)

### 6. Redis

- [AWS ec2 + Amazon Linux2환경에 redis 설치하기](DataBase/redis/2022-08-01-ec2-redis-install.md)
- [ECS에 배포한 단일 노드 Redis의 Read only replica 에러 해결기](DataBase/redis/2022-06-26-read-only-replica.md)

## Network

- [DNS](network/2022-03-17-dns.md)
- [Domain](network/2022-03-17-domain.md)
- [URI,URL,URN](network/2022-03-17-URI-URL-URN.md)
- [Socket](network/2022-03-17-socket.md)

### 1. 프로토콜

- [IP](network/protocol/2022-03-17-ip.md)
- [TCP, UDP](network/protocol/2022-03-17-tcp-udp.md)
- [RPC 프로토콜](network/protocol/rpc/2022-03-17-rpc.md)
  - [gRPC](network/protocol/rpc/2022-03-19-grpc.md)

### 2. [HTTP](network/http/2022-03-17-http.md)

- [더 나은 URI API를 설계 하는 방법과 HTTP method](network/http/2022-03-17-http-api-design.md)
- [REST API](network/http/2022-03-17-rest-api.md)
- [HTTP 버전별 차이](network/http/2022-03-30-http-version-difference.md)

### 3. WEB

- [서버기반 인증 & 토큰기반 인증](network/web/2022-03-17-token-auth-and-server-auth.md)
- [Cookie, Session](network/web/2022-03-17-cookie-and-session.md)
- [Web Socket](network/web/2022-03-17-web-socket.md)
- [WAS](network/web/2022-03-17-was.md)
- [웹 브라우저의 요청 흐름](network/web/2022-03-17-how-to-browser-can-request.md)

## 기타

- [개발용어 정리](ETC/2020-12-23-dev-terminology.md)
- [Component](ETC/2020-12-25-component.md)
- [애자일 방법론](ETC/2021-04-03-agile.md)

## 독서

### 1. 유닛테스트

- [1. 단위테스트의 목표](Book/유닛테스트/2023-02-19-1_단위테스트의_목표.md)
- [3. 단위테스트 구조](Book/유닛테스트/2023-03-02-3_단위테스트_구조.md)
- [4. 좋은 단위테스트의 4대 요소](Book/유닛테스트/2023-03-05-4_좋은_단위테스트의_4대_요소.md)
- [6. 단위 테스트 스타일](Book/유닛테스트/2023-03-11-6_단위_테스트_스타일.md)
- [8. 통합 테스트를 하는 이유](Book/유닛테스트/2023-03-19-8_통합_테스트를_하는_이유.md)

### 2. 클린아키텍처

- [4. 컴포넌트 원칙](Book/클린아키텍처/2023-04-30-4_컴포넌트_원칙.md)

### 3. 쉽게 배우는 소프트웨어 공학

- [01. 소프트웨어 공학 소개](Book/쉽게-배우는-소프트웨어-공학./2021-08-24-01-소프트웨어-공학-소개.md)

### 4. 객체지향의 사실과 오해

- [01. 협력하는 객체들의 공동체](Book/object-orientation-facts-and-misconceptions/2021-04-24-01-community-of-objects-in-partnership.md)