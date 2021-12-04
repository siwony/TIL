# 클래스 기반의 프록시 생성 방법
ByteBuddy와 CGlib로 class기반 생성을 할 수 있다.

#### 주의사항
이 두가지 모두 상속을 이용한 Proxy객체를 만든다.  
그러므로 **`final` 클래스 혹은 기본 생성자가 private라면 proxy를 만들 수 없다.** 

이전 글 예제를 기반으로 작성 [이전글](dynamic-proxy.md)
## CGlib
공식 위키: https://github.com/cglib/cglib/wiki
#### 의존성 추가
https://mvnrepository.com/artifact/cglib/cglib

### 간단한 사용예제
```java
MethodInterceptor handler = new MethodInterceptor() {
    @Override
    public Object intercept(Object o, Method method, Object[] args, MethodProxy methodProxy) throws Throwable {
        BookService bookService = new BookService();
        if(method.getName().equals("rent")) {
            System.out.println("AAAAAAA");
            Object returnResult = method.invoke(bookService, args);
            System.out.println("BBBBBBB");
            return returnResult;
        }

        return method.invoke(bookService, args);
    }
};

BookService bookService = (BookService) Enhancer.create(
        BookService.class,
        handler
);

Book book = new Book("스프링");
bookService.rent(book);
bookService.returnBook(book);
```
출력결과
```
AAAAAAA
rent: 스프링
BBBBBBB
return book: 스프링
```
- rent method만 다르게 출력되는 것을 볼 수 있다.


## ByteBuddy
공식 사이트: https://bytebuddy.net
#### 의존성 추가
https://mvnrepository.com/artifact/net.bytebuddy/byte-buddy

### 간단한 사용예제
```java
Class<? extends BookService> proxyBookService = new ByteBuddy().subclass(BookService.class) // BookService의 subclass 생성 선언
        .method(ElementMatchers.named("rent")).intercept(InvocationHandlerAdapter.of(new InvocationHandler() { // rent라는 이름을 가진 메서드에 대한 헨들링을 한다.
            BookService bookService = new BookService();
            @Override
            public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                System.out.println("AAAAAA");
                Object resultOfRentMethod = method.invoke(bookService, args);
                System.out.println("BBBBBB");
                return resultOfRentMethod;
            }
        }))
        .make()
        .load(BookService.class.getClassLoader()).getLoaded();// BookService를 로드한 클래스 로더에서 로딩된 결과를 가지고 온다.

BookService bookService = proxyBookService.getConstructor(null).newInstance();

Book book = new Book("스프링");
bookService.rent(book);
bookService.returnBook(book);
```

#### 출력결과
```
AAAAAA
rent: 스프링
BBBBBB
return book: 스프링
```
