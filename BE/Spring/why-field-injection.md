# @Autowired를 이용한 필드주입 보다 생성자 주입을 해야하는가?
### 요약
- [**순환참조 오류의 방지**](#순환참조-오류의-방지)
    - 순환 참조가 발생하는 경우 애플리케이션이 구동되지 않는다.
- **테스트 코드 작성의 편리**
    - 단순 POJO를 이용한 테스트 코드를 만들 수 있다.
- **좀더 좋은코드를 작성할 수 있다.**
- **immutable 하다.**
    - 실행 중에 객체가 변하는 것을 막을 수 있다.  
    - 오류를 사전에 방지할 수 있다.

### 순환참조 오류의 방지
개발을 하다보면 보통 여러 컴포넌트간의 의존성이 생긴다.  
그중에서도 A가 B를 참조하고, B가 다시 A를 참조하는 순환 참조도 발생할 수 있다.  

**ex) 순환참조의 예**  
```java
@Service
public class MadPlayService {

    // 순환 참조
    @Autowired
    private MadLifeService madLifeService;

    public void sayMadPlay() {
        madLifeService.sayMadLife();
    }
}

@Service
public class MadLifeService {
    
    // 순환 참조
    @Autowired
    private MadPlayService madPlayService;

    public void sayMadLife() {
        madPlayService.sayMadPlay();
    }
}
```
다음과 같은 코드는 서로가 서로를 참조 하고있다.  
다음과 같이 ``CommandLineRunner`` 실험을 하면
```java
@SpringBootApplication
public class DemoApplication implements CommandLineRunner {

    @Autowired
    private MadLifeService madLifeService;
    @Autowired
    private MadPlayService madPlayService;

    @Override
    public void run(String... args) {
        madPlayService.sayMadPlay();
        madLifeService.sayMadLife();
    }

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
```
구동은 정상적으로 되었지만 그 이후 run method 에서 실행을 하는 과정에서 에러가 생겼다.
```java
java.lang.StackOverflowError: null
	at com.example.demo.GreetService.sayGreet(GreetService.java:12) ~[classes/:na]
	at com.example.demo.HelloService.sayHello(HelloService.java:12) ~[classes/:na]
	at com.example.demo.GreetService.sayGreet(GreetService.java:12) ~[classes/:na]
	at com.example.demo.HelloService.sayHello(HelloService.java:12) ~[classes/:na]
	at com.example.demo.GreetService.sayGreet(GreetService.java:12) ~[classes/:na]
```
즉 코드를 실행하기 전까지 오류가 발견되지 않는다는것이다.  
다음은 생성자 주입을 통한 Injection 이다.

```java
@Service
public class MadPlayService {
    private final MadLifeService madLifeService;

    public MadPlayService(MadLifeService madLifeService) {
        this.madLifeService = madLifeService;
    }

    // 생략
}

@Service
public class MadLifeService {
    private final MadPlayService madPlayService;

    public MadLifeService(MadPlayService madPlayService) {
        this.madPlayService = madPlayService;
    }

    // 생략
}

```
실행결과는 ``BeanCurrentlyInCreationException``이 발생하여 애플리케이션이 구동조차 되지 않는다.
```java
Description:
The dependencies of some of the beans in the application context form a cycle:
┌─────┐
|  madLifeService defined in file [~~~/MadLifeService.class]
↑     ↓
|  madPlayService defined in file [~~~/MadPlayService.class]
└─────┘
```
실행결과의 차이가 나는이유는 생성자 주입 방법은 필드 주입이나 수정자 주입과는 빈을 주입하는 순서가 다르다.