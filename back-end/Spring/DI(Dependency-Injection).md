# DI(Dependency Injection, 의존성 주입)
## 의존성 주입이란?  
: 어떤 객체가 사용하는 의존객체를 직접 만들어서 사용하는것이 아니라 주입받아 사용하는 방법  
>즉 클래스안에 new 연산자가 들어가 있지 않고 외부에서 객체를 주입해주는것
## 의존성?
```java
public class PetOwner{
    private AnimalType animal;

    public PetOwner() {
        this.animal = new Dog();
    }
}
```
- PetOwner 객체는 AnimalType 객체(Dog)에 의존한다.  
    - PetOwner 생성자에서 <code>new Dog();</code>를 통해 Dog에 의존성을 가짐  
- 의존성이 위험한경우
    - PetOwner 객체의 경우 AnimalType 객체의 생성을 제어하므로 두 객체 간의 사이의 긴말한 결합(tight coupling)이 생기고,  
    AnimalType 객체를 변경하면 PetOwner도 함꼐 변경됨  
    즉, 하나의 모듈이 바뀌면 의존한 다른 모듈까지 변경된다.
    - Unit test 작성이 어려워진다.