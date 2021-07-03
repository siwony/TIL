# 기본키 매핑

### 기본키 매핑 방법
- ### 1. 직접 할당
    **@Id** 만 사용한다.

- ### 2. 자동 생성
    **@Id** 와 **@GeneratedValue**를 사용한다.  
    - [IDENTITY](#IDENTITY-전략) : DB에 위임, MYSQL
    - [SEQUENCE](SEQUENCE-@SequenceGenerator) : DB 시퀀스 오브젝트 사용, ORACLE
        - @SequenceGenerator 필요
    - [TABLE](TABLE-전략): 키 생성용 테이블 사용, 모든 DB에서 사용가능하다
        - @TableGenerator 필요
    - AUTO: 방언에 따라 자동 지정, 기본값

### IDENTITY 전략
: 기본 키 생성을 DB에 위임한다.
- MySQL, PostagreSQL, SQL Server, DB2에서 사용 
    > MySQL은 AUTO_INCREMENT
- AUTO_INCREMENT는 DB `INSERT` SQL을 실행한 이후 ID값을 알 수 있다.
- `em.persis()` 시점에 즉시 `INSERT` SQL 실행하고 DB에서 식별자 조회한다.
    >즉, `INSERT` SQL를 실행할때까지 pk값을 확인 할 수 없다.

### SEQUENCE-@SequenceGenerator
: DB 시퀀스 오브젝트 사용한다.
- 아이디 값을 임의로 넣으면 안된다.
- 영속성 컨텍스트에 값을 저장할때 DB sequence에서 pk값을 가져온다.
    > insert 쿼리는 날라가지 않는다.


**속성**
|속성|설명|기본값|
|---|---|----|
|name|식별자 생성기 이름|필수|
|sequenceName|DB에 등록되어 있는 시퀀스 이름|hibernate_sequence|
|initialValue|DDL 생성 시에만 사용됨, 시퀀스 DDL을 생성할 떄 처음 1 시작하는 수를 지정한다.|1|
|allocationSize|시퀀스 한 번 호출에 증가하는 수 (성능 최적화에 사용, **DB 시퀀스 값이 하나씩 증가하도록 설정되어 있으면 이 값을 반드시 1로 설정해야한다.**)|50|
|catalog, schema| DB catalog, schema 이름||

```java
@Entity
@SequenceGenerator(
    name = "MEMBER_SEQ_GENERATOR",
    sequenceName = "MEMBER_SEQ",
    initialValue = 1, allocationSize = 1)
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,
            generator = "MEMBER_SEQ_GENERTOR")
    privat Long id;
}
```

### TABLE 전략
: 키 생성 전용 테이블을 하나 만들어서 DB 시퀀스를 흉내내는 전략
- 모든 DB에 적용가능하나 성능이 않좋다.
> 걍 사용잘 안한다. 알아만 두자
```sql
create table MY_SEQUENCES (
    sequence_name varcar(255) not null,
    next_val bigint,
    primary key ( sequence_name )
)
```
```java
@Entity
@TableGenerator(
    name = "MEMBER_SEQ_GENERATOR",
    table = "MY_SEQUENCES",
    pkColumnValue = "MEMBER_SEQ", allocationSize = 1)
public class Member {
    
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE,
            generator = "MEMBER_SEQ_GENERATOR")
    private Long id;
}
```
**@TalbeGenerator - 속성**
|속성|설명|기본값|
|---|---|----|
|name|식별자 생성기 이름|필수|
|table|키생성 테이블명|hibernate_sequences|
|pkColumnNmae|시퀀스 컬럼명|sequence_name|
|valueColumnNa|시퀀스 값 컬럼명|next_val|
|pkColumnValue|키로 사용할 값 이름|엔티티 이름|
|initialValue|초기 값, 마지막으로 생성된 값이 기준이다|0|
|allocationSize|시퀀스 한 번 호출에 증가하는 수(성능 최적화에 사용됨)|50|
|catalog, schema| DB catalog, schema 이름||
|uniqueConstraints(DDL)|유니크 제약 조건을 지정할 수 있다.||

### 권장하는 식별자 전략
- **기본 키 제약 조건**
    - null 이 아니다.
    - 유일해야한다.
    - 불변해야 한다.(엄청 어렵다)
- 대체키를 사용한다.(미래까지 이 조건을 만족하는 자연키는 찾기 어렵다.)
- **권장: Long형(10억이 넘어도 동작) + 대체키 + 키 생성전략**

**실무 경험 공유**
- 주민번호를 기본키로 쓰고있었다.
- 나라에서 주민번호를 보관하면 안된다 라고 바뀜
- 문제는 pk가 아니라 pk를 사용하는 fk로 주민번호를 가지고 있을것이다
- 마이그래이션이 엄청나게 난리났다.
- 만약 대체키를 사용했으면 주민등록 테이블을 지우거나 대체했으면 됬었다.