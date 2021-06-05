# Proxy Pattern
: Proxy Class를 통해 대신 전달 하는 형태로 설계되며, 실제 Client는 Proxy로 부터 결과를 받는다.
> Proxy: 대리인 이라는 뜻, 뭔가를 대신하여 처리하는것
- Cache의 기능으로 활용이 가능하다
- SOLID에 OCP, DIP의 원칙을 따른다.
- AOP Pattern을 구현할 수 있다.

### 특징
- 대리자는 실제 서비스와 같은 이름의 메서드를 구현한다. 이때 인터페이스를 사용한다.
- 대리자는 실제 서비스에 대한 참조 변수를 갖는다(합성)
- 대리자는 실제 서비스의 같은 이름을 가진 메서드를 호출하고 그 값을 클라이언트에게 돌려준다.
- 대리자는 실제 서비스의 메서드 호출 전후에도 별도의 로직을 수행할 수도 있다.

### Proxy Pattern 테이블
<img width=450px src=./img/proxy-pattern.png>

1. 클라이언트가 어떤 일에 대한 요청(RealSubject의 request()메서드 호출)하면
2. Proxy가 대신 RealSubject의 request()메서드 호출 및 클라이언트에 반환한다.

## Proxy Pattern 예시
### Proxy Pattern 적용 전
**요구사항**
1. Browser는 url을 통해 Html을 반환한다.
2. 사용자는 Browser에 show() 이용해 Html을 반환받는다.

**선언과 기능을 분리 하기위한 IBrowser선언**
```java
public interface IBrowser {
    public void show();
}
```
**Browser에서 반환될 Html 선언**
```java
public class Html{

    private String url;
    
    public Html(String url){
        this.url = url;
    }
}
```
**Browser**
```java
public class BrowserImpl implements IBrowser{
 
    private String url;
     
    public BrowserImpl(String url){
        this.url = url;
    }

    @Override
    public Html show(){
        System.out.println("Browser loading html from : "+ url)
        return new Html(url);
    }
 
}
```
**결과**
```java
public class main{
    public static void main(){
        IBrowser browser = new BrowserImpl("naver.com");
        browser.show();  // Browser loading html from naver.com 출력
        browser.show();  // Browser loading html from naver.com 출력
        browser.show();  // Browser loading html from naver.com 출력
        browser.show();  // Browser loading html from naver.com 출력
    }
}
```
- `show()`를 호출할때마다 Html 객체가 새롭게 생성된다.
- 즉 같은 페이지를 계속적으로 새롭게 호출한다. &rarr; 비효율적이다.

### Proxy Pattern로 Cache 구현
**Browser의 역활을 대신하는 BrowserProxy class 선언**
```java
public class BrowserProxy implements IBrowser{

    private String url;
    private Html html;

    public BrowserProxy(String url){
        this.url = url;
    }

    @Override
    public Html show(){
        
        if(html == null){
            this.html = new Html(url);
            System.out.println("BrowserProxy loading html from : " + url);
        }
        System.out.println("BrowserProxy use cache html from " + url);
        return html;
        
    }
}

```

**결과**
```java
public class main{
    public static void main(){
        IBrowser browser = new BrowserProxy("naver.com");
        browser.show();  // BrowserProxy loading html from naver.com 출력
        browser.show();  // BrowserProxy use cache html from naver.com 출력
        browser.show();  // BrowserProxy use cache html from naver.com 출력
        browser.show();  // BrowserProxy use cache html from naver.com 출력
    }
}
```