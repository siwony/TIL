---
layout: post
author: "정시원"
title: "Kotlin의 변수"
categories: programming
date: 2022-04-29
tags: [kotlin]
---

# Kotlin의 변수
#### 이글의 예제 코드는 Main 함수에서 진행되었으며, Main함수를 생략했습니다.
### 특징
- `var`와 `val`이라는 키워드로 변수를 만든다.
- `Non-null`과 `Nullable`이 존재한다.
  > `?` 키워드로 null을 허용할 것인지 말 것인지 결정한다.
- 변수의 타입을 명시하지 않고도 타입추론이 가능하다.

### 변수의 선언
Kotlin의 변수 선언은 다음과 같다.
```Kotlin
var 변수명: 변수타입 = 초기화값
ex) var siwony: String = "siwony"

val 변수명: 변수타입 = 초기화값
ex) val siwony: String = "siwony"
```
여기서 `var`과 `val`를 제외하고는 Java와 별반차이가 없다.

#### Java의 경우 예시
```java
String siwony = "siwony";
```

도대체 `val`과 `var`의 차이가 무엇일까?

### val과 var의 차이
#### val
- `val`은 valuable이다.
- 읽기만 가능하다. &rarr; 불변 변수이다.
- Java로 따지만 `final` 키워드를 붙인 변수라고 생각하면 된다.

예시
```kotlin
val siwony: String = "siwony"
siwony = "si_wony" // val은 불변변수 이므로 컴파일 에러가 발생한다.
println(siwony) //print(변수) 콘솔의 특정 값을 출력할 수 있는 함수
```
- 위 코드는 콘솔의 `"si_sowny"`를 출력하기 전에 `Val cannot be reassigned` 에러를 발생시킨다.

#### var
- `var`는 variable이다.
- 읽기/쓰기 쓰기가 가능한 변수다.

예시
```kotlin
val siwony: String = "siwony"
siwony = "si_wony"
println(siwony) // siwony가 아닌 si_wony가 출력된다.
```
- 정상적으로 `siwony` 변수의 값이` "si_wony"`로 변경 되어 출력된다.

### Non-null 과 Nullable
> Kotlin은 `Non-null`타입과 `Nullable`타입을 가지고 있다.

#### Non-null
: 변수가 null을 가질 수 없는 타입이다.

예제
```kotlin
var siwony : String = null // 컴파일 에러가 발생한다.
```
- `siwony` 변수는 null을 허용하지 않아 `Null can not be a value of a non-null type String` 에러를 발생시킨다.

#### Nullable
: 변수가 null을 가질 수 있는 타입이다.
```kotlin
var siwony : String? = null
// 
println(siwony) // 출력: null
```
- 성공적으로 `siwony` 변수에 null이 들어갔다.
- null을 출력했다.

### 변수의 타입 추론
코틀린은 컴파일 시점에 타입을 결정하는 정적 타입 언어이다. 즉, **컴파일과 동시에 타입이 결정된다.**

#### 타입 추론의 예시
```kotlin
var siwony = "siwony" // String 타입으로 추론이 됌
println(siwony) // 출력: siwony

var age = 12 // Int 타입으로 추론이 됌
println(age) // 출력: 12

var height = 174.3 // Double 타입으로 추론이 됌
println(height) 출력: 174.3
```

#### 타입 추론의 잘못된 예시
```kotlin
var siwony = "siwony"
siwony = 17 // String 타입에 Int타입의 값을 대입했으므로 컴파일 에러
```
- `The integer literal does not conform to the expected type String` 에러가 나왔다.
#### 결론은 컴파일 시점에 타입을 결정하는 정적 타입 언어이므로 타입을 자유자재로 변경할 수 없다.