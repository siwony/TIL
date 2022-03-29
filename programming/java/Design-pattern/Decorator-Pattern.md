# Decorator Pattern
: 객체의 결합 을 통해 기능을 동적으로 유연하게 확장 할 수 있게 해주는 패턴
- 기본 뼈대(클래스)는 유지하되, 이후 필요한 형태로 꾸밀 때 사용한다.
- 확장의 필요한 경우 상속의 대안으로 사용한다
- SOLID에 OCP, DIP를 따른다.

### Decorator Pattern 테이블
<img width=450px src=./img/decorator-pattern-table.png>

### Decorator Pattern의 적용
#### 요구사항
- ICar interface를 상속받아 Audi차를 여러모댈로 나눠 만들어라
- ICar에는 `getPrice()`, `showCost()` 가 선언되어있다.

### 1. Decorator Pattern의 적용 전
#### 선언과 기능의 분리를 위해 ICar 인터페이스 생성
```java
public interface ICar {
    int getPrice();
    void showCost();
}
```

#### Audi 차를 만들기위한 기본 class 생성
```java
public class Audi implements ICar{

    private int cost;

    public Audi(int cost){
        this.cost = cost;
    }

    @Override
    public int getPrice(){
        return this.cost;
    }
    @Override
    public void showCost() {
        System.out.println("Audi Base는 "+cost+" 원 입니다.");
    }
}
```

**결과**
```java
public class main{
    public sstatic void main(String[] args){
        ICar audi = new Audi(1000);
        audi.showPrice(); // 출력: Audi Base는 1000 원 입니다.

    }
}
```
- 우리는 여러 모델의 아우디 Car를 만들어야 된다.
- 여러 모델 class에 바로 ICar를 상속받아 여러 모델의 클래스를 만들수 있지만 Decorator Pattern을 이용여 모델을 추가할 것이다.
- 여러 모델(a3, a4, a5)는 모델값(modelPrice)이 기본값에서 추가된다.

### 1. Decorator Pattern의 적용 후
#### Decorator Pattern을 사용하기 위한 AudiModelDecorator class 만들기
```java
public class AudiModelDecorator implements ICar{

    protected ICar audi;
    protected int modelPrice;

    public AudiModelDecorator(ICar audi){
        this.audi = audi;
    }

    @Override
    public int getPrice() {
        return audi.getPrice();
    }

    @Override
    public void showCost() {
        System.out.println("가격은 "+(audi.getPrice()+modelPrice)+" 만원 입니다");
    }
```

#### 여러 모델class 선언하기
```java
public class A3 implements AudiModelDecorator{

    public A3(ICar audi) {
        super(audi);
        this.modelPrice = 1000;
    }
}

public class A4 extends AudiModelDecorator {
    public A4(ICar audi) {
        super(audi);
        this.modelPrice = 2000;
    }
}

public class A5 extends AudiModelDecorator {

    public A5(ICar audi) {
        super(audi);
        this.modelPrice = 3000;
    }
}
```

#### 결과
```java
public class Main{
    public static void main(){

        ICar audi = new Audi(1000);
        audi.showCost(); // 출력: Audi Base는 1000 원 입니다.

        ICar audi3 = new A3(audi);
        audi3.showCost(); // 출력: A3의 가격은 2000 원 입니다.

        ICar audi4 = new A4(audi);
        audi4.showCost(); // 출력: A4의 가격은 3000 원 입니다.

        ICar audi5 = new A5(audi);
        audi5.showCost(); // 출력: A5의 가격은 4000 원 입니다.
    }
}
```