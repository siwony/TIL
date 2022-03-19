# Today I Learned
오늘 새롭게 배운 혹은 삽질한 경험을 간단한 글들을 마크다운 문서로 정리 해 보자! `start - Dec 12 2020`  

## GIT
- [.Ds_store 모두 .gitignore](Git/ds-store-ignore.md)
- [커밋되지 않거나 저장되지 않은 모든 변경사항 취소 및 삭제](/Git/rm-unstaged.md)
- [Cache 삭제](Git/cache-remove.md)

## Operating System
### 1. Linux
- [특정 port를 사용하고 있는 프로세스 종료하는 명령어](os/Linux/certain-port-kill.md)
- [데몬 프로세스 - Daemon Processe](OS/Linux/daemon-process.md)

### 2. Virtualization
- [하이퍼바이저 - Hypervisor](OS/Virtualization/hypervisor.md)

## Computer Science
- [소프트웨어 생명주기(software life cycle)](cs/swlc.md)
- [소프트웨어 테스트](cs/img/kinds-of-test.jpg)
- [직렬화(serialization)](cs/data-serialization.md)
- [동시성 & 병렬성 - Concurrency & Parallelism](cs/concurrency-parallelism.md)
- [IPC - Inter process Comunication](cs/ipc.md)

### 1. Memory
- [메모리 구조](cs/Memory/memory-structure.md)
  - [스텍 프레임](cs/Memory/stack-frame.md)
- [캐시 메모리](cs/Memory/cache.md)

### 2. [자료구조](cs/data-structure/data-structure.md)
- [추상 자료형 - Abstract Data Type](cs/data-structure/ADT/adt.md)

#### 2-1. 선형 구조
- [list](cs/data-structure/linear/list/list.md)
  - [순차 리스트](cs/data-structure/linear/list/sequential-list.md)
  - [연결 리스트](cs/data-structure/linear/list/linked-list.md)
    > Singly Linked List, Circular Linked List, Doubly Linked List

#### 2-2. 비 선형 구조
- [그래프 - graph](cs/data-structure/non-linear/graph/graph.md)
- [트리 - tree](cs/data-structure/non-linear/tree/tree.md)

### 3. 네트워크
- [OSI 7계층 - ~~물데네 전세표응~~](cs/Network/osi-layer-seven.md)

### 4. 객체지향 프로그래밍
- [Object Orinted Programing 한눈에 보기](cs/OOP/OOP.md) 
- [General Responsibility Assignment Software Patterns](cs/OOP/GRASP.md)

## Programming
- [소프트웨어 개발 3개의 KEY원칙 (DRY, KISS, YAGNI)](programming/sw-dev-key-principle.md)
- [DDD](programming/DDD.md)
- [TDD & BDD](programming/TDD-BDD.md)
- [API](programming/api.md)

### 1. [JAVA](programming/Java/01-java.md)
- [Java 버전 변경 - MacOS](programming/Java/java-version-change.md)
- [Java의 기본 배경 지식 - JVM, JDK, JRE](programming/Java/jvm-jdk-jre.md)
- [JAVA ubuntu 설치](programming/Java/java-install-ubuntu.md)

#### 1-1. [JVM - Java Virtual Machine](programming/Java/JVM/jvm.md)
- [JVM 구조](programming/Java/JVM/jvm-structure.md)
- [Class Loader](programming/Java/JVM/class-loader.md)
- [바이트 코드 조작 예시](programming/Java/JVM/byte-code-operation.md)

#### 1-2. 문법 및 기능
- [JAVA 데이터형](programming/Java/grammar/02-java-Data-type.md)
- [JAVA 배열](programming/Java/grammar/03-array.md)
- [JAVA scope, static](programming/Java/grammar/05-scope-static.md)
- [JAVA enum](programming/Java/grammar/06-enum.md)
- [JAVA package](programming/Java/grammar/07-package.md)
- [annotation](programming/Java/grammar/07-package.md)
  - [annotation processor](programming/Java/byte-code-controller-way/annotation-processer.md)
- [String](programming/Java/api/string.md)
- [Enumeration 와 Iterator](programming/Java/enumeration-iterator.md)
- [Exception](programming/Java/exception.md)
- [Wrapper Class](programming/Java/wrapper-class.md)
- [Guava 자바 라이브러리](programming/Java/google-quava.md)

#### 1-3. Java 8
- [JAVA interface](programming/Java/interface.md)
  - [함수형 인터페이스 - FunctionalInterface](programming/Java/grammar/java8/functional-interface.md)
  - [람다 표현식 - Lambda Expression](programming/Java/grammar/java8/lambda-expression.md)
  - [메소드 레퍼런스 - Method Reference](programming/Java/grammar/java8/method-reference.md)
- [Stream](programming/Java/api/java8/stream.md)
- [Optional](programming/Java/api/java8/optional.md)
- [Java8 Date/Time API](programming/Java/api/java8/date-time.md)

#### 1-4. [JAVA 동시성 프로그래밍](programming/Java/concurrent/concurrent-programming.md)
- [Thread Pool](programming/Java/concurrent/thread-pool.md)
- [Executor Framework](programming/Java/concurrent/executor-framework.md)
- [Callable과 Future](programming/Java/concurrent/callable-future.md)
- [CompletableFuture](programming/Java/concurrent/completable-future.md)

#### 1-5. JAVA 동시성 프로그래밍의 이슈를 해결하는 방법
- [volatile - 가시성 이슈를 해결하는 키워드](programming/Java/concurrent/volatile.md)
- 경쟁상태를 해결하는 방법
  - [synchronized 키워드](programming/Java/concurrent/synchronized.md)
  - [Atomic API](programming/Java/concurrent/atomic.md)
  - Mutex, Semaphore
- [Thread Local - 스레드 로컬](programming/Java/concurrent/thread-local.md)

#### 1-6. 바이트 코드를 조작하는 다양한 방법
- [Reflection - 리플렉션](programming/Java/byte-code-controller-way/reflection.md)
- [Dynamic Proxy - 다이나믹 프록시](programming/Java/byte-code-controller-way/dynamic-proxy.md)
  - [클래스 기반의 프록시 생성방법](programming/Java/byte-code-controller-way/dynamic-proxy.md)
- [Annotation - 어노테이션](programming/Java/byte-code-controller-way/annotation.md)
  - [Annotation Processor](programming/Java/byte-code-controller-way/annotation-processer.md)

#### 1-7. etc...
- [POJO - 오래된 방식의 간단한 자바객체](programming/Java/POJO(Plain-Old-JAVA-Object).md)
- [Java Beans](programming/Java/java-beans.md)

#### 1-8. [Java EE](BE/JavaEE/javaee.md)
- [Servlet](BE/JavaEE/servlet.md)

#### 1-9. JAVA Design Pattern
- [디자인패턴?](programming/Java/Design-pattern/Design-Pattern.md)
- [전략패턴(Strategy Pattern)](programming/Java/Design-pattern/Strategy-Pattern.md)
- [어뎁터패턴(Adepter Pattern)](programming/Java/Design-pattern/Adepter-Pattern.md)
- [싱글톤패턴(Singleton Pattern)](programming/Java/Design-pattern/Singleton-Pattern.md)
- [프록시패턴(Proxy Pattern)](programming/Java/Design-pattern/Proxy-Pattern.md)
- [데코레이터 패턴(Decorator Pattern)](programming/Java/Design-pattern/Decorator-Pattern.md)
- [옵저버 패턴(Observer Pattern)](programming/Java/Design-pattern/Observer-Pattern.md)

## 알고리즘
- [퀵정렬](Algorithm/QuickSort.md)

## DevOps
- [DevOps](DevOps/DevOps.md)
- [ELK stack](DevOps/elk-stack.md)
  > Elasticsearch, Logstash, Kibana

### 1. Prometheus
- [Prometheus Quick Start with Docker](DevOps/prometheus/prometheus-quick-start-with-docker.md)

### 2. AWS
- [aws EC2](DevOps/aws/awsEC2.md)
- [EC2를 이용한 간단한 Spring Boot server 배포](DevOps/aws/simple-spring-boot-aws.md)
- [CI/CD](DevOps/aws/CI-CD.md)

### 3. Docker
- [Docker](DevOps/docker/Docker.md)
- [Docker install](DevOps/docker/docker-install.md) - ubuntu
- [container, image 삭제](DevOps/docker/container-rm.md)
- [container root로 접속하기](DevOps/docker/container-root.md)
  > `List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)` 해결

### 4. Jenkins
- [Jenkins install](DevOps/jenkins/jenkins-install.md) - ubuntu

## BackEnd
- [Payload](BE/payload.md)

### 1. [Spring Framework](BE/Spring/spring.md) 
- [DI(DependencyInjection)](BE/Spring/DI(Dependency-Injection).md)
- [IoC](BE/Spring/IOC(Inversion-Of-Control).md)
- [Spring 구조](BE/Spring/DTO,DAO,Entity-class.md)
- [Bean](BE/Spring/Bean.md)
  - [Bean 라이프사이클](BE/Spring/bean-life-cycle.md)
- [Logging](BE/Spring/Logging.md)


### 2. [SpringBoot](BE/Spring/SpringBoot/SpringBoot.md)
- [Logback](BE/Spring/SpringBoot/logback.md)
- [File Req, Res처리](BE/Spring/SpringBoot/SpringBootFile-req-res-prosessing.md)
- [CORS 이슈 해결](BE/Spring/SpringBoot/cors.md)

#### 2-1. charset 문제
- [모든 요청에 대해 UTF-8 charset 적용](BE/Spring/SpringBoot/KoreanGarbled.md)
- [S3 버킷의 자원 위치를 가리키는 URL이 character set이 UTF-8이 아니여서 생긴 문제](BE/Spring/URL-utf-8-problem.md)

### 3. Spring MVC
- [Command Object - 커맨드 객체](BE/Spring/SpringMVC/command-object.md)
- [HTTP POST 메서드와 Content-Type](BE/Spring/post-and-content-type.md)
  > feat. Content type 'application/x-www-form-urlencoded;charset=UTF-8' not supported

### 4. SpringSecurity
- [SpringSecurity](BE/Spring/SpringSecurity/spring-security.md)
- [CSRF(사이트간 요청위조)](BE/Spring/SpringSecurity/CSRF.md)

### 5. Build Tool
- [Build Tool](BE/BuildTool/build-tool.md)
#### 5-1. Gradle
- [Gradle](BE/BuildTool/gradle/gradle.md)
- [(SpringBoot Project) Maven에서 Gradle로 Build Tool migration!](BE/BuildTool/gradle/maven-to-gradle-migration.md)
- [build.gradle plugins{...}방식 에러해결](BE/BuildTool/gradle/build-gradle-plugins-allowed%20befor-plugins-block.md)
  > only buildscript {} and other plugins {} script blocks are  
  > allowed before plugins {} blocks, no other statements are allowed   
  > 애러해결

#### 5-2. Maven
- [plugin-not-found 에러 해결 - 버전이 명시가 되어있지 않을때](BE/BuildTool/maven/plugin-not-found.md)

### 6. JPA
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
- [16 JPA 데이터 타입](BE/Spring/JPA/16-jpa-data-type.md)
  1. [기본값 타입](BE/Spring/JPA/16.1-default-type.md)
  2. [임베디드 타입(embedded-type)](BE/Spring/JPA/16.2-embedded-type.md)
  3. [값 타입과 불변 타입](BE/Spring/JPA/16.3-value-and-immutable.md)
  4. [값 타입 비교](BE/Spring/JPA/16.4-value-type-compare.md)
  5. [값 타입 컬렉션](BE/Spring/JPA/16.5-value-type-collection.md)
  6. [JPA 데이터 타입 정리](BE/Spring/JPA/16.6-organize.md)
  7. [JPA 값 타입(실습)](BE/Spring/JPA/16.7-value-type-mapping.md)

#### 6-1. JPQL 객체지향 쿼리 언어
- [00 JPQL intro](BE/Spring/JPA/JPQL/00-intro.md)
- [01 JPQL](BE/Spring/JPA/JPQL/01-JPQL.md)
- [02 프로젝션](BE/Spring/JPA/JPQL/02-projection.md)
- [03 페이징](BE/Spring/JPA/JPQL/03-paging.md)

#### 6-2. [Querydsl](BE/Spring/Querydsl/querydsl.md)

#### 6-3. Spring DATA JPA
- [00 Intro](BE/Spring/JPA/DataJPA/00-intro.md)
- [01 공통인터페이스](BE/Spring/JPA/DataJPA/01-comman-repository.md)
- [02 쿼리 메소드 기능](BE/Spring/JPA/DataJPA/02-query-method.md)
- [Custom Repository](BE/Spring/JPA/DataJPA/custom-repository.md)

### 7. Node.js
- [node.js 설치 및 개발환경 세팅](BE/NodeJS/how-to-install-nodeJs.md)
- [MySQL 연결](BE/NodeJS/Connect-MySql.md)
- [ORM모듈 Sequelize 사용하기(모델만들기)](BE/NodeJS/sequelize.md)

### 8. [SSH](DevOps/ssh/ssh.md)
- [REMOTE HOST IDENTIFICATION HAS CHANGED 에러 해결](BE/SSH/remote-host-identification-has-changed-error.md)

## Database
- [트랜잭션 격리수준](DataBase/db-transcation-isolation-level.md)
- [관계형 데이터베이스 - Relational Database?](DataBase/relational-database.md)
- [조인 알고리즘](DataBase/join-algorithm.md)
- [옵티마이저 - Optimizer](DataBase/optimizer.md)

### 1. SQL 전문가 가이드 - SQLD 준비
1. [데이터 모델링의 이해](DataBase/data-modeling/understanding-data-modeling.md)
2. [엔터티 - Entity](DataBase/data-modeling/entity.md)
3. [데이터 모델과 성능](DataBase/data-modeling/data-model-and-performance.md)
   1. [정규화](DataBase/data-modeling/normalization-and-performance.md)
   2. [반정규화](DataBase/data-modeling/denormalization.md)
   3. [인덱스](DataBase/data-modeling/index.md)
   4. [분산 데이터베이스](database/data-modeling/distributed-database.md)

### 2. [SQL - Structured Query Language](DataBase/sql/sql.md)
- [서브쿼리](DataBase/sql/sub-query.md)
- [윈도우 함수 - window funtion](DataBase/sql/window-funtion.md)
- [CASE 표현식](DataBase/sql/case-expression.md)
- [조인 - Join](DataBase/sql/join.md)


### 3. MySQL
- [MySQL 설치](DataBase/MySQL/how-to-install-mysql.md)
- [MySQL 실행관련 명령어](DataBase/MySQL/mysql-run-command.md)
- [mysql 명령어](DataBase/MySQL/mysql-command.md)

### 4. Oracle
- [Oracle11g Quick Start with docker](DataBase/oracle/oracle11g-quick-start-with-doker.md)
- [옵티마이저 - Optimaizer](DataBase/optimizer.md)

### 5. MongoDB
- [Mongodb](DataBase/mongodb/mongodb.md)

## Network
- [DNS](network/dns.md)
- [Domain](network/domain.md)
- [URI,URL,URN](network/URI-URL-URN.md)

### 1. 프로토콜
- [IP](network/protocol/ip.md)
- [TCP, UDP](network/protocol/tcp-udp.md)
- [RPC 프로토콜]()

### 2. [HTTP](network/http/http.md)
- [더 나은 URI API를 설계 하는 방법과 HTTP method](network/http/http-api-design.md)
- [REST API](network/http/rest-api.md)

### 3. WEB
- [서버기반 인증 & 토큰기반 인증](network/web/token-auth-and-server-auth.md)
- [Cookie, Session](network/web/cookie-and-session.md)
- [Web Socket](network/web/web-socket.md)
- [WAS](network/web/was.md)
- [웹 브라우저의 요청 흐름](network/web/how-to-browser-can-request.md)

## 기타
- [개발용어 정리](ETC/dev-terminology.md)
- [Component](ETC/component.md)