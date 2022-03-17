# Callable과 Future
`Callable`은 `Runnable`과 다르게 작업(task)의 결과를 받을 수 있다.  
그리고 `ExecutorService`를 이용해 `Callable`의 작업물을 `Future`객체로 감싸서 받을 수 있다.

### Callable
- 인자가 없고 리턴 타입의 객체를 리턴한다.
- `ExecutorService`의 `submit`매서드를 사용하여 Task를 실행할 수 있다.

### Future
- 비동기적인 작업의 현재 상태를 조회하거나 결과를 가저 올 수 있다.
- 블로킹 콜을 이용해 최종 결과를 얻는다.
  > 작업이 완료될 때 까지 기다린다.
- `지연 완료 - pending Completion` 객체라고도 한다

#### get() - 결과를 가져온다.
오버로딩된 두가지 메서드를 제공한다.
- 계산이 완료될 때까지 기다린 다음에 결과를 검색한다.
  ```java
  V get() throws InterruptedException, ExecutionException;
  ```
- 최대 지정된 시간까지 기다렸다가 사용 가능한 경우 객체를 검색한다.
  ```java
  V get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException,TimeoutException;
  ```

예시
```java
ExecutorService executorService = Executors.newFixedThreadPool(10);

Callable<String> callable = () -> {
    Thread.sleep(2000L);
    return "Callable done";
};

Future<String> future = executorService.submit(callable);
System.out.println("Get result"); // blocking call - 약 2초 후 결과를 가져온다.
String result = future.get();
System.out.println(result);

executorService.shutdown();
```
- "Get result"가 출력된 후 약 2초후 Future에서 반환한 "Callable done"가 출력된다.

#### isDone(), isCancelled() - 작업 상태 확인하기
- `isDone`은 작업이 안료되면 true를 반환 그렇지 않으면 false
  ```java
  boolean isDone();
  ```
- `isCancelled` 착업이 완료된 경우 true를 반환하고, 작업이 정상적으로 종료되거나 예외 또는 취소된 경우도 true를 반환한다.
  ```java
  boolean isCancelled();
  ```

#### cancel(boolean mayInterruptIfRunning) - 작업취소하기
: 해당 작업을 취소하려 할 떄 사용한다.
```java
boolean cancel(boolean mayInterruptIfRunning);
```
- 작업이 완료되었거나, 취소할 수 없는 경우에 false를 반환한다.
- 성공적으로 취소했으면, true 아니면 false을 반환한다.
- 작업이 이미 완료되었거나, 취소되었거나, 다른 이유로 취소할 수 없는 경우에는 false를 반환한다.

## ExecuterService의 invokeAll과 invokeAny
> 여러개의 동시 Callable작업에 대한 처리를 담당하지만 어떤 차이점이 있을까?
### invokeAll() - 모든 Future목록을 반환한다.
: 태스크를 실행하고 모두 완료되거나 시간 초과가 만료될 때, 상태 및 결과를 저장하고 있는 `Future`목록을 반환한다.
```java
<T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks) throws InterruptedException;

<T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks, long timeout, TimeUnit unit)
throws InterruptedException;
```
- 이 작업이 진행되는 동안 현재 컬렉션이 수정되면 메서드의 결과가 정의되지 않는다.
- 동시에 실행한 작업중에 가장 오래걸리는 작업만큼 시간이 소요된다.

예시
```java
ExecutorService executorService = Executors.newFixedThreadPool(10);

Callable<String> callable1 = () -> {
    Thread.sleep(1000L);
    return "Java";
};
Callable<String> callable2 = () -> {
    Thread.sleep(2000L);
    return "Spring";
};
Callable<String> callable3 = () -> {
    Thread.sleep(1500L);
    return "JPA";
};
List<Future<String>> futures = executorService.invokeAll(Arrays.asList(callable1, callable2, callable3));

for(Future<String> f : futures){
    System.out.println(f.get());
}

executorService.shutdown();
```
- 약 2초를 기다린 후 가장 작업이 빨리 끝난 순서대로 "Java", "JPA", "Spring"이 출력 되었다.

### invokeAny
: 가장 먼저 완료된 작업의 결과를 바로 반환한다.
```java
<T> T invokeAny(Collection<? extends Callable<T>> tasks)throws InterruptedException, ExecutionException;

<T> T invokeAny(Collection<? extends Callable<T>> tasks, long timeout, TimeUnit unit) 
throws InterruptedException, ExecutionException, TimeoutException;
```
- 이 작업이 진행되는 동안 지정된 컬렉션이 수정되면 이 메서드의 결과가 정의되지 않는다.
- 동시에 실행한 작업중에 제일 짧게 걸리는 작업만큼 시간이 걸린다.
- 이 또한 블록킹 콜

에시
```java
ExecutorService executorService = Executors.newFixedThreadPool(10);

Callable<String> callable1 = () -> {
    Thread.sleep(1000L);
    return "Java";
};

Callable<String> callable2 = () -> {
    Thread.sleep(2000L);
    return "Spring";
};

Callable<String> callable3 = () -> {
    Thread.sleep(1500L);
    return "JPA";
};

String future = executorService.invokeAny(Arrays.asList(callable1, callable2, callable3));
System.out.println(future);

executorService.shutdown();
```
- 대략 1초를 기다리고 가장 먼저 완료된 작업의 결과("Java")가 바로 반환된다.