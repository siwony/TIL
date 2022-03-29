# 다이나믹 프록시 - Dynamic Proxy
런타임에 특정 인터페이스들을 구현하는 클래스 또는 인스턴스를 만드는 기술
- [공식문서](https://docs.oracle.com/javase/8/docs/technotes/guides/reflection/proxy.html)

### Proxy 패턴을 정적으로 개발자가 직접 구현 시 단점
- 부가적인 기능을 추가할 때 마다 별도의 Proxy를 만들어야 한다.
- 위임하는 코드가 중복해서 발생할 수 있다.


#### 다이나믹 프록시 사용처
- Spring Data JPA
- Spring AOP
- Mockito
- Hibernate lazy initialization

#### 단점
- Class기반 Proxy를 만들 수 없다.
- 코드의 유연성이 떨어진다.

## 사용 예제
#### 클래스 구조
- `Book`, `BookService`와 이를 구현하고 있는 `DefaultBookService` 가 있다.
```java
public class Book {

    private String title;
    public Book() {}

    public Book(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}

public interface BookService {

    void rent(Book book);
    void returnBook(Book book);
}

public class DefaultBookService implements BookService{
    
    @Override
    public void rent(Book book) {
        System.out.println("rent: " + book.getTitle());
    }

        @Override
    public void returnBook(Book book) {
        System.out.println("return: " + book.getTitle());
    }
}
```
### 동적으로 Proxy를 생성
> Proxy.newProxyInstance(ClassLoader, Class<?>[], InvocationHandler)
1. 첫 번째 인자로 해당 Class를 불러온 `ClassLoader`를 넘겨준다.
2. 두 번째 인자로 Proxy를 만들 객체의 interface를 Class 배열로 넘겨준다.
3. 세 번째 인자로 이 Proxy의 메서드가 호출이 될 때 어떻게 처리해야 할지에 대한 설명을 넘겨준다.


```java
    BookService bookService = (BookService) Proxy.newProxyInstance(
            BookService.class.getClassLoader(), // BookService를 불러온 class loader
            new Class[]{BookService.class}, // 어떤 interface의 Proxy 타입
            new InvocationHandler() { // method 타입을 어떻게 처리할 것 인지 정의
                BookService bookService = new DefaultBookService();

                @Override
                public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                    System.out.println("AAAA");
                    Object invokeValue = method.invoke(bookService, args);
                    System.out.println("BBBB");
                    return invokeValue;
                }
            }
    );
```

#### Java의 다이나믹 프록시의 단점
첫 번째로 자바에서 제공하는 동적 프록시는 **유연하지 않다.**
> 메서드별로 다르게 적용하려고 하면 코드가 엄청 커진다.
    
만약 `DefaultBookService`의 `rent`메서드만 따로 다르게 출력하고 싶다면 다음과 같은 방식으로 해야 한다.
```java
    BookService bookService = (BookService) Proxy.newPoxyInstance(
    BookService.class.getClassLoader(), // BookService를 불러온 class loader
    new Class[]{BookService.class}, // 어떤 interface의 Proxy 타입
    new InvocationHandler() { // method 타입을 어떻게 처리할 것 인지 정의
        BookService bookService = new DefaultBookService();

        @Override
        public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            if(method.getName().equals("rent"));{
                System.out.println("AAAA");
                Object invokeValue = method.invoke(bookService, args);
                System.out.println("BBBB");
                return invokeValuer
            }


            return method.invoke(bookService, args);
        }
    }
);
```
결국 proxy 클래스를 만들지 않는 수고를 덜 수 있지만 유연하지 않아 확장성이 떨어져 코드가 복잡하고 커지게 된다.

두 번째는 **class기반의 프록시를 만들 수 없다.**  
> class기반의 프록시를 만드는 방법은 `ByteBuddy`와 `CGlib`로 만들 수 있다

[다음글 class기반의 프록시 생성방법](class-base-proxy)