# 객체와 테이블 매핑
## @Entity
- table과 매핑될 클래스에 `@Entity`가 붙여진다
- `@Entity`가 붙은 클래스는 JPA가 관리한다.

### 주의
- **기본생성자 필수**(public or protected 생성자)
- final class, enum, interface, inner class 사용x
- 저장할 필드에 final x

### 속성
**name**
- JPA에서 사용할 Entity의 이름 지정
- 기본값 : 클래스이름
- 같은 클래스 이름이 없으면 가급적 기본값 사용

### @Table
: Entity를 매핑할 테이블 지정

### 속성
**name**
- 매핑할 테이블 이름
- 기본값 : Entity 이름사용 

**catalog**  
: DB catalog 매핑

**schema**  
: DB schema 매핑

**uniqueConstraints(DDL)**  
: DDL 생성시 unique 제약 조건 생성
