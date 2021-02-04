# IOC(Inversion Of Control)
: 제어권이 역전되었다.  
>어떤 객체가 사용할 객체(의존관계인 객체)를 직접 선언하여 사용하는 것이 아니라,  
>어떤 방법을 사용하여(ex.생성자 등..)사용하여 주입 받아 사용것 을 IOC의 일부라고 표현 할 수 있다.

**일번적인 제어권**: 자기가 사용할 의존성은 자기가 만들어서 사용
```java
@Service
public class CarService {
	private CarRepository carRepository = new CarRepository();
}
```


**DI(Dependency Injection)를 통한 IOC**
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
### DI는 IOC의 한 중류이지 IOC와 같지 않다.
**게임을 예시로 들어보자**
1. 게임컨트롤러가 게임 캐릭터를 조종한다.
2. 게임 캐릭터가 해야 할 일을 플에이어가 직접적으로 관여해 조종한다.
3. 게임 캐릭터의 제어권은 플레이어에게 넘어감 -> 제어권이 위임되었다 -> 제어의 역전(IOC)

### 결국 핵심?
개발자가 빈을 직접 만들지 않고 메타데이터(ex. xml)를 제공하면 프로그램(Spring framework)가 제어를 한다.