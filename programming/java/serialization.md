# 직렬화 - Serializable
> [Java Object Serialization Spec](https://docs.oracle.com/javase/8/docs/platform/serialization/spec/serialTOC.html)

직렬화의 정의는 [여기](../../cs/data-serialization.md)를 참고해주길 바란다.

자바에서의 직렬화는 다음과 같이 [Serializable](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/io/Serializable.html) 인터페이스를 구현하게 된다. 

```java
public class Animal implements Serializable{
    ...
}
```

#### 대표적인 Serializable 구현체
- Vector
- HashMap
- ArrayList
- JPA 표준 스펙의 Entity

### 1. 직렬화가 가능한 객체의 조건
1. 기본형 타입 - Primitive Type
2. Serializable 인터페이스를 구현한 객체
3. 직렬화를 진행할 객체의 맴버중에 Serializable 인터페이스가 구현되지 않으면 안된다.
4. `serialVersionUID`가 같은 객체만 가능하다.
   > 클래스가 변경되어도 역직렬화를 하고 싶다면 `serialVersionUID`를 임의로 지정해줘야 한다.

추가적으로 `transient` 키워드가 사용된 맴버는 직렬화 되지 않고 null로 표현된다.