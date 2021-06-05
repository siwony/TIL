# Singleton Pattern
: 어떠한 클래스(객체)가 유일하게 1개만 존재해야 할때 사용하는 패턴  
즉, 어떤 클래스가 최초 한번만 메모리를 할당하고(Static) 그 메모리에 객체를 만들어 사용하는 디자인 패턴
- 싱글톤으로 생성된 객체는 무조건 한번 생성으로 전역성을 띄기에 다른 객체와 공유가 용이 
- 객체 생성을 제활용 할 수 있어 불필요한 메모리 낭비를 방지한다.
- Spring에서 Bean은 기본적으로 Singleton으로 관리를한다.
- 현실세계에서 프린터, 개발에서는 TCP Socket connet등에 자주 사용한다.

### 문제점
- 전역성을 띄면서 다른 객체와 공동으로 사용할때만 효율적이다
- 싱글톤으로 만든 객체의 역할이 복잡해지면 해당 싱글톤 객체를 사용하는 다른 객체간의 결함도가 높아진다.
    > 즉, OCP(Open-Close Principle)에 위반된다.
- 싱글톤 객체를 수정할 경우 싱글톤 객체를 사용하는 곳에서 사이드 이팩트 발생 확률이 존재한다.
- 멀티 쓰래드환경에서 동기화 처리 문제가 일어날 수 있다.

### Singleton 구현 방법
Reference: https://elfinlas.github.io/2019/09/23/java-singleton/  

#### static block
```java
public class ExampleClass {
    //Instance
    private static ExampleClass instance;

    //private construct
    private ExampleClass() {}

    static {
        try { instance = new ExampleClass();}
        catch(Exception e) { throw new RuntimeException("Create instace fail. error msg = " + e.getMessage() ); }
    }

    public static ExampleClass getInstance() {
        return instance;
    }
}
```
- static 블럭을 사용힐 경우 클래스가 로딩될 때 한번만 실행을 하게 되는 특성을 사용한 방법
- 인스턴스가 사용되는 시점이 아닌 클래스 로딩 시점에 실행이 된다.

#### lazy init
>static 방법을 개선하여 클래스 로딩 시점이 아닌 인스턴스가 필요하여 요청할 때 생성되는 형태로 작성 
```java
public class ExampleClass {
    //Instance
    private static ExampleClass instance;

    //private construct
    private ExampleClass() {}

    public static ExampleClass getInstance() {
        if (instance == null) { instance = new ExampleClass();}
        return instance;
    }
}
```
- 멀티 쓰레드 환경에서 취약
- 쓰레드가 동시에 getInstance() 메서드를 호출하게 되면 인스턴스가 두 번 생성되는 문제가 발생한다.

#### Thread safe + lazy
```java
public class ExampleClass {
    //Instance
    private static ExampleClass instance;

    //private construct
    private ExampleClass() {}

    public static synchronized ExampleClass getInstance() {
        if (instance == null) { instance = new ExampleClass();}
        return instance;
    }
}
```
- synchronized 키워드를 통해쓰레드에서 동시 접근에 대한 문제를 해결했다.
- synchronized 키워드는 성능 저하를 발생시킨다.

#### Holder
> 현제 JAVA Singleton 생성에서 사용하는 대표적인 방법이다.
```java
public class ExampleClass {

    //private construct
    private ExampleClass() {}

    private static class InnerInstanceClazz() {
        private static final ExampleClass instance = new ExampleClass();
    }

    public static ExampleClass getInstance() {
        return InnerInstanceClazz.instance;
    }
```
- JVM의 클래스 로더 메커니즘과 클래스의 로드 시점을 이용하여 내부 클래스를 통해 생성 시킴으로써 쓰레드 간의 동기화 문제를 해결한다.

