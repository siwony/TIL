---
layout: post
author: "정시원"
title: "Atomic"
categories: programming
date: 2022-03-29
tags: [java, concurrent]
---

# Atomic
`java.util.concurrent.atomic`에 정의 되어 있고 멀티 쓰레드 환경에서 동기화에 의존하지 않고, 원자성을 보장하게 해주는 Atomic API에 대해 소개하려고 한다.

### Atomic Access
API소개전 Atomic Access의 개념을 알아보자

Oracle 자바 레퍼런스에 나와있는 Atomic Access의 정의는 다음과 같다.
> In programming, an atomic action is one that effectively happens all at once.  
> An atomic action cannot stop in the middle: it either happens completely, or it doesn't happen at all. No side effects of an atomic action are visible until the action is complete.

글을 요약하자면 처음부터 끝까지 완전히 수행되거나, 아예 아무것도 수행되지 않아야 하는 Action이라고 한다.

#### 왜 끝가지 수행되거나, 아예 아무것도 수행되지 않아야 할까
티켓 구매 서비스에서 유명한 연예인의 콘서트에 예매하는데 티켓이 1개 남은 상황에서 여러명이 동시적으로 구매하려고 하는 경우를 생각해보면

1. 1번 회원 결제 성공
2. 티켓 수량 업데이트가 끝나지 않은 상황에서 2번 회원도 결제에 성공했다.
3. 티켓 수량이 0 으로 변경되었지만 2번 회원은 이미 돈을 지급한 상태이다.
4. 서비스 장애가 발생했다!


티켓 구매라는 작업이 정상적으로 수행되려면 1번 회원의 결제 결과가 재고 수량에 반영되기 전 2번 회원의 결제 시도는 잠시 미뤄야 한다.

하나의 스레드가 모든 작업을 차례대로 처리한다면, 작업 간 공유하는 데이터의 일관성이 깨지는 일은 생기지 않을 것이다. 하지만, 수많은 요청을 빠르게 처리하려면 멀티스레드가 필연적으로 사용된다.  

여러 개의 작업이 쪼개서 번갈아 가며 실행하는 멀티스레드 환경에 `비 원자 연산`이 수행되면 위와 같은 문제가 발생할 수 있으므로 `Atomic 연산`이 필요하다.

#### Atomic Action의 특징
- `인터러브 - Interleave` 하지 않는다.
- 스레드 간섭에 대한 걱정을 하지 않고 사용할 수 있다.
- 메모리 `일관성 - consistency` 오류가 발생할 수 있으므로 동기화해야 하는 필요성을 제거하지 않는다.


## Atomic Type
Atomic Type은 단일 변수에 대해 `Atomic Operations`를 지원한다.
- Wrapping 클래스의 일종
  > 참조타입, 원시타입 두 종류의 변수에 모두 적용가능함
- 사용시 내부적으로 `CAS - Compare And Swap` 알고리즘을 사용해 lock없이 동기화 처리를 한다.
  > non-blocking으로 원자성을 보장한다

#### 주요 Class
- AtomicBoolean
- AtomicInteger
- AtomicLong
- AtomicReference
- AtomicIntegerArray
- AtomicDoubleArray
- AtomicReferenceArrays

#### 주요 Method
- `get()` : 현재 값을 반환한다.
- `set(newValue)` : newValue로 값을 변경한다.
- `getAndSet(newValue)` : 원자적으로 값을 업데이트하고 원래의 값을 반환한다.
- `compareAndSet(expect, update)` : 원자적으로 값을 업데이터 하고 원래의 값을 반환한다.
- 숫자형 Atomic Type의 경우 증감연산을 할 수 있는 메서드를 추가적으로 제공한다.


### Atomic VS synchronized 키워드
#### synchronized 키워드
특정 Thread가 해당 블럭 전체를 lock하기 떄문에 bloking이 발생한다.

#### Atomic
CAS 알고리즘을 통해 `Non-Blocking` 상태로 동기화 문제를 해결할 수 있다.

### Atomic class의 내부
> Java11 기준
```java
public class AtomicBoolean implements java.io.Serializable {

    private static final jdk.internal.misc.Unsafe U = jdk.internal.misc.Unsafe.getUnsafe();
    private volatile int value;

    생략...

    public final int getAndSet(int newValue) {
        return U.getAndSetInt(this, VALUE, newValue);
    }

    생략...
}
```
`getAndSet` method에서 `U.getAndSetInt`를 사용하는데 이것이 CAS 알고리즘이다.

`jdk.internal.misc.Unsafe#getAndSetInt`의 구현을 보면

```java
    @HotSpotIntrinsicCandidate
    public final int getAndSetInt(Object o, long offset, int newValue) {
        int v;
        do {
            v = getIntVolatile(o, offset);
        } while (!weakCompareAndSetInt(o, offset, v, newValue));
        return v;
    }
```
`compareAndSwapInt`를 호출해 메모리에 저장된 값과 현재 CPU에 캐시 된 expect 값을 비교해 같은 경우만 update를 실행한다.  

자세히 설명하면, 현재 연산에서 기대하는 값과 메모리상에서의 값이 일치하지 않는다면 중간에 다른 스레드가 관여한 것으로 판단하여 write를 실패시키고 재시도를 한다.
`lock-free` 방식으로 루프를 돌기 때문에 `block`, `unblock` 상태 변경 처리에 드는 비용이 발생하지 않는다.

> **lock-free**  
> 멀티스레드 환경에서 동시에 호출해도 정확한 결과를 만들어주는 알고리즘
> - 여러개의 스레드에서 동시에 작업이 호출되었을 경우 정해진 시간마다 적어도 한개의 작업이 호출되는 알고리즘이다.

`getIntVolatile`는 native로 구현되어 볼 수 없다.




## Reference
- https://docs.oracle.com/javase/tutorial/essential/concurrency/atomic.html
- https://zion830.tistory.com/58
- https://n1tjrgns.tistory.com/244