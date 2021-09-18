# Concurrent 프로그래밍
- 동시에 여러 작업을 진행할 수 있는 프로그래밍
- ex. 유튜브 보면서 코딩
### 자바에서 지원하는 Concurrent 프로그래밍
- 멀티 프로세싱 (ProcessBuilder)
- 멀티 스레드
  > Thread, Runnable 등...

## 기본적인 Threed
### 구현 방법
#### Thread상속
```java
public static void main(String[] args) {
    HelloThread helloThread = new HelloThread();
    helloThread.start();
    System.out.println("hello : " + Thread.currentThread().getName());
}
static class HelloThread extends Thread {
    @Override
    public void run() {
        System.out.println("world : " + Thread.currentThread().getName());
    } 
}
```
#### Runnable 구현, 람다
```java
Thread thread = new Thread(() -> System.out.println("world : " + Thread.currentThread().getName()));
thread.start();
System.out.println("hello : " + Thread.currentThread().getName());
```
### 주요기능
#### sleep
: 해당 스레드를 일정 시간동안 멈춘다.
- 락을 주지않는다.
  > 데드락의 위험성
- `interrupt()` 메소드가 호출되면 `InterruptedException`가 발생한다.
사용방법
```java
String importantInfo[] = {
    "Mares eat oats",
    "Does eat oats",
    "Little lambs eat ivy",
    "A kid will eat ivy too"
    };

for (int i = 0; i < importantInfo.length; i++) {
    // 4초 간 중지한다
    Thread.sleep(4000);
    // 메세지를 출력한다
    System.out.println(importantInfo[i]);
}
```

#### interrupts
: 해당 스레드를 꺠워서 `InterruptedExeption`를 발생 시킨다.
- InterruptedExeption를 예외처리 하는 것은 해당 스레드가 결정한다.
```java
Thread thread = new Thread(
        () -> {
            try {
                Thread.sleep(4000L);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println(Thread.currentThread());
        }
);

thread.start();
thread.interrupt();
```

#### join
: 다른 스레드가 끝날 때까지 기다린다.
- join를 사용하는곳 에서 `InterruptedException`이 발생한다.
```java
Thread thread = new Thread(
        () -> {
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println("thread is done"); // 먼저 출력
        }
);
thread.start();
thread.join();
System.out.println("main thread is done");
```

