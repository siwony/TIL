# POJO(Plain Old JAVA Object)
: 오래된 방식의 간단한 자바 오브젝트  
**"특정 <U>'기술'</U>에 종속되어 동작하는 것이 아닌 순수한 자바 객체를 말한다."**
- 자바 오브젝트 모델, 컨벤션 혹은 프레임워크를 따르지 않는 Java오브젝트를 나타낸다.

### 등장 배경  
- 특정 기술(EJB 등..)과 외부 환경에 종속되어 의존하게 된 자바 코드는 가독성이 떨어져 유지보수에 어려움이 생긴다.
- 특정 기술의 클래스를 상속받거나, 특정 기술을 직접 의존하게 되어 확장성이 매우 떨어지는 단점이 있다.
- 대표적인 객체지향 프로그래밍 언어의 자바가 객체지향 설계의 점들을 잃어버리게 되버린다 

&rarr; 이러한 것들을 보완하기 위해 **POJO라는 개념이 나오게 되었다.**

### 특징
- 특정 규약에 종속되지 않는다.
    >객채지향 설계를 할 수 있게된다.
- 특정 환경에 종속되지 않는다
    > test코드를 작성하기 좋다.

### 정의
POJO는 Java 언어 규약에 의해 강제된 것 이외의 제한에 구속되지 않는 Java 오브젝트 이므로   

**다음과 같은 클래스는 POJO에 위배된다.**
1. 미리 지정된 클래스를 extends 하는 것
   ```java
   public class Foo extends javax.servlet.http.HttpServlet { ... }
   ```
2. 미리 정의된 인터페이스를 implements 하는 것.
   ```java
   public class Bar implements javax.ejb.EntityBean { ... }
   ```
3. 미리 정의된 Annotation을 포함하는 것.
   ```java
   @javax.persistence.Entity
   public class Baz { ... }
   ```

하지만 기술적인 어려움 및 다른 이유로 인해 여러 프레임워크는 POJO에 규정된 Annotation을 사용하고,  
그것을 `POJO Compliant - POJO를 준수하는 객체` 라고 한다.

이는 Annotation을 추가하기 전에 POJO이고 Annotation을 제거했을 때, POJO 상태로 되돌아간다면 POJO라고 할 수 있다.
> 예시로 Hibernate의 Entity 객체를 들 수 있다.

### 대표적인 POJO Framework
**Spring**, **Hibernate**  
- 위 프레임워크는 객체지향적인 설계를 하고있다. 또한 POJO를 지향한다.
- 개발자가 서비스 로직에 집중하고 POJO로 쉽게 개발하는것을 지원하고 있다.

### POJO를 지키기 위해 개발 하기전 다시한번 생각해보자
- 자신의 코드에 if/else, switch가 난무하지 않는가?
- 책임과 역활이 다른 코드가 하나의 클래스에 다 들어가 있지 않은가?
- 절차지향적으로 한 개 파일에 모든 코드를 넣고 있지 않는가
- 내가 만든 객체를 재사용 가능한가?

#### [Java Beans](java-beans.md)
- POJO의 변형이라 볼 수 있다.
- POJO보다 더 세부적인 규약이 정해져 있고 이를 지켜야 한다.
- `Serializable` 마커 인터페이스(실제 구현이 없고 단순히 확인을 할 수 있는)를 implement한다.