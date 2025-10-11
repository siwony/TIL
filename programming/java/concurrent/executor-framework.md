---
layout: post
author: "정시원"
title: "Executor Framework"
categories: programming
date: 2022-03-29
tags: [java, concurrent]
---

# Executor Framework
: 고수준 (High-Level) Concurrency 프로그래밍를 지원하는 Framework

- Executor에 스레드를 만들고 관리하는 작업을 위임한다.
- `Executor`, `ExecutorService`, `ScheduledExecutorService`
  > 주로 `Executor`를 사용하는 것 보다 `Executor`를 상속받은 `ExecutorService`를 사용한다.
- Executors를 통해 `Executor`, `ExecutorService`, `ScheduledExecutorService`를 생성할 수 있다.
- JDK5 부터 지원한다.
  > JDK5이전에는 개발자가 직접 Thread Pool를 만들어 관리했다.

### 하는 역할
- 스레드 생성
  > 애플리케이션이 사용할 스레드 풀을 만들어 관리한다.
- 스레드 관리
  > 스레드의 생명주기를 관리한다.
- 작업처리 및 실행
  > 스레드로 실행할 작업(task)을 언제든지 실행할 수 있게 한다.

## 간단한 사용 예시
### `ExecutorService` 생성
`Executors`를 통해 `ExecurotService`를 생성할 수 있다. 
> 다음 메소드를 제공하여 스레드 풀을 개수 및 종류를 정할 수 있다.
- `Executors.newFixedThreadPool(int)`
  > 인자 개수만큼 고정된 스레드 풀을 만든다.
- `Executors.newCachedThreadPool()`
  > 필요한 만큼 스레드 풀을 생성한다.
- `Executors.newSingleThreadExecutor()`
  > 스레드가 한개인 `ExecutortService`객체를 생성한다.

예시 - 10개의 Thread Pool 생성
```java
ExecutorService executorService = Executors.newFixedThreadPool(10);
```

### ExecutorService에 task 할당하기
`ExecutorService`는 `Runnable`과 `Callable` task를 실행할 수 있다.
- 결과가 없는 task는 `execute(Runnable)`를 사용한다.
- 결과가 있는 task는 `Future`를 반환하는   
  `submit(Runnable)`, `submit(Runnable, T resulte)`, `submit(Callable<T>)`를 사용한다.

예시 - Runnable
```
executorService.execute(
  () -> System.out.println("Hello world!")
)
executorService.execute(
  () -> System.out.println("Hello thread!")
)
```

예시 - Callable
```java
Callable<String> callable = () -> {
    StringBuilder sb = new StringBuilder();
    for(int i = 0; i < 10; i++)
        sb.append(i);

    return sb.toString();
};

Future<String> submit = executorService.submit(callable);
System.out.println(submit.get()); // 출력 0123456789 
```
- `Future.get`
  - 해당 스레드의 작업 결과를 가져온다.
  - `InterruptedException`에 대한 예외처리가 필요하다.

### ExecutorService 종료하기
`ExecutorService`는 `ExecutorService`를 종료하기 위한 두가지 매서드를 제공한다.

#### shutdown
> Graceful Shutdown

: 이 method가 실행될 때, 새로운 task가 할당되는 것을 막고 이미 전에 제출된 task가 실행되는 것을 기다린 후 종료한다.
- shutdown를 실행한 후 task를 실행하면 `RejectedExecutionException`이 발생한다.

예시 코드
```java
executorService.execute(() -> {
    try {
        Thread.sleep(1000L);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    System.out.println("before shutdown");
});
executorService.shutdown();
executorService.execute(() -> System.out.println("after shutdown")); 
```
예시 출력결과
```sh
Exception in thread "main" java.util.concurrent.RejectedExecutionException: Task TestMain$$Lambda$16/0x0000000800066040@2133c8f8 rejected from java.util.concurrent.ThreadPoolExecutor@43a25848[Shutting down, pool size = 1, active threads = 1, queued tasks = 0, completed tasks = 0]
	at java.base/java.util.concurrent.ThreadPoolExecutor$AbortPolicy.rejectedExecution(ThreadPoolExecutor.java:2055)
	at java.base/java.util.concurrent.ThreadPoolExecutor.reject(ThreadPoolExecutor.java:825)
	at java.base/java.util.concurrent.ThreadPoolExecutor.execute(ThreadPoolExecutor.java:1355)
	at TestMain.main(TestMain.java:25)
before shutdown
```

#### shutdownNow
: 모든 활성된 task을 즉시 종료하려 시도하고 새로운 task가 할당되는 것을 막는다.

예시 코드
```java
executorService.execute(() -> {
    try {
        Thread.sleep(1000L);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    System.out.println("Hello World");
});
executorService.shutdown();
executorService.execute(() -> System.out.println("Hello World")); 
```
예시 출력결과
```sh
java.lang.InterruptedException: sleep interrupted
	at java.base/java.lang.Thread.sleep(Native Method)
	at TestMain.lambda$main$1(TestMain.java:18)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)
	at java.base/java.lang.Thread.run(Thread.java:829)
Exception in thread "main" java.util.concurrent.RejectedExecutionException: Task TestMain$$Lambda$16/0x0000000800066040@2133c8f8 rejected from java.util.concurrent.ThreadPoolExecutor@43a25848[Shutting down, pool size = 1, active threads = 1, queued tasks = 0, completed tasks = 0]
	at java.base/java.util.concurrent.ThreadPoolExecutor$AbortPolicy.rejectedExecution(ThreadPoolExecutor.java:2055)
	at java.base/java.util.concurrent.ThreadPoolExecutor.reject(ThreadPoolExecutor.java:825)
	at java.base/java.util.concurrent.ThreadPoolExecutor.execute(ThreadPoolExecutor.java:1355)
	at TestMain.main(TestMain.java:25)
before shutdown
```
- `InterruptedException`가 발생한 것을 통해 곧바로 task를 종료하려 시도한 것을 알 수 있다.