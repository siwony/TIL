# IoC(Inversion Of Control) - 제어의 역전
: 객체의 생성, 생명주기의 관리까지 모든 객체에 대한 제어권이 바뀌었다는 것을 의미한다.
- 컴포넌트 의존관계 결정 (Component dependency resolution), 설정(configuration) 및 생명주기(lifecycle)를 해결하기 위한 디자인 패턴(Design Pattern)
>어떤 객체가 사용할 객체(의존관계인 객체)를 직접 선언하여 사용하는 것이 아니라,  
>어떤 방법을 사용하여(ex.생성자 등..)사용하여 주입 받아 사용것 을 IoC의 일부라고 표현 할 수 있다.

**일번적인 제어권**: 자기가 사용할 의존성은 자기가 만들어서 사용
```java
@Service
public class CarService {
	private CarRepository carRepository = new CarRepository();
}
```

## IoC 분류
#### DL - Dependency Lookup
: 저장소에 저장되어 있는 Bean에 접근하기 위해 컨테이너가 제공하는 API를 이용하여 Bean을 Lookup하는 것 이다.

#### DI - Dependency Injection
: 각 클래스간의 의존관계를 빈 설정(Bean Definition)정보를 바탕으로 컨테이너가 자동으로 연결해 주는 것 이다.

DI의 분류
- Setter Injection
- Constructor Injection
- Method Injection  

<img width=500px src=./img/DI-DL.png>

### Dependency Injection를 통한 IoC
```java
@Service
public class CarService {
	
    // CarRepository를 사용은 하지만 만들지는 않는다.
	private CarRepository carRepository;
    /*
    생성자를 통해서 받아온다.
    따라서 의존성을 관리하는 일은 CarService가 하는 일이아니다. 누군가 밖에서 해주는 것이다.
    */
    //생성자를 통한 의존성 주입 
    public CarService(CarRepository carRepository){
    	this.carRepository = carRepository;
    }
}
```
### "DI는 IoC를 구현하는 방법의 한 종류"
**게임을 예시로 들어보자**
1. 플레이어가 게임 캐릭터를 조종한다.
2. 게임 캐릭터가 해야 할 일(퀘스트 등..)을 플레이어가 직접적으로 관여해 조종한다.
3. 게임 캐릭터의 제어권은 플레이어(외부)에게 넘어감 -> 제어권이 위임되었다 -> 제어의 역전(IoC)

## IoC Container
: Spring Framework는 **객체에 대한 생성 및 생명주기를 관리** 할 수 있는 기능을 제공한다.
- 객체의 생성을 책임지고, 의존성을 관리
- POJO의 생성, 초기화, 서비스, 소멸에 대한 권한을 가진다
- 객체 생성에 대한 제어권을 IoC Container에 넘긴다.

### 구성요소

#### 1. BeanFactory
- **Bean 등록, 생성, 조회, 반환 관리**
- IoC Container의 최상단에 interface로 존재한다.
- **보통 BeanFactory를 바로 사용하지 않고, 이를 확장한 `ApplicationContext`를 사용한다.**

#### 2. ApplicationContext
- `BeanFactory`와 Bean을 등록, 생성, 조회, 반환 을 관리하는 기능은 같다.
- `BeanFactory`의 서브 인터페이스인 `ListableBeanFactory`, `HierachicalBeanFactory`라는 인터페이스를 상속하여 `BeanFactory`를 상속하고 있다.
- Spring의 각종 부가 서비스를 추가로 제공한다.  
    - `ResourceLoaderAware`의 `ResourceLoader` (편리한 리소스 조회)
        > 로컬, 개발, 운영등을 구분해서 
    - `ApplicationEventPublisherAware`의 `ApllicationEventPublicher` (이벤트발행/구독 모델 지원)
    - `MessageSourceAware`의 `MessageSource` (메시지소스를 활용한 국제화(i18n) 기능)
    - `ApllicatonContextAware`의 `ApllicationContext`
    - `EnviornmentCapable` (환경변수)
        > 로컬 개발, 운영등을 구분해서 처리 `Profile`
- Spring이 제공하는 `ApplicationContext` 구현 클래스가 여러 종류가 있다.

## IoC의 핵심은?
개발자가 Bean을 직접 만들지 않고 xml, annotation과 같은 메타데이터를 제공하면 프로그램(Spring framework)이 해당 메타데이터를 사용해 Bean객체를 제어한다.  

**즉, `IoC Container`는 `Spring Framework`이라고 할 수 있고, 이는 Spring Framwork를 사용하는 이유이자 핵심 \기능이다.**