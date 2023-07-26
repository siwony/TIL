# Plan Archive

- `-plan` 이 붙은 jar 파일이며
- 에플리케이션 실행에 필요한 모든 의존성이 포함되지 않는 파일이며
- 소스코드와 리소스 파일만 포함된다.
- 이런 jar 파일을 thin.jar, standard.jar로 불리기도 한다.

## SpringBoot 애플리케이션에서 생성하지 않는 방법 

- reference: https://docs.spring.io/spring-boot/docs/2.5.1/gradle-plugin/reference/htmlsingle/#packaging-executable.and-plain-archives

Spring Boot 2.5.x 버전부터 build시 자동으로 생성된다 만약 생성을 원하지 않을 경우 classifier를 사용하거나

```kotlin
tasks.getByName<BootJar>("bootJar") {
	classifier = "boot"
}

tasks.getByName<Jar>("jar") {
	classifier = ""
}
```

plan archive를 완전히 build하고 싶지 않을경우 아래와 같이 build.gradle.kts에 추가하면 된다.

```kotlin
tasks.getByName<Jar>("jar") {
	enabled = false
}
```


## Executable-Jar

반대로 Excutable Jar는 그 즉시 실행할 수 있는 jar 파일을 의미한다,

- 애플리케이션 실행에 필요한 모든 의존성이 포함된다.

## 해당 글을 작성하는 이유

토이프로젝트 진행 중 간단하게 AWS ec2환경에서 Github Action + code deploy 를 활용해서 ci/cd를 진행해야 하는 일이 있었다.  
그 중 deploy하는 bash script를 작성하는데 빌드 디렉토리 하위에 `*.jar` 표현식을 가진 파일을 실행하라는 스크립트를 작성했었다.  
그랬더니 plan jar 파일을 실행시켜 cd과정에서 실패했고 이 과정에서 궁금해서 쓰개 됨