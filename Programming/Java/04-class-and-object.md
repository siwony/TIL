## Class
**객체를 생성하기 위해 그 객체가 어떤 데이터를 갖고 어떤 연산을 하는지에 대해 정의**    
> ex) 붕어빵(Object)를 찍어내는 붕어빵틀(Class)
### 구조
```java
class car{
    //필드(Field)
    String name;
    int num;

    //메서드(Method)
    String getName(){
        return this.name
    }

    //생성자(constructer)
    //객체가 인스턴스화 될때 제일 먼저 실행된다.
    Car(){} // 기본 생성자
    car(String name, int num){
        this.name = name  //this는 car 클래스의 필드 변수인 name
        this.num = num;
    }
}
```
### 상속
**부모가 가진것을 자식에게 물려주는 것**
```java
    public class Car{
        String color;
        String name;
        
        public void run(){
            System.out.println("run")
        }
    }

    public class Bus extends Car{
        color = "red"
    }
```
- 부모 클래스가 가지고 있는 것(field, method)을 상속받아 사용한다.
### super와 부모생성자
**객체가 생성될때 부모의 생성자부터 실행된다.**
```java
public class Car{
    public Car(){
        System.out.println("Car의 기본생성자입니다.");
    }
}

public class Bus extends Car{
    public Bus(){
        System.out.println("Bus의 기본생성자입니다.");
    }
}
```
- 객체를 생성하면 Bus객체가 메모리에 올라갈떄 Car객체도 함께 올라간다.
- 생성자가 호출될때 자동으로 부보의 생성자가 호출되면서 부모객체를 초기화 한다. 
- Bus 객체를 생성시 console 에 다음과 같이 출력된다  
    ``Car의 기본생성자입니다.``   
    ``Bus의 기본생성자입니다.``

**super**
- 부모를 가르키는 키워드
- super() 는 부모의 생성자를 의미
- 부모의 생성자를 임의로 호출하지 않으면, 부모 class의 기본 생성자가 자동으로 호출

### 메서드
### **오버로딩**
- 이름은 같지만 매개변수가 다른 메소드
```java
class MyClass2{
    public int plus(int x, int y){
        return x+y;
    }

    public int plus(int x, int y, int z){
        return x + y + z;
    }

    public String plus(String x, String y){
        return x + y;
    }
}
```
### **오버라이딩**  
부모가 가지고 있는 메소드와 똑같은 모양의 메소드를 자식이 가지고 있는것,   
**즉 메소드를 재정의**
```java
    public class Car{
        public void run(){
            System.out.println("Car의 run메소드");
        }
    }

    //Car 를 상속받는 Bus 클래스 
    public class Bus extends Car{}
    public class BusExam{
        public static void main(String args[]){
            Bus bus = new Bus();
            bus.run();  //Car의 run메소드가 실행된다. 
        }
    }
```
- 메소드를 오버라이드 하면, 항상 자식클래스에서 정의된 메소드가 출력
```java
    public class Bus extends Car{
        @Overried //오버라이드 했다는것을 명시해주는 어너테이션 매개변수가 다르면 에러표시
        public void run(){
            **super.run();**  // 부모의  run()메소드를 호출 
            System.out.println("Bus의 run메소드");
        }
    }
```

### 접근제한자
**public**
>어떤 클래스든 접근할 수 있는것

**protected**
>상속받은 자식 클래스에서는 접근 가능

**private**
>자기 자신만 접근 가능

**default**
>자기자신과 같은 패키지에서 접근 가능

### 클래스 형변환
- 부모타입으로 자식객체를 참조하게 되면 부모가 가지고 있는 메소드만 사용가능
- 자식객체가 가지고 있는 메소드나 속성을 사용하고 싶다면 형변환 해야함
- 부모타입으로 자식객체를 참조할 수 있다.
```java
    public class Car{
        public void run(){
            System.out.println("Car의 run메소드");
        }
    }

    public class Bus extends Car{
        public void ppangppang(){
            System.out.println("빵빵.");
        }   
    }

    public class BusExam{
        public static void main(String args[]){
            Car car = new Bus();
            car.run();
            //car.ppangppang(); // 컴파일 오류 발생

            Bus bus = (Bus)car;  //부모타입을 자식타입으로 형변환 
            bus.run();
            bus.ppangppang();
        }
    }
```
- ``ppangppang()``를 참조하고 싶으면 Buse타입의 참조변수로 참조
- 부모타입으로 자식타입의 객체를 참조할 때는 묵시적으로 형변환이 일어난다.
### 추상클래스
- **구체적이지 않은 클래스를 의미**
- abstract 키워드를 사용해서 정의
- 추상 클래스는 미완성의 추상 메소드를 포함가능
- 추상 클래스는 인스턴스를 생성할 수 없다.
```java
public abstract class Bird{
    public abstract void sing();

    public void fly(){
        System.out.println("날다.");
    }
}
```
- 추상 클래스를 상속받은 클래스는 추상 클래스가 갖고 있는 추상 메소드를 반드시 구현함
- 추상 클래스를 상속받고, 추상 클래스가 갖고 있는 추상 메소드를 구현하지 않으면 해당 클래스도 추상 클래스가 된다.
```java
public class Duck extends Bird{
    @Override
    public void sing() {
        System.out.println("꽥꽥!!");
    }
}
```

## Object
### 객체 생성
```java
Car car = new car();
Car car = new car(1);
```
- new 연산자로 객체를 생성한다 즉 인스턴스한다

## String
**인스턴스 생성방법**
```java
Stirng str1 = "hello"
Stirng str2 = "hello"
```
- str1 == str2 true
- str1이 참조하는 인스턴스를 str2도 참조
```java
String str3 = new String("hello");
String str4 = new String("hello");
```
- str3, str4는 다른 인스턴스를 참조함