#### 목차
- [JPA 데이터 타입](./) &larr;
- [기본값 타입](./17.1-default-type.md)
- [임베디드 타입](./17.2-embedded-type.md)
- [값 타입과 불변 타입](./17.3-value-and-immutable.md)
- [값 타입의 비교](./17.4-value-type-compare.md)
- [값 타입 컬렉션](./17.5-value-type-collection.md)
- [정리](./17.6-organize.md)

# 값 타입
: 복잡한 객체 세상을 조금이나마 단순화하려고 만든 개념이다. 따라서 값 타입은 단순하고 안전하게 다룰 수 있어야 한다.

## JPA의 테이터 타입 분류
### Entity 타입
- `@Entity`로 정의하는 객체
- 데이터가 변해도 식별자가 지속해서 추적하능하다.
- ex) 회원 엔티티의 키나 나이 값을 변경해도 식별자로 인식가능하다.

### 값 타입
- 자바 기존타입이나 객체 &rarr; int, String 등 단순 값으로 사용하는 자바 객체
- 식별자가 없고 값만 있으므로 변경시 추적 불가하다.
- ex) 숫자 100을 200으로 변경하면 완전히 다른 값으로 대체한다.