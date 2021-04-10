# Strategy Pattern(전략 패턴)
: 여러 알고리즘을 하나의 추상적인 접근점을 만들어 접근 점에서 서로 교환 가능하도록 하는 패턴
- 위임(Delegate)을 통해 의존성을 역전시킬 수 있고, 인터페이스를 통해 다형성의 특성으로 변경에 대해 유연한 대처가 가능하다.
- 인터페이스를 상속받는 구상 클래스가 너무 많아질 수도 있다.

### Delegate(위임)
: 위임이란 '어떤 메서드의 처리를 다른 인스턴스의 메서드에 맡긴다' 라는 의미이다.
> 즉, 클라이언트 코드에서 구성(composite)하고 있는 참조 객체를 통해 메서드를 호출하는 것(delegation)을 말한다.
- 다른 객체의 기능을 수행할때 Delegate라고 부른다.
```java
public class GameCharacter{
    //접근점
    private Weapon weapon;

    // 무기 교환 가능
    public void setWeapon(Weapon weapon){
        this.weapon = weapon;
    }

    public void attack(){
        //Delegate(델리게이트)
        weapon.attack();
    }
}
```
공격(attack)이라는 기능을 내가 어떤 weapon을 가지고 있느냐에 따라서 달라진다.  
나(GameCharacter.attack)는 어떻게 공격하는지 모른다. weapon이 알아서 할것이다.

### 전략 패턴을 적용하지 않은예
Reference : https://dongdd.tistory.com/165  
<img width=450px src=./img/ex-strategy-not-use.png>

```java
public interface Movable {
    public void move();
}
public class Train implements Movable{
    public void move(){
        System.out.println("선로를 통해 이동");
    }
}
public class Bus implements Movable{
    public void move(){
        System.out.println("도로를 통해 이동");
    }
}
public class Client {
    public static void main(String args[]){
        Movable train = new Train();
        Movable bus = new Bus();

        train.move();
        bus.move();
    }
}
```
- 기차는 선로를 따라 이동한다.
- 버스는 도로를 따라 이동한다.  

그러나 시간이 흘러 선로를 따라 움직이는 버스가 개발이 되어버렸다.  
&rarr; 그러면 Bus의 `move()`를 다음과 같이 변경하면 끝난다.
```java
public void move(){
    System.out.println("선로를 따라 이동");
}
```
하지만 이렇게 수정하는 방식은 **SOLID의 OCP(Open-Closed Principle)에 위배된다.**  
### 위 코드의 문제점
- **SOLID의 OCP에 위반된다.**
- 나중에 지금과 같은방식의 변경은 시스템이 확장되었을때 유지보수를 어렵게 한다.
- 나중에 선로를 따라 옴직이는 이동수단이 생기면 `move()`를 모두다 정의해야한다.
- 같은 메서드를 여러 클래스에서 똑같이 정의하고 있다. &rarr; 메서드의 중복

### Strategy Pattern의 적용
**전략 정의**
```java
public interface MovableStrategy {
    public void move();
}
public class LoadStrategy implements MovableStrategy {
    @Override
    public void move() {
        System.out.println("도로를 통해 이동");
    }
}
public class RailLoadStrategy implements MovableStrategy {
    @Override
    public void move() {
        System.out.println("선로를 통해 이동");
    }
}
```

**운송수단 선언**
```java
public class Moving {
    private MovableStrategy movableStrategy;

    public void move() {
        movableStrategy.move();
    }

    public void setMovableStrategy(MovableStrategy movableStrategy) {
        this.movableStrategy = movableStrategy;
    }
}
public class Bus extends Moving {}
public class Train extends Moving {}
```

**결과**
```java
public class Client {
    public static void main(String[] args) {
        Moving train = new Train();
        Moving bus = new Bus();

        train.setMovableStrategy(new RailLoadStrategy());
        bus.setMovableStrategy(new LoadStrategy());

        train.move();
        bus.move();


        /** rail load bus development*/
        bus.setMovableStrategy(new RailLoadStrategy());
        bus.move();
    }
}
```
위와 같이 운송수단(train, bus)을 움직일 것인지 `setMovableStrategy()`로 `LoadStrategy` 혹은 `RailLoadStrategy` 객체를 이용하여 변경한다.