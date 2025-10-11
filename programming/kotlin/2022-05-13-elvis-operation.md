---
layout: post
author: "정시원"
title: "엘비스 연산자 - Elvis Operation"
categories: programming
date: 2022-05-13
tags: [kotlin]
---

# 엘비스 연산자 - Elvis Operation
- 엘비스 연산자는 `?:`로 표현된다.
- 왼쪽 객체가 non-null이면 그 객체의 값으 리턴되고, null이면 ?:의 오른쪽 값을 리턴한다.

### if-else 예제
if-else를 사용하여 문자열의 길이를 구하는 메서드를 구현하는 예제이다.
```kotlin
fun main(args: Array<String>){
    val str: String? = "1234"
    val nullStr: String? = null

    println(getStrLength(str)) // 4출력
    println(getStrLength(nullStr)) // -1 출력
    
}
fun getStrLength(str: String?): Int{
    return if(str != null) str.length else -1
}
```

이 코드를 엘비스 연산자를 이용하여 구현한다면 다음과 같다.
```kotlin
fun main(args: Array<String>){
    val str: String? = "1234"
    val nullStr: String? = null

    println(getStrLength(str)) // 4출력
    println(getStrLength(nullStr)) // -1 출력
    
}
fun getStrLength(str: String?): Int{
    return str?.length ?: -1
}
```

### Throw Exception 예제
Exception이 발생되도록 할 수 있다.
```kotlin
fun findMemberByIdx(memberIdx: Long) : MemberEntity{
    return memberRepository.findByIdOrNull(memberIdx) ?: throw IllegalStateException("존재하지 않는 회원입니다.")
}
```


## Reference
https://codechacha.com/ko/kotlin-elvis-operation/