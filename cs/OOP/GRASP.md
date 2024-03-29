# GRASP
: General Responsibility Assignment Software Patterns의 약자로 "일반적인 책임 할당 소프트웨어 패턴" 이다.
> GRASP는 상호작용하는 Object에 어떻게 Responsibilities를 할당하는 지에 대한 내용을 담고 있다고 할 수 있다.
- Object-Oriented 디자인의 핵심은 각 객체에 책임을 부여하는 것.
- 책임을 부여하는 원칙들을 말하고 있는 패턴.
- 구체적인 구조는 없지만, 철학을 배울 수 있다.
- 총 9가지의 원칙을 가지고 있다.

### GOF와 GRASP의 차이점
> 이 둘은 비교할 수 없지만 헷갈려서 정리해본다.
- GOF는 디자인 패턴이지만, GRASP는 디자인 원칙이다.
  > 디자인 원칙은 디자인 패턴보다 추상적이다.

## GRASP를 알기전에 알아야 할 것!
### 모듈화(Modularity)
: System을 Module들로 나누고 Components 간에 책임을 할당하는 것이다.
> Modularity가 바로 Design의 목표라고 할 수 있다.

#### 모듈화의 이점
- 개발자의 입장에서 복잡도가 줄어들게 된다.
    > Module 사이에 작고 간단하고 잘 정의된 interface가 존재하며,  
    > 비슷한 기능을 하는 그룹이 묶여 한 모듈에 정의가 되면 복잡도가 줄어든다.

#### 모듈화의 측정방법
Coupling(결합력), Cohesion(응집력)이 있다.  
자세한 내용은 [여기](./OOP.md#결합력(coupling)) 참고

## GRASP의 9가지 원칙
### 1. Information Expert
> 객체지향의 기본 원리 중에 하나이다.

: 책임을 수행할 수 있는 데이터를 가지고 있는 객체에 책임을 부여하는 것이다.
- 객체는 데이터와 처리로직이 함께 묶여있는 것이다.
- 정보 은닉을 통해 자신의 데이터를 감추고 오직 Method로만 데이터를 처리하고, 외부에는 그 기능(책임)만을 제공한다.
- 역할을 수행할 수 있는 정보, 계산 된 필드 등의 책임을 위임 할 위치를 결정하는데 사용되는 원칙이다.

#### 책임을 할당하는 방법
1. 책임을 할당하는 일반적인 방법은 주어진 책임을 확인한다.
2. 이행하는 데 필요한 정보를 결정한 다음 해당 정보가 저장되는 위치를 결정한 후
3. 그것을 이행하는 데 필요한 가장 많은 정보를 가지고 있는 Class가 책임을 진다.

객체는 데이터와 처리로직이 함께 묶여 있으며 자신의 데이터를 감추고자 하면 오직 자기 자신의 처리 로직에서만 데이터를 처리하고,   
외부에는 그 기능(역할)만을 제공하게 된다.

### 2. Creator
: 객체의 생성은 생성되는 객체의 컨텍스트를 알고 있는 다른 객체가 있다면, 컨텍스트를 알고 있는 객체에 부여한다.

- Factory Pattern과 관련되어있다.

#### 예시 - A 객체와 B 객체의 관계가 다음 중 하나라면 A의 생성을 B의 책임로 부여한다.
- B 객체가 A 객체를 포함하고 있다.
- B 객체가 A 객체의 정보를 기록하고 있다.
- A 객체가 B 객체의 일부이다.
- B 객체가 A 객체를 긴밀하게 사용하고 있다.
- B 객체가 A 객체의 생성에 필요한 정보를 가지고 있다.

### 3. Controller
: 시스템 이벤트(사용자의 요청)를 처리할 객체를 만들어 사용하는 것이다.
> 시스템, 서브시스템으로 들어오는 외부 요청을 처리하는 객체를 만들어 사용하라

- 시스템 이벤트를 처리하는 책임을 전체 시스템 또는 사용 사례 시나리오를 나타내는 non-UI 클래스에 할당한다.
- 컨트롤러는 수행해야 할 작업을 다른 객체에 위임해야 한다.
- 활동을 조정하거나 통제해야 하지만 컨트롤러 자체가 많은 일을 해서는 안된다.

#### 어떤 서브시스템안에 있는 각 객체의 기능을 직접 사용한다면?
- 서브시스템과 외부간의 coupling이 증가한다.
- 서브시스템의 객체를 수정할 경우, 외부에 주는 충격이 크다.

#### Controller객체를 사용한다면?
서브시스템을 사용하는 입장에서 보면, Controller 객체만 알고 있으면 되므로 사용하기 쉽다.

> #### 서브시스템
> : 시스템을 구성하는 요소의 하나로, 그 자체로도 시스템을 형성하고 있는 것.   
> 시스템이 커지면, 내부를 다시 작은 시스템으로 나누어 생각하는 편이 설계나 관리상으로도 용이하기 때문에 서브시스템이 존재한다.

### 4. Low Coupling
> Object-Oriented 시스템은 각 객체들과 그들 간의 상호작용을 통하여 요구사항을 충족시키는 것을 기본으로 한다.  
> 그러므로, 각 객체들 사이에 Coupling이 존재하지 않을 수는 없다.
- 객체들간, 서브 시스템들간의 상호의존도가 낮게 책임을 부여한다.
- 한 클래스의 변화가 다른 클래스에 미치는 영향이 낮다.

#### 장점
- 서브시스템의 재사용성이 높아진다.
- 시스템 관리가 편해진다.

### 5. High cohesion
: 각 객체가 밀접하게 연관된 역할들만 가지도록 역할을 부여하는 것이다.
- 한 객체, 한 시스템이 자기 자신이 부여받은 책임만을 수행하도록 짜임새 있게 구성되어 있다면 자연스럽게 Low Coupling이 된다.

### 6. Polymorphism(다형성)
: 객체의 종류에 따라 행동양식이 바뀌면, 객체의 종류를 체크하는 조건문을 사용하지 말고 polymorphism(다형성) 기능을 사용하는 것이다.
- Object-Oriented 시스템은 상속과 Polymorphism(다형성)을 지원한다.

### 7. Pure Fabrication
: 도메인에 관련된 문제를 대표하는 것이 아니라면 기능적인 책임을 별도로 한 곳으로 관리하는 객체를 만들자.

#### 어느상황에서 사용하는 것일까?
- Information Expert 패턴을 적용하여 Low Coupling과 High Cohesion의 원칙이 깨질때
  - 데이터베이스 정보를 저장하거나, 로그 정보를 기록하는 책임에 대해 생각해 보자. 각 정보는 각각의 객체들이 가지고 있을 것이다.
  - 이 때 Information Expert 패턴을 적용하면, 각 객체들이 정보를 저장하고, 로그를 기록하는 역할을 담당해야 하지만, 실제로 그렇게 사용하는 사람들은 없다.
  - 이것은 그 기능들이 시스템 전반적으로 사용되고 있기 때문에 각 객체에 그 기능을 부여하는 것은 각 객체들이 특정 데이터베이스에 종속을 가져오거나, 로그을 기록하는 매커니즘을 수정할 경우, 모든 객체를 수정해야 하는 결과를 가져온다.
  - 즉 Low Coupling의 원칙이 깨지게 된다.
- 이러한 상황에서 공통적인 기능을 제공하는 역할을 한 곳으로 모아서 가상의 객체, 서브시스템을 만들어야하는데 
- 이러한 종류의 클래스는 도메인 중심 설계에서 DDD서비스라고 불린다.

### 8. Indirection
: 두 객체 사이의 직접적인 Coupling을 피하고 싶으면, 그 사이에 다른 매개체(ex. 객체)를 통해 전달하는 것 이다.
- 주로 Interface인 경우가 많다.
  > 그런 경우는 Protected Variations 패턴이라 부를 수 있다.

### 9. Protected Variations
: 변경될 여지가 있는 곳에 안정된 인터페이스를 정의해서 사용하는 것이다.
#### 예시 - JDBC
- JDBC는 일련의 인터페이스들로 구성되어 있으며, 각 데이터베이스 벤더들이 인터페이스를 구현한 Concrete 클래스를 제공하고 있다.
- Driver를 로딩하는 코드를 제외하고는 모두 인터페이스를 사용함으로서 데이터베이스 변경시 Driver 로딩만 바꾸어 주면 되도록 데이터베이스 관련 작업이 필요한 곳에는 안정된 JDBC 인터페이스를 사용한다.



## 마무리
정리를 해보니 객체지향 설계원칙 SOLID에 일부분 관련이 있었다. 그리고 코드 리펙토링을 진행할 떄 필요한 내용이다. 앞으로 기초를 더욱 단단히 다져보자!

> #### 출처
> - Ssabae.log: https://velog.io/@lsb156/GRASP-object-oriented-design
> - nesoy blog: https://nesoy.github.io/articles/2019-05/GRASP-Pattern
> - 호롱이네 tistory: https://jjungyooni.tistory.com/entry/GRASP-PATTERN