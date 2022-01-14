# Synchronized 키워드 - 경쟁상태를 해결하는 방법
`synchronized` 키워드는 Multi-Thread 환경에서 여러개의 쓰래드가 하나의 공유 변수에 동시에 접근할 때 경쟁상태 `Race Condition`이 발생하지 않도록 한다.

그러면 어떻게 `Synchronized` 키워드는 경쟁상태를 해결할까?  
그것은 바로 현재 데이터를 사용하고 있는 **해당 스레드를 제외하고 나머지 스레드들은 데이터에 접근 할 수 없도록** 즉, blocking을 사용해 경쟁상태를 해결하고 있다.

하지만 이를 너무 남발하면 성능 이슈가 발생하는데, 프로그래밍 내부적으로 block, unblock작업은 어느정도 공수가 들어가는 작업이다. 꼭 필요할 떄 사용하자.

## Synchronized 키워드 사용방법
### 1. 인스턴스 메서드에 사용하는 방법
```java
class A {
    private int a = 0;

    public synchronized void increaseA(){
        a++;
    }

    public synchronized void decreaseA(){
        a--;
    }
}
```
위에 예시와 같이 메서드 시그니처에 추가하는 방식으로 사용할 수 있다.

#### 주의할 점
여기서 메서드에 synchronized가 붙으니까 메소드 단위로 동기화될 수 있다고 오해할 수 있는데, **해당 방법은 객체 단위로 동기화 된다.** 위 예제를 이용해 설명을 하면, 위에 두 메서드는 동시에 수행될 수 없다.

### 2. 인스턴스 메소드 속 synchronized 블록
위의 방법은 객체별로 lock을 걸었다면 이 방식은 필요한 부분만 `synchronized` 블록을 지정해 필요한 곳 만 지정할 수 있다.
```java
class A {
    private int a = 0;

    public void increaseA(){
        synchronized(this){
            a++;
        }
        
    }

    public void decreaseA(){
        synchronized(this){
            a--
        }
    }
}
```
에제를 보면 synchronized(){} 형식으로 되어있는데 `소괄호()` 안에 있는 락 객체의 다른 스레드의 접근을 차단하겠다는 의미이다.

결국 위에 예제는 1번 예제와 똑같은 상황이 연출되었다.

### 2. 객체 변수에 사용하는 방법