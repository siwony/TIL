# LogBack
LogBack은 SpringBoot에서 기본적으로 제공하는 logging(로깅)라이브러리다.  
- log4j를 토대로 새롭게 만들었다 여러 단점 및 성능이 log4j보다 향상됐다.

### 특징
- SLF4J의 구현체
- 자바 오픈소스 로깅 프레임워크
  > 라이브러리라고 하는데 논란의 여지가 있다.
- log4j, log4j2등과 성능을 비교했을때 logback이 더 훌령한 성능을 보여준다
  > multi thread 환경에서는 log4j2가 엄청난 퍼포먼스를 보여준다.  
  > 참고: https://dololak.tistory.com/632
- spring-boot-starter-web 안에 spring-boot-starter-logging에 구현체가 있다.
- 로깅을 수행하기 필요한 주요 설정요소는 Logger, Appender, Encoder 3가지가 있다.

#### 로깅의 설정 요소
- Logger : 실제 로깅을 수행하는 구성요소로 Level 속성을 통해서 출력할 로그의 레벨을 조절할 수 있다.
- Appender : 로그 메시지가 출력될 대상을 결정하는 요소
- Encoder : Appender에 포함되어 사용자가 지정한 형식으로 표현 될 로그메시지를 변환하는 역할을 담당하는 요소

#### 로깅의 설정방법
- XML : logback.xml로 설정 파일 작성 후 해당 파일을 클래스패스에 위치시킨다.
- Groovy : logback.groovy로 설정 파일 작성 후 해당 파일을 클래스패스에 위치시킨다.

### logback의 log level
로그레벨의 순서는 다음과 같다.  
`TRACE > DEBUG > INFO > WARN > ERROR`
1. TRACE : 추적 레벨은 Debug보다 좀더 상세한 정보를 나타낸다.
   > sql 파라미터의 세부값등 경로 추적을 위해 나타넨다.
2. DEBUG : 프로그램을 디버깅하기 위한 정보를 표시한다.
    > 운영서버에서는 표시하지 않도록 설정한다.
3. INFO : 정보성 로그를 표시한다.
    > 로그인, 상태변경과 같은로그
4. WARN : 처리가능한 문제, 하지만 항후 시스템 에러의 원인이 될 수 있는 경고성 메시지
5. ERROR : 요청을 처리하는 중 오류가 발생한 경우 표시

- 로그에 설정할 수 있는 레벨은 총 5개
- 위에 순서대로 높은 레벨을 가진다. 출력 레벨의 설정에 따라 설정 레벨 이상의 로그를 출력한다.

ex) 로깅 레벨 설정을 "INFO"로 하였을 경우 "TRACE", "DEBUG"레벨은 무시

#### 루트 레벨 전체 로깅 레벨 지정
```properties
logging.level.root = info
```

#### 패키지별로 로깅 레벨지정
```properties
logging.level.com.god.bo.test=info 
logging.level.com.god.bo.test.controller=debug
```

### 설정 case
#### 스프링, 일반 자바프로그램
: logback.xml 파일을 resources 디렉토리에 만들어서 참조한다.

#### SpringBoot
: -logback-spring.xml 파일을 resources 디렉토리에 만들어서 참조한다.

참고 순서  
1. classpath(resources 하위 디렉토리)에 logback-spring.xml파일이 있으면 설정 파일을 읽어간다.
2. logback-spring.xml파일이 없다면 .yml(.properties)파일의 설정을 읽어간다
3. logback-spring.xml파일과 .yml(.properties)파일이 동시에 있으면 .yml(.properties) 설정 파일을 적용 후 xml파일이 적용된다.

### logger 등록 및 사용방법
- LoggerFactory에서 로거 객체를  불ㅇ운 후, 로그 객체를 이용해서 코드의 원하는 부분에 로그를 출력하면 된다.

#### 설정예시

1. 전체 level 설정 = info
2. 특정 컨트롤러 패키지 Log Level 설정 = (com.god.bo.test.controller = debug)
```properties
logging.level.root=info
logging.level.com.god.bo.test=info
logging.level.com.god.bo.test.controller=debug
```

### reference
- [전자정부표준프레임워크 Logging서비스](https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:rte:fdl:logging)
- [갓대희의 작은공간 : Spring Boot 로그 설정(1) - Logback](https://goddaehee.tistory.com/206)
- [갓대희의 작은강간 : Log4j, LogBack정리](https://goddaehee.tistory.com/45) 