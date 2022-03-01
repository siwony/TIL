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

혹은....


CREATE TABLE STUDENT(
    stu_name VARCHAR(10) CONSTRAINT stu_name_not_null NOT NULL
)
```

### 2. UNIQUE 조건
- 데이터의 `유일성`을 보장한다.
- 자동으로 인덱스가 생성된다.

```sql
ALTER TABLE STUDENT
    ADD CONSTRAINT stu_uk UNIQUE (stu_num)
```
> STUDENT 태이블의 stu_num속성을 UNIQUE 제약조건 생성

### 3. CHECK 조건
: 컬럼의 값을 어떤 특정 범위로 제한할 수 있다.

```sql
ALTER TABLE STUDENT
    ADD CONSTRAINT student_credit_ck_comm
    CHECK (credit >= 0 AND credit <= 30);
```

### 4. DEFAULT 지정
```sql
CREATE TABLE STUDENT(
    ...
    credit DEFAULT 0
);
```

### 5. PRIMARY KEY 지정
: 기본키를 지정한다.
- UNIQUE + NOT NULL
- 인스턴스를 식별하는 역할이며 다른 테이블에서 외래키들이 참조할 수 있는 자격을 가지고 있다.

```sql
CREATE TABLE STUDENT(
    student_number NUMBER CONSTRAINT student_number_pk PRIMARY KEY
)
```

### 6. FOREIGN KEY 지정
: 기본키를 참조하는 컬럼 또는 컬럼들의 집합이다.

```sql
ALTER TABLE STUDENT
```