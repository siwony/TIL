# Bean
: `Spring IOC(Inversion Of Control)`컨테이너가 관리하는 JAVA객체  
- Spring에서 POJO(plain, old java object)를 ‘Beans’라고 부른다.
- Beans는 애플리케이션의 핵심을 이루는 객체
- Spring IoC(Inversion of Control) 컨테이너에 의해 **인스턴스화**, **관리**, **생성**된다.

### Bean Scope
- Spring은 기본적으로 모든 bean을 singleton으로 생성하여 관리한다.
    - 애플리케이션 구동 시 JVM 안에서 스프링이 bean마다 하나의 객체를 생성하는 것을 의미
    - Spring을 통해서 bean을 제공받으면 언제나 주입받은 bean은 동일한 객체라는 가정하에서 개발한다.
- request, session, global session의 Scope는 일반 Spring 어플리케이션이 아닌, Spring MVC Web Application에서만 사용된다.  
<img width=550px src=./img/spring-bean-scope-table.png>

### &nbsp;Singleton
- **singleton bean**은 Spring 컨테이너에서 한 번 생성되고 프로그램이 종료될때 bean이 한다.
- 생성된 하나의 인스턴스는 single beans cache에 저장되고, 해당 bean에 대한 요청과 참조가 있으면 캐시된 객체를 반환한다.
- 기본적으로 모든 bean은 scope이 명시적으로 지정되지 않으면 singleton이다.
- XML 설정  
    `<bean id="..." class="..." scope="singleton"></bean>`
- annotation 설정  
    대상 클래스에 `@Scope("singletone")`
<img width=650px src=./img/spring-bean-singleton.png>

### Prototype
- `prototype bean`은 모든 요청에서 새로운 객체를 생성하는 것
- 의존성 관계의 bean에 주입 될 때 새로운 객체가 생성되어 주입된다.
- XML 설정
    ```XML
    <bean id="..." class="..." scope="prototype"></bean>
    ```
- annotation  
    대상 클래스에 `@Scope("prototype")`
<img width=650px src=./img/spring-bean-prototype.png>

### Bean 등록 방법
### &nbsp;XML (Spring)
: `applicationContext.xml`이라는 파일을 `src/main/resources` 폴더에 추가시킨 후 bean을 등록한다.
> Java 코드를 이용한 Context 설정이 나오기 전 사용하던 방법이다.
- class(필수): 정규화된 자바 클래스 이름
- id: bean의 고유 식별자
- scope: 객체의 범위 (sigleton, prototype)
- constructor-arg: 생성 시 생성자에 전달할 인수
- property: 생성 시 bean setter에 전달할 인수
- init method와 destroy method
```XML
<!-- A simple bean definition -->
<bean id="..." class="..."></bean>

<!-- A bean definition with scope-->
<bean id="..." class="..." scope="singleton"></bean>

<!-- A bean definition with property -->
<bean id="..." class="...">
	<property name="message" value="Hello World!"/>
</bean>

<!-- A bean definition with initialization method -->
<bean id="..." class="..." init-method="..."></bean>
```
### &nbsp;Java Configuration 
: `@Configuration`이라는 Annotation을 이용하여 XML 대신 Java로 Bean을 생성할 수 있다.
```java
@Configuration
public class ApplicationConfig {
    @Bean
    public Car car(Engine e) {
    	Car c = new Car();
    	c.setEngine(e);
    	return c;
    }
	
    @Bean
    public Engine engine() {
    	return new Engine();
    }
}
```
1. 위 코드처럼 class에 `@Configuration`을 달고
2. Bean으로 사용할 객체를 반환하는 메소드를 만들고
3. `@Bean`이라는 어노테이션을 달면 반환된 객체가 Bean Container에 등록된다.

```java
public class ApplicationContextExam03 {
    public static void main(String[] args) {
	    // 클래스를 매개변수로 넣는다.
	    ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		
	    Car car = ac.getBean(Car.class);
	    car.run();
    }
}
```
### &nbsp;@ComponentScan
: Config 클래스에 `@Configuration`과 `@ComponentScan`을 같이 등록하면, 패키지 내의 `@Bean`, `@Component` , `@Controller`, `@Service`, `@Repository`로 등록된 클래스를 Classpath Scanning 타임에 Bean Container에 등록시켜 준다.

**등록방법**  
`@Configuration`을 이용하여 Bean 설정 파일(XML 파일을 대체하는)임을 알려주고, `@ComponentScan`을 이용해 빈으로 등록되기 위한 annotaction이 부여된 클래스들을 자동으로 IoC컨테이너에 등록한다.  
&nbsp;  
`ApplicationConfig`
```java
@Configuration
@ComponentScan
public class ApplicationConfig {}
```
`Application`
```java
public class Application {
    public static void main(String[] args) {
        ApplicationContext context = new AnnotationConfigApplicationContext(ApplicationConfig.class);
    }
}
```
Annotaion을 기반으로 Bean들을 등록하기 위해서는 `AnnotaionConfigApplicationContext`를 이용해야 한다.  
그리하여 `AnnotationConfigApplicationContext`의 매개변수로 Bean설정 클래스인 `ApplicationConfig`를 넘겨주었다.  

**범위**
- `basePackages`의 경우 괄호안에 직접 패키지경로를 직접 적어주어 스캔할 위치를 지정할 수 있다
```java
@Configuration
@ComponentScan(basePackages = "com.mins.spring")
public class ApplicationConfig {}
```
이 경우 **typesafe하지 않아** 조금만 철자가 잘못되더라도 scan을 못하는 오류가 나타날 수 있다.

- `basePackageClasses` 의 경우에는 괄호안에 적힌 Class가 위치한 곳에서부터 모든 어노테이션이 부여된 Class를 bean으로 등록해준다.
```java
@Configuration
@ComponentScan(basePackageClasses = Application.class)
public class ApplicationConfig {}
```
class를 통해 기입하기 때문에 훨씬 **Typesafe한 방법이다.**