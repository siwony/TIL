# JVM, JDK, JRE
### JVM - Java Virtual Machine
> WORA - Write Once Run Anywhere
- JVM으로 Java byte code(`.class`파일)를 OS 특화된 코드로 변환(인터프리터, JIT컴파일러)하여 실행한다.
- byte code를 실행하는 표준이자 구현체 이다.
  - JVM 스펙: https://docs.oracle.com/javase/specs/index.html
  - JVM 밴더: 오라클, 아마존, Azul 등...
- 특정 플랫폼에 종속적이다.

> #### JVM 기반으로 동작하는 프로그래밍 언어
> Kotlin, Scala, Groovy, JRuby 등...


### JRE - Java Runtime Environment
> Java 10까지 JDK뿐만 아니라 JRE까지 배포했다.
- JVM + 핵심 라이브러리
- 개발 관련 x, **실행 관련 o**
- Java11부터 Java는 JRE로 따로 배포하지 않는다.

### JDK - Java Development Kit
> Java 11부터는 JDK 단위로 배포된다.
- JRE + 개발 툴(java c)
- 소스코드를 작성할 떄 Java언어는 플랫폼 독립적이다.
  > JVM만 구현되어 있으면 어느 플랫폼에서든지 컴파일 및 실행을 할 수 있다.

### Java의 유료화?
Java는 여러개의 구현체가 존재한다. 그 중 Oracle에서 만든 Oracle JDK 11버전부터 상용으로 사용할 떄 유료이다.  

**즉, 어떤 JDK를 사용하냐에 따라 다르다** 
> ex. openJDK를 사용하면 무료다!