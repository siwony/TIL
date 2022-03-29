# CompletableFuture
`비동기 - Asynchronous` 프로그래밍에 대한 여러 기능을 제공하는 인터페이스.
> [공식 문서](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CompletionStage.html)

#### 기존 Future의 단점
- `Future`를 외부에서 완료 시킬 수 없다.
  > 취소하거나 `get()`에 타임아웃을 설정할 수는 있다.
- 블로킹 코드(`Future.get()`)를 제외하고 작업이 끝났을 때 콜백을 실행할 수 없다.
  > 추가적인 작업이 필요하면 `Future.get()`뒤에 작업을 해야 한다.
- 여러 `Future`를 조합할 수 없다.
- 예외 처리용 API를 제공하지 않는다.


JDK8부터 `CompletableFuture` 인터페이스가 소개되었고, `Future` 인터페이스를 구현함과 동시에 `CompletionStage` 인터페이스를 구현한다. `CompletionStage`는 비동기 연산 Step을 제공해서 계속 `매서드 체이닝 - Method Chaining` 형태로 조합이 가능하다.

#### 구현된 interface
- [`Future`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/Future.html)
- [`CompletionStage`](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CompletionStage.html)

#### Fork/Join Framework
`CompletableFuture`는 `Fork/Join` 기반으로 만들어졌다.

Fork/Join Framework의 동작 원리는 
1. 작업을 잘게 나눌 수 있을 때까지 split 하고
2. 작업 큐에 있는 tail task를 다른 쓰레드가 나누어 병렬처리한 후, 
3. join하여 합산한다.  

`CompletableFuture`의 기본 Thread Pool은 Fork/Join Thread Pool (`ForkJoinPool.commonPool()`)를 사용한다.


## 사용방법
**`CompletableFuture`도 `Future`처럼 결과값을 가져오는것(ex. `get()`)을 하지 않으면 선언해 놓은 작업(Task)은 실행은 되지만 main thread에서는 아무 영향이 없다.**
### 비동기로 작업 실행하기
- 리턴값이 없는 경우: `runAsync()`
- 리턴값이 있는 경우: `supplyAsync()`

#### `runAsync()`- 리턴값이 없는 경우
코드 예시
```java
CompletableFuture<Void> future = CompletableFuture.runAsync(
        () -> System.out.println("Hello " + Thread.currentThread().getName())
);

Void futureValue = future.get();
System.out.println("void type CompletableFuture: " + futureValue);
```
출력 예시
```sh
Hello ForkJoinPool.commonPool-worker-19
void type CompletableFuture: null
```
- 리턴값이 없는 task이므로 `future.get()`의 결과값은 Void타입에 null이 반환되었다.
- 따로 Thread Pool를 정해주지 않아도 ForkJoinPool를 이용했다.
> **`Void `타입이란?**  
> void 타입을 클래스로 나타낸 타입이다. 기본생성자가 private로 되어있어 인스턴스를 생성할 수 없으므로 `Void` 타입으로 선언한 변수의 값은 null이 들어갈 수 밖에 없다. 일부 특수상황(리플렉션, 제네릭)을 제외한 평상시에는 사용하지 않는 게 좋다.

#### `supplyAsync()`- 리턴값이 있는 경우
코드 예시
```java
CompletableFuture<String> future = CompletableFuture.supplyAsync(
        () -> {
            String hello = "Hello ";
            System.out.println(hello + Thread.currentThread().getName());
            return hello;
        }
);

String futureValue = future.get();
System.out.println("String type CompletableFuture: " + futureValue);
```
출력 예시
```sh
Hello ForkJoinPool.commonPool-worker-19
String type CompletableFuture: Hello 
```

#### Executors Thread Pool 사용하기
- runAsync(), supplyAsync()둘다 사용가능하다.
- `Runnable`, `Callable`다음 인자로 Executors를 사용해 Thread Pool를 사용할 수 있다,

코드 예제
```java
ExecutorService executorService = Executors.newFixedThreadPool(5); // 추가된 부분!

CompletableFuture<String> future = CompletableFuture.supplyAsync(
        () -> {
            String hello = "Hello ";
            System.out.println(hello + Thread.currentThread().getName());
            return hello;
        }, executorService // 추가된 부분!
);

String futureValue = future.get();
System.out.println("String type CompletableFuture: " + futureValue);
```

출력 예시
```sh
Hello pool-1-thread-1
String type CompletableFuture: Hello 
```
- ForkJoinPool이 아닌 그냥 pool로 출력되는 것을 확인할 수 있다.

### 콜백 제공하기
> thenApply(Function), thenAccept(Consumer), thenRun(Runnable)
- 메서드 체이닝 형태로 콜백을 제공할 수 있다.
- 콜백이 온다 해도 `get()`를 사용해야 작업의 결과를 얻을 수 있다.
- 콜백 자체를 또 다른 스레드에서 처리할 수 있다.

#### thenApply(Function) - 결과값을 다른 타입으로 변경한다.
코드 예시
```java
CompletableFuture<String> future = CompletableFuture.supplyAsync(
        () -> "Hello"
).thenApply(
        String::toUpperCase
);

String futureValue = future.get();
System.out.println("thenApply: " + futureValue);
```
출력 예시
```sh
thenApply: HELLO
```

#### thenAccept(Consumer) - 결과값을 이용해 반환값이 없이 추가적인 행동만 한다.
코드 예시
```java
CompletableFuture<Void> future = CompletableFuture.supplyAsync(
        () -> "Hello"
).thenAccept((s) -> {
    System.out.println(s + " thenAccept: " + Thread.currentThread().getName());
});

Void futureValue = future.get();
System.out.println("thenApply: " + futureValue);
```
출력 예시
```sh
Hello thenAccept: main
thenApply: null
```
- 현 예제의 `thenAccept`는 main 스레드에서 실행되었지만, ForkJoinPool에 있는 Thread를 사용하기도 한다.
- `thenAccept()`으로 전달한 콜백 앞선 콜백을 실행한 쓰레드나 그 쓰레드를 파생시킨 부모에서 실행된다.

#### thenRun(Runnable) - 결과값을 받지 않고 다른 작업을 처리하는 콜백
코드 예시
```java
CompletableFuture<Void> future = CompletableFuture.supplyAsync(
        () -> "Hello"
).thenRun(() -> {
    System.out.println("thenRun: " + Thread.currentThread().getName());
});

Void futureValue = future.get();
System.out.println("thenApply: " + futureValue);
```
출력 예시
```sh
thenRun: main
thenApply: null
```

- 현 예제의 `thenAccept`는 main 스레드에서 실행되었지만, ForkJoinPool에 있는 Thread를 사용하기도 한다.
- `thenRun()`으로 전달한 콜백 앞선 콜백을 실행한 쓰레드나 그 쓰레드를 파생시킨 부모에서 실행된다.

### 작업 조합하기
#### thenCompost - 두 작업이 서로 이어서 실행하도록 조합한다.
코드 예시
```java
public class CompletableFutureEX {

    public static void main(String[] args) throws ExecutionException, InterruptedException {
        CompletableFuture<String> helloFuture = CompletableFuture.supplyAsync(
                () -> {
                    System.out.println("Hello " + Thread.currentThread().getName());
                    return "Hello ";
                }
        ).thenCompose(CompletableFutureEX::getWorldFuture);

        String helloWorldFuture = helloFuture.get();
        System.out.println("helloWorldFuture = " + helloWorldFuture);
    }

    // thenCompose의 인수를 메서드 레퍼런스로 넘겨주기 위해 만든 메서드
    private static CompletableFuture<String> getWorldFuture(String message) {
        return CompletableFuture.supplyAsync(
                () -> {
                    System.out.println("World " + Thread.currentThread().getName());
                    return message + "World";
                }
        );
    }
}
```
출력 예시
```sh
Hello ForkJoinPool.commonPool-worker-19
World ForkJoinPool.commonPool-worker-5
helloWorldFuture = Hello World
```

#### thenCombin - 두 작업을 독립적으로 실행하고 둘 다 종료 되었을 떄 콜백 실행
코드 예시
```java
CompletableFuture<String> helloFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("Hello " + Thread.currentThread().getName());
                return "Hello";
        }
);

CompletableFuture<String> worldFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("World " + Thread.currentThread().getName());
                return "World";
        }
);

CompletableFuture<String> helloWorldFuture = helloFuture.thenCombine(worldFuture, (hello, world) -> hello + " " + world);
System.out.println("helloWorldFuture.get() = " + helloWorldFuture.get());
```
출력 예시
```sh
World ForkJoinPool.commonPool-worker-5
Hello ForkJoinPool.commonPool-worker-19
helloWorldFuture.get() = Hello World
```

#### allOf() - 여러 작업을 모두 실행하고 모든 작업결과에 대해 콜백을 실행한다. (`CompletableFuture<Void>` 반환)
코드 예시
```java
CompletableFuture<String> helloFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("Hello " + Thread.currentThread().getName());
                return "Hello";
        }
);

CompletableFuture<String> worldFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("World " + Thread.currentThread().getName());
                return "World";
        }
);

CompletableFuture<Void> voidCompletableFuture = CompletableFuture.allOf(helloFuture, worldFuture)
                .thenAccept(System.out::println);

System.out.println("voidCompletableFuture = " + voidCompletableFuture.get());
```
출력 예시
```sh
Spring ForkJoinPool.commonPool-worker-23
Hello ForkJoinPool.commonPool-worker-19
World ForkJoinPool.commonPool-worker-5
null
voidCompletableFuture = null
```
`thenAccept`를 통해 "Hello"와 "World"가 출력되길 기대했지만 `null`이 반환되었다.   
왜냐하면 `CompletableFuture`는 제네릭으로 `Void`를 받고 있기 떄문이다.

만약 위 예시 코드에서 "Hello"와 "Wold"를 출력하고 싶으면 조금 복잡하지만 앞으로 나올 방식으로 출력할 수 있다.

코드 예시
```java
CompletableFuture<String> helloFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("Hello " + Thread.currentThread().getName());
                return "Hello";
        }
);

CompletableFuture<String> worldFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("World " + Thread.currentThread().getName());
                return "World";
        }
);

// Stream을 사용하기 위해 ArrayList를 생성한다.
List<CompletableFuture<String>> futuresAsList = Arrays.asList(helloFuture, worldFuture);
CompletableFuture[] futuresAsArray = futuresAsList.toArray(CompletableFuture[]::new);

CompletableFuture<List<String>> listCompletableFuture = CompletableFuture.allOf(futuresAsArray)
        .thenApply(v -> futuresAsList.stream()
                .map(CompletableFuture::join)
                .collect(Collectors.toList())
        );

listCompletableFuture.get().forEach(System.out::println);
```

출력 예시
```sh
Hello ForkJoinPool.commonPool-worker-19
World ForkJoinPool.commonPool-worker-5
Hello
World
```
- `thenApply`인수로 넘겨준 `Function`이 실행되는 시점은 이미 작업이 완료되는 시점이므로 모든 작업들을 가져올 수 있다.
- 위 방법은 아무것도 `블로킹 - blocking` 처리가 되지 않는다.
  > 이해가 되지 않지만 일단 받아드리자

#### anyOf() - 여러 작업 중에 가장 빨리 끝난 하나의 결과에 콜백 실행
코드 예시
```java
CompletableFuture<String> helloFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("Hello " + Thread.currentThread().getName());
                return "Hello";
        }
);

CompletableFuture<String> worldFuture = CompletableFuture.supplyAsync(
        () -> {
                System.out.println("World " + Thread.currentThread().getName());
                return "World";
        }
);

CompletableFuture<Void> voidCompletableFuture = CompletableFuture.anyOf(helloFuture, worldFuture).thenAccept(
        System.out::println
);
voidCompletableFuture.get();
```

출력 예시
```sh
World ForkJoinPool.commonPool-worker-5
Hello ForkJoinPool.commonPool-worker-19
World
```

### 예외 처리하기
#### exeptionally(Function) - 해당 task에 예외가 발생하면 Function를 실행한다.
코드 예시
```java
CompletableFuture<String> helloFuture = CompletableFuture.supplyAsync(
        () -> {
                boolean throwError = true;

                if(throwError)
                throw new IllegalArgumentException();

                System.out.println("Hello " + Thread.currentThread().getName());
                return "Hello";
        }
).exceptionally(
        (ex) -> { //해당 task에 대한 Exception
                System.out.println(ex);
                return "Error!";
        }
);

System.out.println(helloFuture.get());
```

출력 예시
```sh
java.util.concurrent.CompletionException: java.lang.IllegalArgumentException
Error!
```

#### handle(BiFunction) - 해당 task의 정상 결과와 예외 결과를 종합적으로 처리할 수 있다.
- 예외 여부에 상관없이 무조건 실행된다.

코드 예시
```java
CompletableFuture<String> helloFuture = CompletableFuture.supplyAsync(
        () -> {
                boolean throwError = false; // 해당 변수가 false면 Exception이 발생하지 않는다.

                if(throwError)
                throw new IllegalArgumentException();

                System.out.println("Hello " + Thread.currentThread().getName());
                return "Hello";
        }
).handle(
        (result, ex) ->{
                if(ex != null){
                return "Error!";
                }else{
                return result;
                }
        }
);
System.out.println(helloFuture.get());
```
출력 예시
```sh
######### throwError가 false인 경우 ###########
Hello ForkJoinPool.commonPool-worker-19
Hello

######### throwError가 true 경우 ###########
Hello ForkJoinPool.commonPool-worker-19
Error!
```