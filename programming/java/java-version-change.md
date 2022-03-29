# Java version 변경

#### 1. 현재 동작하는 java의 버전을 확인한다.
```bash
$ java -version
java version "17.0.1" 2021-10-19 LTS
Java(TM) SE Runtime Environment (build 17.0.1+12-LTS-39)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.1+12-LTS-39, mixed mode, sharing)
```
현재 작성자 기준 17로 동작하고 있다.

#### 2. 설치되어 있는 JVM 목록 확인
```bash
$ /usr/libexec/java_home -V
Matching Java Virtual Machines (3):
    17.0.1 (x86_64) "Oracle Corporation" - "Java SE 17.0.1" /Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home
    11.0.11 (x86_64) "AdoptOpenJDK" - "AdoptOpenJDK 11" /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
    1.8.0_292 (x86_64) "AdoptOpenJDK" - "AdoptOpenJDK 8" /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home
```
현재 작성자는 다음 버전이 설치 되어 있다.
- JDK1.8
- JDK11
- JDK17


#### 3. JAVA_HOME 경로를 자신이 원하는 버전으로 설정한다.
작성자는 JDK11로 변경할 것 이다.
```bash
$ export JAVA_HOME=$(/usr/libexec/java_home -v 11) 
$ source ~/.bash_profile
```
