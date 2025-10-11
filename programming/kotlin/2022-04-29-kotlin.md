---
layout: post
author: "정시원"
title: "Kotlin"
categories: programming
date: 2022-04-29
tags: [kotlin]
---

# Kotlin
- JetBrains에서 2011년에 공개한 오픈 소스 프로그래밍 언어
- Java에 비해 상당히 간결한 문법을 가지고 있다.
  > 근데 뭔가 많이 간결해서 Java 쓰다가 Kotlin 쓰면 헷깔린다.
- Java와의 상호 운용이 100% 지원된다.
  > 하지만 Runtime 시점에 사용되지 않는 Lombok 의 경우 100% 호환이 안된다.(Kotlin 1.5.20 에 실험적으로 지원한다.)


### Hello World출력
```kotlin
fun main(args: Array<String>) {
    println("Hello World!") // 출력: Hello World
}
```
1. Java와 다르게 `class`선언을 하지 않고 `main` 메서드로 바로 코드를 실행할 수 있다.
    ```java
    public class Main{
        public static void main(String[] argv){
            System.out.println("Hello World!");
        }
    }
    ```
2. kotlin은 세미클론(`;`)을 붙이지 않아도 된다.
   > ex) `println("Hello, World!")`

## kotlin 문법 정리
1. [변수](variable.md)
2. [class]()