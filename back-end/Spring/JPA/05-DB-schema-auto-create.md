# DB schema 자동 생성
- DDL을 애플리케이션 실행 시점에 자동 생성
- 데이블 중심 -> 객체 중심
- DB 방언을 활용해서 DB에 맞는 적절한 DDL 생성
- **생성된 DDL은 개발 장비에서만 사용한다.**

### 속성
`hibernate.hbm2ddl.auto`
|옵션|설명|
|---|---|
|create|기존테이블 삭제 후 다시생성 (DROP + CREATE)|
|create-drop|create와 같으나 종료시점에 테이블 DROP|
|update|변경분만 반영|
|validate|Entity와 Table이 정상 매핑되었는지만 확인|
|none|사용하지 않음(기본값)|

### 주의사항
- **운영 장비에 절대 create, create-drop, update 사용하면 안된다.**
- 개발 초기 : create or update
- 테스트 서버 : update or validate
- 스테이징, 운영서버 : validate or none