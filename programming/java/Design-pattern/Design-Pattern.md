# 디자인 패턴
: 자주 사용하는 설계 패턴을 정형화하여 이를 유형별로 가장 최적의 방법으로 개발을 할 수 있도록 정해둔 설계
> 알고리즘과 유사하지만 명확하게 정답이 있는것은 아니며 프로젝트 상황에 맞게 적용가능하다.

### 장점
- 개발자(설계자) 간의 원활한 소통
- 소프트웨어 구조 파악 용이
- 재사용을 통한개발 시간 단축
- 설계 변경 요청에 대한 유연한 대처

### GOF(Gang Of Four)디자인 패턴
: 객체지향 개념에 따른 설계중 재사용할 경우 유용한 설계를 디자인 패턴으로 정리해 놓은것
> 소프트웨어를 설계 할 때는 기존에 경험이 중요하다. 그러나 모든 사람이 다양한 경험을 가질 수 없다.
- 총 23개의 디자인패턴
- 이를 이해하여 잘 활용한다면 경험이 부족하더라도 좋은 소프트웨어 설계가 가능하다.

### 생성 패턴
: 객체를 생성하는 것과 관련된 패턴이다.
- 객체의 생성과 변경이 전체 시스템에 미치는 영향을 최소화한다.
- 코드의 유연성을 높여준다.

#### 생성패턴의 종류
- [Singleton](./Singleton-Pattern.md)
- Prototype
- Builder
- Abstract Factory
- Chaining

### 구조 패턴
: 프로그램 내 자료구조, 인터페이스 구조 등 프로그램을 설계하는데 활용 될 수 있는 패턴
- 클래스 객체들의 구성을 통해 더 큰 구조를 만들 수 있게 해준다.
- 복잡한 구조를 개발/유지보수 를(을) 쉽게 만들어준다.

#### 구조패턴의 종류
- [Adapter](./Adepter-Pattern.md)
- Composite
- Bridge
- [Decorator](./Decorator-Pattern.md)
- Facade
- FlyWeight
- [Proxy](./Proxy-Pattern.md)

### 행위 패턴
: 반복적으로 사용되는 객체들의 상호작용을 패턴화한 패턴
- 클래스나 객체들이 상호작용 및 책임을 분산 하는 방법을 제공한다.
- 독립적으로 일을 처리하고자 할 때 사용한다.

#### 행위패턴의 종류
- Template Method
- Interpreter
- Iterator
- [Observer](./Observer-Pattern.md)
- [Strategy](./Strategy-Pattern.md)
- Visitor
- Chain of Responsibility
- Command
- Mediator
- State
- Memento