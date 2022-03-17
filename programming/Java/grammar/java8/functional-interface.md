# 함수형 interface
- **추상 메서드가 1개만 있으면 모두 함수형 `interface`이다.**
- 정적(`static`) 메서드, 디폴트(`default`) 메서드가 있을 수 있다.
- SAM(Single Abstract Method)
- `@FunctionalInterface` : Java compiler는 이렇게 명시된 함수형 `interface`에 두 개 이상의 메소드가 선언되면 오류를 발생시킨다.

### Java에서의 함수형 프로그래밍
- 함수를 interface의 First class obejct로 사용할 수 있다.
- 순수함수 (`Pure function`) : 상태가 없는 함수를 말한다. ex) 객체
   - 사이드 이팩트를 만들 수 없다. &rarr; 함수 밖에 있는 값을 변경하지 못한다.
- 고차 함수 (`Higher-Order Function`) : 함수가 함수를 매개변수로 받을 수 있고 함수를 리턴할 수 있다.
- 불변성 

### 함수형 interface의 선언
#### 예시
```java
@FunctionalInterface // 함수형 인터페이스가 아니라면 compile error가 생긴다.
[public] interface RunSomething{

    void doIt(); // 추상 메서드 1개

    //정적 메서드
    static void printName(){
        System.out.println("siwon");
    }

    // 디폴트 메서드
    default void printAge(){
        System.out.println(18);
    }
}
```
### 함수형 interface의 사용
#### 1-1. 익명 클래스
```java
RunSomething r = new RunSomething() {
    @Override
    public void one() {
        System.out.println("siwony");
    }
};

r.one();
```
#### 1-2. lambda
```java
// 한줄일때
RunSomething r = () -> 실행문
r.doIt();

// 2줄이상일때
RunSomething r = () -> {
    실행문1;
    실행문2;
    ...
}
r.doIt();

//매개변수를 받을 때
RunSomething r = number -> 실행문;
r.doIt();

// 매개변수가 2개 이상일때
RunSomething r = (number, ...) -> 실행문;

// 리턴값이 있을때 ex) 두 정수를 더하는 메서드
RunSomething r = (i, j) -> return i + j;
r.doIt(10, 20);
```

## 자바에서 제공하는 함수형 인터페이스
> Java에서는 1.8버전부터 기본적으로 자주 사용할만한 함수형 인터페이스를 제공한다.
- [java.lang.function 패키지](https://url.kr/b295ks) 에 정의 되어있다.

### Function<T, R> 를 통한 람다표현식의 사용
- T 타입을 받아 R 타입을 리턴하는 함수 인터페이스 이다.
- `apply` 함수만 구현하면 된다.
- 다음과 같은 함수 조합용 메서드를 제공한다. 
  - `compose`
  - `andThen`

#### 람다 표현식을 사용하기 전
정수 10에 입력받은 숫자를 더하고 싶다면

1. `Plus10`이라는 클래스에 함수를 만든다. (혹은 그냥 익명함수를 사용할 수 있다.)
```java
public class Plus10 implements Function<Integer, Integer>{
    @Override
    public Integer apply(Integer i){
        return 10 + i;
    }
}
```
2. 객체를 생성해서 사용한다.
```java
public class main{
    public static void main(String[] args){
        Plus10 p10 = new Plus10();
        System.out.println(p10.apply(1)); // 11 출력
    }
}
```
#### 람다 표현식의 사용
```java
public class main{
    public static void main(String[] args){
        Function<Integer, Integer> p10 = (i) -> i + 10;
        System.out.println(p10.apply(1)); // 11 출력
    }
}
```

### 자바에서 제공하는 다양한 함수형 인터페이스
#### UnaryOperator<T>
- `Function<T, R>`의 특수한 형태로, 입력값 하나를 받아 동일한 타입을 리턴한다.
  
#### Consumer<T>
: `T` 타입을 받아 아무값도 리턴하지 않는 함수 인터페이스
- 함수 조합용 메서드를 제공한다.
    - `andThen`

사용예시
```java
Consumer<Integer> printT = (i) -> System.out.println(i);
printT.accept(1); // 1출력

//위 코드랑 똑같은 동작을 한다.
Consumer<Integer> printT = System.out::println; 
printT.accept(1); // 1출력
```
#### BiFunction<T, U, R>
- 두 개의 값(`T`, `U`)를 받아 R 타입을 리턴하는 함수 인터페이스
  - `R apply(T t, U u)`

#### BinaryOperator<T>
   Function<T, U, R>의 특수한 형태로, 동일한 타입의 일렬값 두개를 받아 리턴하는 함수 인터페이스

#### Supplier<T>
- `T` 타입의 값을 제공하는 함수 인터페이스
  - `T get()`;

사용예시
```java
Supplier<Integer> get10 = () -> 10;
System.out.println(get10.get()); // 10 출력
```

#### Predicate<T>
- `T` 타입을 받아서 `boolea`를 반환하는 함수 인터페이스
  - `boolean test(T t)`
- 다음과같은 함수 조합용 메서드를 제공한다.
  - `And`
  - `Or`
  - `Negate`

사용예시
```java
Predicate<Integer> isEven = (i) -> i % 2 == 0;
isEven.test(10) // true
```