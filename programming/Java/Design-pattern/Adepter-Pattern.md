# Adepter Pattern
: 서로 다른 인터페이스를 가진 두 클래스를 어댑터 클래스로 인터페이스를 통일 시켜 사용하는 방법이다.
- 관계가 없는 인터페이스를 같이 사용이 가능하다.  
    > 재사용성이 증가한다.
- 기존 클라이언트 단의 코드 수정을 최소화 할 수 있다.
- 어댑터 클래스에서 통일 시켜주는 부분을 하나씩 구현해야 한다.

### 기본설계
<img width=550px src=./img/adepter-pattern-diagram.png>

Adaptee 클래스를 Adapter를 통해 Adaptee에 있는기능을 Adapter로 맞게 변환하여 client가 사용할 수 있게 한다.

### Adepter Pattern의 사용예시
Reference: https://www.inflearn.com/course/%EC%9E%90%EB%B0%94-%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4/dashboard  
**요구사항**
- 수에 2배 연산, 1/2 연산을 float로 반환하여 수행하는 객체를 만들어라
- 구현객체의 이름은 Adepter
- Math클래스에는 위와같은 기능을 double로 반환하는 매서드가 정의되어있다.

Math class
```java
public class Math{
    public static double towTime(double num){return num * 2;}
    public static double half(double num){return num / 2;}
}
```

**Adepter Pattern으로 요구사항에 맞게 float로 값을 반환**
```java
//선언과 구현을 분리하기위해 인터페이스 Adepter선언
public interface Adepter{
    public float towTimeToFloat(float num);
    public float halfTOfFloat(float num);
}

public class AdepterImpl implements Adepter{
    @Override
    public float towTimeToFloat(float num){
        return (float) Math.towTime((double)num);
    }

    @Override
    public float halfTOfloat(float num){
        return (float) Math.half((double)num);
    }
}

```
**결과**
```java
public class Main {
    public static void main(String[] args) {
        Adapter adapter = new AdapterImpl();

        //200반환
        System.out.println(adapter.towTimeToFloat(100f));
        //50반환
        System.out.println(adapter.halfTOfFloat(100f));
    }
}
```