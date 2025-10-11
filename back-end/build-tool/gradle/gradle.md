---
layout: post
author: "정시원"
title: "Gradle"
categories: back-end
date: 2022-03-19
tags: [build-tool, gradle]
---

# Gradle
> Java 진영에서 사용하는 [Build Tool](../build-tool.md)이다.

### 하는일
- Artifacts Build한다.
- Dependencies를 관리한다.

### 특징
- Ant처럼 매우 유연한 범용 Build Tool 이다.
- Maven과 같은 구조화 된 build frameWork이다. (구조의 전환이 가능)
- Maven, lvy등 기존 저장소 인프라 또는 `pom.xml` 파일과 `ivy.xml` 파일에 대한 migration의 편이성 제공
    > 참고. [maven to gradle migration](./maven-to-gradle-migration.md)
- 멀티 프로젝트 Build를 지원한다.
- 의존성 관리의 다양한 방법을 제공한다.
- Build script를 `xml`이 아닌 `Groovy` 기반의 DSL을 사용한다.
  > 참고. DSL: Domain Specific Language의 약자로 특정 도메인(산업, 분야등 특정 영역)에 특화된 언어를 말한다.
- 기존 Build를 구성하기 풍부한 Domain modle 제공한다.
- Gradle 설치 없이 Gradle Wrapper를 이용하여 빌드를 지원한다.

### 장점
- Gradle은 Groovy라는 언어를 이요하여 코드로서 설정정보를 구성하기 때문에 구조적인 장점이 있다. + 간결한 정의가 가능하다.
  > Ant, Maven과 같은 기존에 빌드툴은 xml형식을 이용하여 정적인 설정정보를 구성했다.
- 프로젝트를 설정주입방식으로 정의하기 때문에 maven의 상속 구조보다 재사용에 용이하다.

### 기본구조
- 모든 Gradle script는 하나 이상의 project로 구성되며, 하나이상의 task로 구성된다
  > **Project**  
  소스를 jar로 모으거나, java 프로젝트를 컴파일하거나, 테스트를 실행하고, 어플리케이션을 배포하는 등의 업무로 구성된다.

  > **Task**  
  작업의 최소단위이다.
- Gradle은 Java6 버전 이상의 VM환경에서 사용가능하며, 설치를하거나 gradle wrapper를 이용하여 실행환경을 구성할 수 있다.

### 프로젝트 구조
```
├── build.gradle
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
├── settings.gradle
└── src
    ├── main
    │   ├── java
    │   │   └── temp
    │   │       └── App.java
    │   └── resources
    └── test
        ├── java
        │   └── temp
        │       └── AppTest.java
        └── resources
```
#### build.gradle
: Gradle의 기본 빌드 파일이다.  
이 파일에 프로젝트의 빌드에 대한 내용을 명시한다.

#### /gradle/wrapper/gradle-wrapper.jar
: `Gradle Wrapper` 파일이다. `gradlew` 명령어로 프로젝트를 빌드 할 때 이 파일을 참조하여 설정 파일을 구성하므로 `gradle build`와 다르게 새로운 환경에 대한 영향이 없다.
#### /gradle/wrapper/gradle-wrapper.properties
`Gradle Wrapper` 설정 파일이다.
#### gradlew, gradlew.bat
- gradlew - Unix용 실행 스크립트
- gradlew.bat - Windows용 실행 스크립트
#### setting.gradle
: 프로젝트의 설정 정보 파일이다.  
멀티 프로젝트를 구성할 때 하위 프로젝트들과의 관계를 여기서 서술해야 한다.  
명시된 정보를 기준으로 프로젝트를 구성하게 된다.
#### /src
프로젝트의 소스 폴더가 된다.  
`/src/main/java`와 `/src/main/test` 디렉토리 이름처럼 구조를 보면 `maven`과 동일하다.