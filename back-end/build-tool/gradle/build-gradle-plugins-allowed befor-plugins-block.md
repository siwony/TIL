# build.gradle plugins{} error
> only buildscript {} and other plugins {} script blocks are  
> allowed before plugins {} blocks, no other statements are allowed 에러 해결

build.gradle의 플러그인 구성은 `plugins{}`와 `apply plugin`의 두 가지 형식이 있다.  

하지만, `plugins{}` 방식으로 구성을 하려면 plugins의 위치가 중요하다.  

#### 예제코드
```gradle
group = 'com.moment'
version = '0.0.1-SNAPSHOT'
description = 'the'
java.sourceCompatibility = JavaVersion.VERSION_11

plugins {
    id 'java'
    id 'maven-publish'
    id 'org.springframework.boot' version '2.4.2'
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'
}
```
다음과같이 `plugins{...}` 코드 위에  `buildscript{}` 및 기타 `plugins{}` 를 제외한 코드가 있다.  
그러면 이제 아래와 같은 error를 startup 시점에 발생시킨다.

#### error 코드
```sh
Build file '{ProjectDir}/build.gradle' line: 5

Could not compile build file '{ProjectDir}/build.gradle'.
> startup failed:
  build file '{ProjectDir}/build.gradle': 5: only buildscript {} and other plugins {} script blocks are allowed before plugins {} blocks, no other statements are allowed

```
> *{ProjectDir} : 자신의 프로젝트위치를 말합니다.

### 해결방법
`plugins{...}` 코드위에 `buildscript{}` 및 기타 `plugins{}` 를 제외한 script를 작성하지 않으면 된다.
#### 예제코드
```gradle
plugins {
    id 'java'
    id 'maven-publish'
    id 'org.springframework.boot' version '2.4.2'
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'
}

group = 'com.moment'
version = '0.0.1-SNAPSHOT'
description = 'the'
java.sourceCompatibility = JavaVersion.VERSION_11
```