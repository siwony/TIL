# 가변인수 - varages
// todo heap pollution

- Java5에서 추가되었다.
- 한 매서드에 하나만 사용할 수 있고 인수들의 맨 마지막에 위치해야 한다.
  > 가변 인수가 여러개 필요하다면 빌더를 통해 가변인수를 사용한다.

```java
public class A{
    
    public int addAllNums(int... numbers){
        return Arrays.stream(numbers).sum();
    }
}
```