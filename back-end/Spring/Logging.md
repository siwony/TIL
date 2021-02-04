# Logging
**프로그램 개발 중이나 완료 후 발생할 수 있는 오류에 대해 디버깅하거나 운영중인 프로그램 상태를 모니터링 하기 위해 필요한 정보(로그)를 기록하는것**
- 애플리케이션 실행에 대한 추적을 기록하기 위해 메시지(콘솔, 파일, DB등) 를 작성하는것
- 디버깅, 사용자 상호 작용 기록(발생하는 이벤트 기록) 에 사용  

### 자바의 주요 Logging Framework
- **native java.util.logging** : 별로 사용x
- Log4j : 몇 년 전까지 사실상 표준으로 사용
- Logback : log4j 개발자가 만든 log4j의 후속 버전, 현재 많은 프로젝트에서 사용됨
- SLF4j(Simple Logging Facade for java) : Log4J 또는 Logback과 같은 백엔드 Logger Framework의 facade pattern
