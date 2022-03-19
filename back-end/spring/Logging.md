# Logging
: 프로그램 개발 중이나 완료 후 발생할 수 있는 오류에 대해 디버깅하거나 운영중인 프로그램 상태를 모니터링 하기 위해 필요한 정보(log)를 기록하는것
> 로그를 잘 남기는 것은 훌룡한 개발자의 덕목중 하나라고 할 수 있다!
- 애플리케이션 실행에 대한 추적을 기록하기 위해 메시지(콘솔, 파일, DB등) 를 작성하는것
- 디버깅, 사용자 상호 작용 기록(발생하는 이벤트 기록) 에 사용  

### 자바의 주요 Logging Framework
- native java.util.logging : 별로 사용x
- Log4j : 몇 년 전까지 사실상 표준으로 사용
- [Logback](./SpringBoot/logback.md) : log4j 개발자가 만든 log4j의 후속 버전, 현재 많은 프로젝트에서 사용됨 - 현제 SpringBoot의 기본 logging으로 사용하고있다.
- SLF4j(Simple Logging Facade for java) : Log4J 또는 Logback과 같은 백엔드 Logger Framework의 facade pattern

### 스프링 부트의 로깅 원리
스프링 부트는 기본적으로 commons logging을 사용한다. 그렇지만 보통 SLF4J를 사용한다

Commons Logging과 SLF4j는 로거 퍼서드 이다. 실제로 로깅을 수행하는것이 아니라, 로거 API를 추상화 해놓은 인터페이스 이다.

#### 결론
우리는 Commons Logging 혹은 SLF4j를 사용하는데 
1. Commons Logging을 써도 어차피 SLF4j로 바뀐다
2. SLF4j가 Logback logger를 선택한다
3. 최종적으로 Logback을 쓰게 된다.
