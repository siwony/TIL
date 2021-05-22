# Build Tool
: 빌드 도구는 빌드 자동화를 시켜주는 실행가능한 프로그램만들어 주는 프로그램을 말한다.

> *빌드 자동화  
> : 실행가능한 프로그램을 만들어주는 과정으로써 코드를 컴파일해서 binary code로 만들고 패키징하며 코드를 테스트하고 실행가능한 프로그램이 나오기 까지의 과정

> *빌드  
> : 소스코드 파일들을 컴퓨터에서 실행할 수 있는 소프트웨어로 변환하는 일련의 과정으로, 컴파일, 테스팅, 배포 등 모든 과정의 집합이다.

### Build Tool의 역활
- **빌드 과정을 자동으로 수행해준다.**
- 라이브러리 추가 및 관리

#### 자바 진영에서의 빌드 도구
> 출시 순서는 내림차순
- Ant
- Maven
- Gradle

### Java 진영에서의 Build Tool의 사용목적
Java 프로그램은 다음가ㅗ 같이 많은 파일(artifacts)을 포함하고 있다.
- Java Source code
- Java Byte code
- XML files
- Graphic and audio file
- Directory structures

이모든 파일을 충동없이 Build하는건 힘들일이다.  
Build Tool은 우리가 소스를 작성하는 것과 동시에 빌드 할 수 있도록 도와주는 일이다.