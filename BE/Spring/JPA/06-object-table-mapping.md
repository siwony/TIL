# 객체와 테이블 매핑(annotation)
## @Entity
: 컬럼 매핑
- table과 매핑될 클래스에 `@Entity`가 붙여진다
- `@Entity`가 붙은 클래스는 JPA가 관리한다.

### 주의
- **기본생성자 필수**
  > 접근지정자 `public` or `protected`
- `final class`, `enum`, `interface`, `inner class`를 사용하면 안 된다.
- 저장할 필드에 `final` 키워드는 허용되지 않는다. &rarr; JPA가 Entity를 관리하는데 값이 변경되지 않다면 관리를 할 수 없다.

### 속성
#### 1. name
: `JPA`에서 사용할 `Entity`의 이름 지정
- 기본값 : 클래스이름
- 같은 클래스 이름이 없으면 가급적 기본값 사용

#### 2. insertable, updatable
: 등록, 변경가능 여부
- 기본값 : `true`

#### 3. nullable(DDL)
: null 값의 허용 여부를 설정
- false로 설정하면 `DDL` 생성 시에 `not null` 제약조건이 붙는다.

#### 4. unique(DDL)
: `@Table`의 `uniqueConstraints`와 같지만 한 컬럼에 간단히 유니크 제약조건을 걸때 사용

#### 5. columnDefinition(DDL)
: DB 컬럼 정보를 직접 줄 수 있다.
- 기본값 : 필드의 자바 타입과 방언정보 사용

#### 6. length(DDL)
: 문자 길이 제약조건, String 타입에만 사용
- 기본값 : 255

#### 7. precision, scale(DDL)
: `BigDecimal` 타입 에서 사용
- 기본값 : 
    ```
    precision=19,  
    scale=2
    ```
- `BigDecimal` ,`BigInteger` 사용
- `precision`은 소수점을 포함한 전체 자 릿수를, scale은 소수의 자릿수 다.

## @Table
: `Entity`를 매핑할 테이블 지정

### 속성
#### 1. name
- 매핑할 테이블 이름
- 기본값 : Entity 이름사용 

#### 2. catalog
: `DB catalog` 매핑

#### 3. schema
: `DB schema` 매핑

#### 4. uniqueConstraints(DDL)
: `DDL` 생성 시 `unique` 제약 조건 생성

## @Enumrated
: `enum` 타입 매핑
### 속성
#### 1. EnumType.STRING
: 문자열 자체가 DB에 저장된다.  
> 기본값이 아니여서 지정을 해줘야한다.

#### 2. EnumType.ORDINAL
: `Enum`의 순서값이 DB 저장된다.  
**절대 사용하지 마라!**
## @Temporal
: 날자 타입 매핑

### 속성
**TemporalType.Date**  
: 년-월-일 의 data type

**TemporalType.Time**  
: 시:분:초 의 data type

**TemporalType.TIMESTAMP**  
: 년-월-일 의 date + time 의 timestamp(datetime)

## @Lob
: `BLOB`, `CLOB` 매핑
- 속성이 없다
- `CLOB`: `String`, `char[]`, `java.sql.CLOB``
- `BLOB`: `byte[]`, `java.sql,BLOB`

## Transient
- 필드 매핑을 하지 않을때
- DB 저장 및 조회를 하지 않는다
- 주로 메모리 상에서만 임시로 어떤 값을 보관하고 싶을때 사용한다.