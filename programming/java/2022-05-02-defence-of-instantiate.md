---
layout: post
author: "정시원"
title: "인스턴스화를 막는 방법"
categories: programming
date: 2022-05-02
tags: [java]
---

# 인스턴스화를 막는 방법
객체지향에서 객체를 만드는 인스턴스화를 막는다니 이게 뭔소리인가 싶지만, 주로 유틸리티성 클래스같이 정적 메소드로만 이루어져 있는 클래스들은 객체를 생성할 필요가 없다.  

객체를 생성할 필요가 없으므로 불필요한 인스턴스화를 막기위한 방법에 대해 적어보려고 한다.

### private생성자를 활용하자
```java
public class HelloUtil{
    private HelloUtil(){

    }

    public static String hello(){
        return "hello";
    }
}
```

이렇게 기본 생성자의 접근지정자를 `private`으로 막아두면 외부에서 객체를 생성하지 못한다. 하지만, 여전히 내부에서는 생성할 수 있다.  

구지 이것을 막고싶다면, `AssertionError`를 던지자 
```java
public class HelloUtil{

    /**
     * 이 클래스는 인스턴스를 만들 수 없다.
    **/
    private HelloUtil(){
        throw new AssertionError();
    }

    public static String hello(){
        return "hello";
    }
}
```
이런식으로 내부에서 객체를 생성하려 시도하면 Error가 발생하여 객체가 생성되지 않는다.

#### AssertionError
해당 객체는 error이기 때문에 `try~catch`로 막지 말자.

