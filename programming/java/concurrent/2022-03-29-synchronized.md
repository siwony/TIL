---
layout: post
author: "정시원"
title: "Synchronized 키워드 - 경쟁상태를 해결하는 방법"
categories: programming
date: 2022-03-29
tags: [java, concurrent]
---

# Synchronized 키워드 - 경쟁상태를 해결하는 방법
`synchronized` 키워드는 Multi-Thread 환경에서 여러개의 쓰래드가 하나의 공유 변수에 동시에 접근할 때 `경쟁상태 - Race Condition`이 발생하지 않도록 한다.

그러면 어떻게 `Synchronized` 키워드는 경쟁상태를 해결할까?  
그것은 바로 현재 데이터를 사용하고 있는 **해당 스레드를 제외하고 나머지 스레드들은 데이터에 접근 할 수 없도록** 즉, blocking을 사용해 경쟁상태를 해결하고 있다.

하지만 이를 너무 남발하면 성능 이슈가 발생하는데, 프로그래밍 내부적으로 block, unblock작업은 어느정도 공수가 들어가는 작업이다. 꼭 필요할 떄 사용하자.

## Synchronized 키워드 사용방법
일반적으로 3가지 동기화 방법이 있다.
1. 인스턴스 메소드 동기화
2. 스태틱 메소드 동기화
3. 메소드 속 동기화


### 1. 인스턴스 메서드에 사용하는 방법
```java
class A {
    private int a = 0;

    public synchronized void increaseA(){
        a++;
        System.out.println(a);
    }
}
```
위에 예시와 같이 메서드 시그니처에 추가하는 방식으로 사용할 수 있다.

#### 주의할 점
여기서 메서드에 synchronized가 붙으니까 메소드 단위로 동기화될 수 있다고 오해할 수 있는데, **해당 방법은 객체 단위로 동기화 된다.** 위 예제를 이용해 설명을 하면, 위에 두 메서드는 동시에 수행될 수 없다.

### 2. 스태틱 메소드 동기화
```java
class A {
    private int a = 0;

    public static synchronized void increaseA(){
        a++;
        System.out.println(a);
    }
}
```
클래스 내의 static 메소드는 오직 하나만 존재한다 그러므로 여러 객체가 하나의 static메소드를 공유하므로, 모든 생성된 객체를 동기화 한다.  
**여러 객체들이 동시에 `increase()`를 호출하면 1개의 쓰레드만 이 메서드에 진입할 수 있다.**


### 3. 메소드 속 synchronized 블록
메소드 단위로 synchronized를 적용하는 것은 비 효율적일 수 있다. `경쟁 상태 - Race condition`가 발생하는 부분만 synchronized블럭을 사용해 동기화 할 수 있다.

사용법은 `synchronized(lock_object)`로 사용할 수 있는데 `lock_object`는 동기화 할 범위 즉, 인스턴스를 의미한다.

```java
public class A {
    private long a = 0;

    public void increase() {
        long temp = 0;

        synchronized (this) {
            a++;
            temp = number;
        }

        System.out.println(temp);
    }
}
```
위 예제는 자신의 인스턴스를 동기화 하는 예제이다.

