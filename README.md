# Today I Learned
오늘 새롭게 배운 혹은 삽질한 경험을 간단한 글들을 마크다운 문서로 정리 해 보자! `start - Dec 12 2020`  
## 분류
### GIT
- [.Ds_store 모두 .gitignore](/Git/ds-store-ignore.md)
- [커밋되지 않거나 저장되지 않은 모든 변경사항 취소 및 삭제](/Git/rm-unstaged.md)
- [Cache 삭제](/Git/cache-remove.md)

### DevOps
- [DevOps](/DevOps/DevOps.md)
- [aws EC2](/DevOps/awsEC2.md)
- [EC2를 이용한 간단한 Spring Boot server 배포](/DevOps/simple-spring-boot-aws.md)
- [SSH](/DevOps/ssh.md)
- [CI/CD](/DevOps/CI-CD.md)
#### Docker
- [Docker](/DevOps/docker/Docker.md)
- [Docker install](DevOps/docker/docker-install.md) - ubuntu
- [container, image 삭제](/DevOps/docker/container-rm.md)
- [container root로 접속하기](/DevOps/docker/container-root.md)
  > `List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)` 해결

#### Jenkins
- [Jenkins install](/DevOps/jenkins/jenkins-install.md) - ubuntu

### BackEnd
- [Payload](/BE/payload.md)

### &nbsp;Java EE
- [JavaEE](/BE/JavaEE/javaee.md)
- [Servlet](/BE/JavaEE/servlet.md)

### &nbsp;Build Tool
- [Build Tool](/BE/BuildTool/build-tool.md)
#### &nbsp;&nbsp; Gradle
- [Gradle](BE/BuildTool/gradle/gradle.md)
- [(SpringBoot Project) Maven에서 Gradle로 Build Tool migration!](/BE/BuildTool/gradle/maven-to-gradle-migration.md)
- [build.gradle plugins{...}방식 에러해결](/BE/BuildTool/gradle/build-gradle-plugins-allowed%20befor-plugins-block.md)
  > only buildscript {} and other plugins {} script blocks are  
  > allowed before plugins {} blocks, no other statements are allowed   
  > 애러해결

#### &nbsp;&nbsp; Maven
- [plugin-not-found 에러 해결 - 버전이 명시가 되어있지 않을때](/BE/BuildTool/maven/plugin-not-found.md)
### &nbsp; Spring 
- [Bean](/BE/Spring/Bean.md)
- [DI(DependencyInjection)](/BE/Spring/DI(Dependency-Injection).md)
- [IoC](/BE/Spring/IOC(Inversion-Of-Control).md)
- [Spring 구조](/BE/Spring/DTO,DAO,Entity-class.md)
- [Logging](/BE/Spring/Logging.md)
### &nbsp; SpringBoot  
- [Logback](BE/Spring/SpringBoot/logback.md)
- [File Req, Res처리](/BE/Spring/SpringBoot/SpringBootFile-req-res-prosessing.md)
- [URL 한글요청할때 깨지는 현상](/BE/Spring/SpringBoot/KoreanGarbled.md)
- [URL의 character set이 UTF-8이 아니여서 생긴 문제](/BE/Spring/URL-utf-8-problem.md)
- [CORS 이슈 해결](BE/Spring/SpringBoot/cors.md)
### &nbsp; SpringSecurity
- [SpringSecurity](/BE/Spring/SpringSecurity/spring-security.md)
- [CSRF(사이트간 요청위조)](/BE/Spring/SpringSecurity/CSRF.md)
### &nbsp; JPA
- [Entity](/BE/Spring/JPA/Entity.md)
- [JPA Auditing으로 생성일/수정일 자동화](/BE/Spring/JPA/Auditing.md)
- [01 JPA?](/BE/Spring/JPA/01-JPA.md)
- [QueryDSL?](/BE/Spring/JPA/QueryDSL.md)
- [02 영속성 컨텍스트?](/BE/Spring/JPA/02-PersistenceContext.md)
- [03 플러시(flush)](/BE/Spring/JPA/03-flush.md)
- [04 준영속 상태](/BE/Spring/JPA/04-detached.md)
- [05 DB schema 자동 생성](/BE/Spring/JPA/05-DB-schema-auto-create.md)
- [06 DDL](/BE/Spring/JPA/06-DDL.md)
- [07 객체와 테이블 매핑](/BE/Spring/JPA/06-object-table-mapping.md)
- [08 기본키 매핑](/BE/Spring/JPA/07-pk-mapping.md)
- [08.5 데이터 중심 설계(실습)](/BE/Spring/JPA/08.5-db-driven-design.md)
- [09 연관관계 맵핑(기초)](/BE/Spring/JPA/09-relationship-mapping-foundation.md)
- [10 다양한 연관관계](/BE/Spring/JPA/10-various-relationship.md)
- [10.5 다양한 연관관계 매핑(실전)](BE/Spring/JPA/10.5-various-relationship-mapping.md)
- [11 연관관계 맵핑(고급) - 상속관계 매핑](BE/Spring/JPA/11-relationship-mapping-advanced.md)
- [12 @MappedSuperclass](BE/Spring/JPA/12-mapped-superclass.md)
- [12.5 상속관계 매핑(실전)](BE/Spring/JPA/12.5-inherit-relationship-mapping.md)
- [13 Proxy](BE/Spring/JPA/13-proxy.md)
- [14 Eager/LAZY loading](BE/Spring/JPA/14-eager-loading-and-lazy-loading.md)
- [15 영속성 전이(cascade)](BE/SPring/JPA/../../Spring/JPA/15-cascade.md)
- [16 고아 객체(ORPAN)](BE/Spring/JPA/16-orpan.md)
- [17 JPA 데이터 타입](BE/Spring/JPA/17-value-type.md)
  1. [기본값 타입](BE/Spring/JPA/17.1-default-type.md)
  2. [임베디드 타입(embedded-type)](BE/Spring/JPA/17.2-embedded-type.md)
  3. [값 타입과 불변 타입](BE/Spring/JPA/17.3-value-and-immutable.md)
  4. [값 타입 비교](BE/Spring/JPA/17.4-value-type-compare.md)
  5. [값 타입 컬렉션](BE/Spring/JPA/17.5-value-type-collection.md)
  6. [JPA 데이터 타입 정리](BE/Spring/JPA/17.6-organize.md)
  7. [JPA 값 타입(실습)](BE/Spring/JPA/17.7-value-type-mapping.md)
#### JPQL 객체지향 쿼리 언어
- [00 JPQL intro](BE/Spring/JPA/JPQL/00-intro.md)
- [01 JPQL](BE/Spring/JPA/JPQL/01-JPQL.md)
- [02 프로젝션](BE/Spring/JPA/JPQL/02-projection.md)
- [03 페이징](BE/Spring/JPA/JPQL/03-paging.md)

#### Spring DATA JPA
- [00 Intro](BE/Spring/JPA/DataJPA/00-intro.md)
- [01 공통인터페이스](BE/Spring/JPA/DataJPA/01-comman-repository.md)
- [02 쿼리 메소드 기능](BE/Spring/JPA/DataJPA/02-query-method.md)

### &nbsp; Node.js
- [node.js 설치 및 개발환경 세팅](/BE/NodeJS/how-to-install-nodeJs.md)
- [MySQL 연결](/BE/NodeJS/Connect-MySql.md)
- [ORM모듈 Sequelize 사용하기(모델만들기)](/BE/NodeJS/sequelize.md)

### &nbsp;SSH
- [REMOTE HOST IDENTIFICATION HAS CHANGED 에러 해결](/BE/SSH/remote-host-identification-has-changed-error.md)


### &nbsp; DataBase
- [RDB 란?](/DataBase/relational-database.md)
### &nbsp; MySQL
- [MySQL 설치](/DataBase/MySQL/how-to-install-mysql.md)
- [MySQL 실행관련 명령어](/DataBase/MySQL/mysql-run-command.md)
- [mysql 명령어](/DataBase/MySQL/mysql-command.md)

### Computer Science
- [소프트웨어 생명주기](CS/swlc.md)
- [소프트웨어 테스트](/CS/sw-test.md)

### Programming
- [Object Orinted Programing](/Programming/OOP.md)  

#### XDD(X Driven Development)
- [DDD](/Programming/DDD.md)
- [TDD & BDD](/Programming/TDD-BDD.md)

#### JAVA
- [JAVA?](/Programming/Java/01-java.md)
- [JAVA 데이터형](/Programming/Java/02-java-Data-type.md)
- [JAVA 배열](/Programming/Java/03-array.md)
- [JAVA Class and Object](/Programming/Java/04-class-and-object.md)
- [JAVA scope, static](/Programming/Java/05-scope-static.md)
- [JAVA enum](/Programming/Java/06-enum.md)
- [JAVA package](/Programming/Java/07-package.md)
- [Enumeration 와 Iterator](/Programming/Java/enumeration-iterator.md)
- [Exception](/Programming/Java/exception.md)
 
#### JAVA Design Pattern
- [디자인패턴?](/Programming/Java/Design-pattern/Design-Pattern.md)
- [전략패턴(Strategy Pattern)](/Programming/Java/Design-pattern/Strategy-Pattern.md)
- [어뎁터패턴(Adepter Pattern)](Programming/Java/Design-pattern/Adepter-Pattern.md)
- [싱글톤패턴(Singleton Pattern)](Programming/Java/Design-pattern/Singleton-Pattern.md)
- [프록시패턴(Proxy Pattern)](Programming/Java/Design-pattern/Proxy-Pattern.md)
- [데코레이터 패턴(Decorator Pattern)](Programming/Java/Design-pattern/Decorator-Pattern.md)
- [옵저버 패턴(Observer Pattern)](Programming/Java/Design-pattern/Observer-Pattern.md)

#### python
- [python install](/Programming/Python/how-to-install-python.md)
- [변수, 데이터형](/Programming/Python/ariables-and-data-type.md)

### Web
- [HTTP](/Web/http.md)
- [API](/Web/api.md)
- [REST API](/Web/RESTAPI.md)
- [Domain](/Web/domain.md)
- [DNS](/Web/dns.md)
- [서버기반 인증 & 토큰기반 인증](/Web/tokenAuth-serverAuth.md)
- [Cookie, Session](/Web/cookie-and-session.md)
- [URI,URL,URN](/Web/URI-URL-URN.md)
- [Web Socket](/Web/web-socket.md)
- [WAS](/Web/was.md)

### Book
- [README](/Book/README.md)
- [객체지향 사실과 오해](/Book/object-orientation-facts-and-misconceptions/README.md)

### 기타
- [개발용어 정리](/ETC/dev-terminology.md)
- [Component](/ETC/component.md)