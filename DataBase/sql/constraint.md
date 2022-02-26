# 제약조건
- `데이터 무결성 유지`를 위해 사용자가 지정할 수 있는 성질
- 모든 제약조건은 데이터 사전에 저장된다.
  > 의미있는 이름을 부여했다면 constraint를 쉽게 참조할 수 있다.
- 테이블 생성 당시 지정할 수 있고, 테이블 생성 후  ALTER명령어를 통해 추가 가능하다.
- NOT NULL 제약조건은 반드시 컬럼 레벨에서만 가능하다.

### 1. NOT NULL 조건
무조건 해당 컬럼에 데이터를 입력해야 한다.

```sql
CREATE TABLE STUDENT(
    stu_name VARCHAR(10) NOT NULL
)

or....


CREATE TABLE STUDENT(
    stu_name VARCHAR(10) CONSTRAINT stu_name_not_null NOT NULL
)
```

### 2. UNIQUE 조건
- 데이터의 `유일성`을 보장한다.
- 자동으로 인덱스가 생성된다.

```sql

```

### 3. CHECK 조건

### 4. DEFAULT 지정

### 5. PRIMARY KEY 지정

### 6. FOREIGN KEY 지정