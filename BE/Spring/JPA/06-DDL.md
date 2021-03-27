# DB 스키마 자동생성
- DDL을 애플리케이션 실행 시점에 자동 생성한다.
- 테이블 중심의 개발에서 객체 중심으로 이동한다.
- DB 방언을 활용해서 DB에 맞는 DDL을 생성한다.

### 속성
hibernate.hbm2ddl.auto
|옵션|설명|
|---|---|
|create|기존테이블 삭제 후 다시 생성 (DROP + CREATE)|
|create-drop|create와 같으나 종료시점에 테이블을 DROP한다.|
|update|변경분만 반영(운영DB에 사용하면 안된다.)|
|validate|엔티티와 테이블이 정상 매핑되었는지만 확인|
|none|사용하지 않음|

### 주의사항
- **운영 장비에는 절대 create, create-drop, update 사용하면 절대 안된다.**
- 생성된 DDL은 개발 장비에서만 사용한다.
- 개발 초기 단계 create or update
- 테스트 서버 update or validate
- 스테이징과 운영 서버 validate or none

**결론**  
운영서버에 사용하지 마라 실무에서 사용하다. x 될수도 있다.
> drop the table

### DDL 생성기능
: DDL을 자동 생성할 때만 사용되고 JPA 실행 로직에 영향을 주지 않는다.
- 제약조건 추가: 회원 이름은 필수적이고, 10자를 초과할 수 없으면  
    `@Column(nullalbe = false, length = 10)`
- 유니크 제약조건 추가
    `Table(uniqueConstraints = {@UniqueConstraint( name = "NAME_AGE_UNIQUE", ColumnNames = {"NAME", "AGE"})})