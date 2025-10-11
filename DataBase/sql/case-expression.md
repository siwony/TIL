---
layout: post
author: "정시원"
title: "CASE 표현"
categories: DataBase
date: 2022-03-02
tags: [sql]
---

# CASE 표현
IF-THEN-ELSE 논리와 유사한 방식으로 표현식을 작성하여 SQL의 비교 연산 기능을 보완하는 역할을 한다.
- CASE 표현은 함수의 성질을 가지고 있어, 다른 함수처럼 중첩해서 사용할 수 있다.

### 간단한 예제
일반 프로그램의 IF-THEN-ELSE-END 로직은 다음과 같다.
```
IF  SAL > 2000
    THEN REVISED_SALARY = SAL
    ELSE REVISED_SALARY = 2000
END-IF.
```
같은 기능을 하는 SQL CASE 표현이다.
```sql
SELECT  ENAME,
        CASE    WHEN    SAL > 2000
                THEN    SAL
                ELSE    2000
        END     AS   REVISED_SALARY
FROM    EMP
```

## 1. CASE 표현의 2가지 방법
IF-THEN-ELSE 논리를 구현하는 CASE Expressions은 `Simple Case Expression`과 `Searched Case Expression` 두 가지 표현법 중에 하나를 선택해서 사용하게 된다.
> Oracle의 경우 DECODE 함수를 사용할 수도 있다.
```sql
CASE
    SIMPLE_CASE_EXPRESSION 조건 or SEARCHED_CASE_EXPRESSION 조건
END
```

### 1-1. SIMPLE_CASE_EXPRESSION 조건
```sql
CASE
    EXPR WHEN COMPARISION_EXPR THEN RETURN_EXPR
    ELSE 표현절
END
```
CASE 다음에 바로 조건에 사용되는 칼럼이나 표현식을 표시하고, 다음 WHEN 절에서 앞에서 정의한 칼럼이나 표현식과 같은지 아닌지 판단하는 문장으로 `EQUL - =` 조건만 사용한다.

`SEARCHED_CASE_EXPRESSION`보다 간단하게 사용할 수 있다.

#### 예시
부서 정보에서 부서 위치를 미국의 동부, 중부, 서부로 구분하라.
```sql
SELECT  LOC,
  CASE  LOC
  WHEN  'NEW YORK'  THEN 'EAST'
  WHEN  'BOSTON'    THEN 'EAST'
  WHEN  'CHICAGO'   THEN 'CENTER'
  WHEN  'DALLAS'    THEN 'CENTER'
  ELSE  'ETC'
  END   as  AREA
FROM    DEPT;
```

### 1-2. SEARCHED_CASE_EXPRESSION 조건
```sql
CASE
    WHEN CONDITION THEN RETURN_EXPR
    ELSE 표현절
END
```
CASE 다음에 칼럼이나 표현식ㅇ을 표현하지 않고, 다음 WHEN절에서 `EQUL - =` 조건 포함 `여러 조건 - >, >=, <, <=`을 이용한 조건절을 사용할 수 있다.

`SIMPLE_CASE_EXPRESSION`보다 훨씬 다양한 조건을 적용할 수 있다

#### 예시
사원 정보에서 급여가 3000 이상이면 상등급, 1000 이상이면 중등급, 1000 미만이면 하등급으로 분류하라
```SQL
SELECT ENAME,
  CASE  WHEN  SAL >= 3000  THEN  'HIGH'
  CASE  WHEN  SAL >= 1000  THEN  'MID'
        ELSE  'LOW'
  END   AS    SALARY_GRADE
FROM EMP;
```

### 1-3. DECODE - Oracle
```SQL
DECODE(표현식, 기준값1, 값1, 기준값2, 값2, ... , 디폴트값)
```
Oracle에서만 사용되는 함수로 표현식의 값이 기준값1이면 값1을 출력하고, 기준값2이면 값2를 출력한다.  


#### 에시
SIMPLE_CASE_EXPRESSION 문을 다음과 같이 반환할 수 있다.

```sql
/* SIMPLE_CASE_EXPRESSION */
SELECT  LOC,
  CASE  LOC
  WHEN  'NEW YORK'  THEN 'EAST'
  WHEN  'BOSTON'    THEN 'EAST'
  WHEN  'CHICAGO'   THEN 'CENTER'
  WHEN  'DALLAS'    THEN 'CENTER'
  ELSE  'ETC'
  END   as  AREA
FROM    DEPT;

/* USE DECODE Function */
SELECT  LOC,
        DECODE(LOC, 'NEW YORK', 'EAST', 'BOSTON', 'EAST', 'CHICAGO', 'CENTER', 'DALLAS', 'CENTER', 'ETC') as AREA
FROM    DEPT;
```
