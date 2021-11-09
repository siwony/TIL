# 리플렉션 - Reflection

#### Spring, Hibernate 그리고 Jackson라이브러리는 어떻게 작동할까?
Spring은 Annotatino을 통해 , Hibarnate는 Entity클래스의 정보를 통한 Poxy를 이용해 지연 로딩을 하고, Jackson라이브러리는 `Getter/Setter`를 활용해 직렬화를 구현한다.   
이러한 것을 가능하게 하는 기술을 `리플렉션 - Reflection`이라는 기술이다. 리플렉션을 이용해 필드의 값을 가져오거나, 객체를 동적으로 생성하는 등 클래스를 동적으로 다룬다. 이 글은 Java진영에서 자주 사용하는 프레임워크, 라이브러리를 꿰뚫는 기술에 대한 TIL이다.

## 리플렉션
: 이미 로딩이 완료된 클래스에서 또 다른 클래스를 동적으로 로딩(Dynamic Loading)하여 생성자(Constructor), 멤버 필드(Member Variables) 그리고 멤버 메서드(Member Method) 등을 사용할 수 있도록 한다.
- 구체적인 클래스 타입을 알지 못해도 그 클래스의 구성요소를 접근할 수 있다.

#### 구체적인 클래스 타입을 알지 못할때가 언제일까?
'내 코드인데 어떻게 클래스 타입을 모를수가 있지?' 라는 의문점을 품을 수 있다. 하지만 이는 관점을 프레임워크의 입장이 되어 생각해보면 이해가 쉽게 가능하다.

Spring 프레임워크의 어노테이션 같은 기능들이 리플렉션을 통해 프로그램 실행중 동적으로 클래스 정보를 가져와 사용한다. 하지만 Spring 프레임워크 입장에서는 어느 객체를 다룰지 모르는데 클래스의 정보를 알 수 있을까?
객체의 모든 타입은 Object를 상속받고 있다. A라는 객체는 Object타입으로 담을 수 있지만 A가 가지고 있는 메서드와 필드는 사용할 수 없다.

하지만 리플렉션을 사용한다면 해당 객체의 타입을 몰라도 필드와 메서드를 사용할 수 있고 객체의 정보를 가져오는 등 런타임 시점에 동적으로 객체를 다룰 수 있다.


## 기초적인 사용방법
리플렉션의 첫 시작은 `Class<?>`라는 API를 사용하게 될 것이다. [공식문서](https://docs.oracle.com/javase/8/docs/api/java/lang/Class.html)  

다음은 클래스와 이미 생성된 객체의 `Class<?>`객체를 가져오는 코드의 예시다.
```java
// Book이라는 Type의 Class객체를 가져오는 방법
Class<Book> bookClass = Book.class;

// 이미 생성된 객체의 Class객체를 가져오는 방법
Book book = new Book();
Class<? extends Book> aClass = book.getClass();

// 클래스 이름으로 가져오는 방법 Class.forName함수의 인수로 FQCN를 넘겨준다.
```

다음과 같이 FQCN로 `Class<?>`를 생성할 수 있다.
```java
Class<?> bookClass = Class.forName("com.ex.Book");
System.out.println("aClass1.getName() = " + aClass1.getName()); // com.ex.Book 출력
```
- 위와 같은 방식은 클래스를 찾지못하면 `ClassNotFoundException`를 발생시킨다.
- 해당 방법을 사용하는 대표적인 에시는 JDBC

#### 사전준비
> 패키지 이름은 `com.ex`가 기준
1. Book 클래스 생성
   ```java

    public class Book {

        private static String a = "author";
        private static final String b = "isbn";
        private String c = "title";
        public int d = 10000;
        protected String e = "a";

        public Book(){}
        public Book(String c, int d, String e) {
            this.c = c;
            this.d = d;
            this.e = e;
        }

        private void methodA(){
            System.out.println("methodA");
        }
        public void methodB(){
            System.out.println("methodB");
        }
    }
   ```
2. MyInterface 생성
   ```java
   public interface MyInterface {}
   ```
3. MyBook 클래스 생성 &rarr; Book클래스 상속 &rarr; MyInterface구현
   ```java
   public class MyBook extends Book implements MyInterface {}
   ```

### 클래스 정보 가져오기
#### 필드 가져오기
**`getFields()` - public 필드만 가져온다.**
```java
Class<Book> bookClass = Book.class;
Field[] bookFields = bookClass.getFields();

Arrays.stream(bookFields).forEach(System.out::println); // 필드를 출력하는 예시
```
출력
```sh
public int com.ex.Book.d
```
---

**`getFields()` - 모든 필드를 가져온다.**
```java
...
Field[] bookFields = bookClass.getFields();
Arrays.stream(bookFields).forEach(System.out::println);
```
출력
```sh
private static java.lang.String com.ex.Book.a
private static final java.lang.String com.ex.Book.b
private java.lang.String com.ex.Book.c
public int com.ex.Book.d
protected java.lang.String com.ex.Book.e
```
---

**필드의 값 가저오기**
```java
Class<Book> bookClass = Book.class;
Field[] bookFields = bookClass.getDeclaredFields();
Book book = new Book();

Arrays.stream(bookFields).forEach(field -> {
    try {
        field.setAccessible(true); // access level에 상관없이 field를 가저오는 방법 
        Object value = field.get(book);
        System.out.println(field + " = " + value + "\n");
    } catch (IllegalAccessException e) { 
        // 만약 field.setAccessible(false); 면 해당 예외가 발생한다.
        e.printStackTrace();
    }
});
```
출력
```java
private static java.lang.String com.ex.Book.a = author

private static final java.lang.String com.ex.Book.b = isbn

private java.lang.String com.ex.Book.c = title

public int com.ex.Book.d = 10000

protected java.lang.String com.ex.Book.e = a
```

위 예제들을 통해 알 수 있는 점은 

#### 메서드 가져오기
```java
Class<Book> bookClass = Book.class;
Arrays.stream(bookClass.getDeclaredMethods()).forEach(System.out::println);
```
출력
```sh
public void com.ex.Book.methodB()
public final native void java.lang.Object.wait(long) throws java.lang.InterruptedException
public final void java.lang.Object.wait(long,int) throws java.lang.InterruptedException
public final void java.lang.Object.wait() throws java.lang.InterruptedException
public boolean java.lang.Object.equals(java.lang.Object)
public java.lang.String java.lang.Object.toString()
public native int java.lang.Object.hashCode()
public final native java.lang.Class java.lang.Object.getClass()
public final native void java.lang.Object.notify()
public final native void java.lang.Object.notifyAll()
```
- public인 `methodB()`뿐만 아니라 Object에 있는 method도 함께 가져왔다.
---

**해당 클래스에 있는 method만 가져오기**
```java
Class<Book> bookClass = Book.class;
Arrays.stream(bookClass.getDeclaredMethods()).forEach(System.out::println);
```
출력
```sh
private void com.ex.Book.methodA();
public void com.ex.Book.methodB();
```
- 이번에는 Book클래스에만 있는 모든 클래스를 가져왔다.

**invoke - 메서드 실행하기**
```java
Class<Book> bookClass = Book.class;
Book book = new Book();

Arrays.stream(bookClass.getDeclaredMethods()).forEach(
        method -> {
            try {
                method.setAccessible(true); // private에도 접근할 수 있게함
                method.invoke(book, null);
            } catch (IllegalAccessException | InvocationTargetException e) {
                e.printStackTrace();
            }
        }
);
```
- invoke의 첫 인자로 해당 클래스의 인스턴스가 들어가고 두번째 인자부터 해당 매서드의 파라미터 값을 넣는다.

#### 해당 클래스의 인터페이스와 super클래스를 가져오는 방법
```java
Class<Book> bookClass = Book.class;
Class<? super Book> superclass = bookClass.getSuperclass();
System.out.println("superclass = " + superclass);

Class<MyBook> myBook = MyBook.class;
Arrays.stream(myBook.getInterfaces()).forEach(System.out::println);
```
출력
```sh
superclass = class java.lang.Object
interface com.ex.MyInterface
```


그 밖에... 여러가지 기능들을 사용할 수 있다. API가 너무 많기때문에 여기서 생갹하겠다. 나중에 필요할 떄 더 정리할 예정

### Reflection의 주의사항
- 지나친 사용은 성능 문제를 야기할 수 있다.
- 컴파일 시점이 아닌 런타임 시점에 발생하는 문제를 만들 수 있다.
- 접근 지시자를 무시할 수 있다.

