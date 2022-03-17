# Window Function
: 행과 행 간의 관계를 정의하기 위해 제공되는 함수다.

- 순위, 합계, 평균, 행 위치 등을 조작할 수 있다.
- GROUP BY 구문과 병행하여 사용할 수 없다.
- SUM, MAX, MIN과 같은 집계 윈도우 함수를 사용할 떄 **윈도우 절**과 함께 사용하면 집계 대상이 되는 **레코드 범위를 지정**할 수 있다.

### 함수 종류
#### 1. 순위 함수
- RANK
- DENSE_RANK
- ROW_NUMBER

#### 2. 윈도우 집계 함수
- SUM, MAX, MIN, AVG, COUNT

#### 3. 행 순서 함수
- FIRST_VALUE
- LAST_VALUE,
- LAG
- LEAD

#### 4. 비율 함수
- RATIO_TO_REPORT
- PERCENT_RANK
- CUME_DIST
- NTILE

## 1. 구조

### 1-1. 윈도우 함수 구조
```sql
SELECT WINDOW_FUNCTION(ARGUMENTS)
    OVER ( <PARTITION BY 컬럼> <ORDER BY 절> <WINDOWING 절> )
FROM 테이블명;

-- ex

SELECT JOB, SUM(SAL) OVER (PARTITION BY JOB
                ORDER BY SAL DESC
                ROWS UNBOUNDED PRECEDING
                ) as SUM_SAL
FROM EMP;
```
> <>는 선택가능

|    구조    |               설명                 |
|-----------|-----------------------------------|
|ARGUMENTS(인수)|윈도우 함수에 따라서 N개의 인수를 설정한다.|
|PARTITION BY|전체 집합을 기준에 의해 소그룹으로 나눈다.   |
|ORDER BY    |어떤 항목에 대해서 정렬한다.             |
|WINDOWING   | - 행 기준 범위를 정한다. <br> - ROWS는 물리적 결과의 행 수이고 RANGE는 논리적인 값에 의한 범위이다.|

### 1-2. WINDOWING
|    구조    |               설명                 |
|-----------|-----------------------------------|
|ROWS       |부분집합인 윈도우 크기를 **물리적 단위로 행의 집합을 지정**한다. 즉 **행의 수를 선택**한다.|
|RANGE      |논리적 주소에 의해 행 집합을 지정한다. 즉 **값의 범위**를 지정한다.|
|BETWEEN ~ AND| 윈도우의 시작과 끝 위치를 지정한다.      |
|UNBOUNDED PRECEDING|**윈도우 시작 위치가 첫 번째 행**임을 의미한다.|
|UNBOUNDED FOLLOWING|**윈도우 마지막 위치가 마지막 행**임을 의미한다.|
|CURRENT ROW        |윈도우 **시작 위치가 현재 행**임을 의미한다.

#### WINDOWING 예시
전체 합계
```sql
SELECT EMPNO, ENAME, SQL
SUM(SAL) ORVER(ORDER BY SAL
    ROWS BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS TOTSAL
)
FROM EMP;
```
TOTSAL의 처음부터 마지막까지의 합계(`SUM(SAL)`)를 계산한 것이다.
> AS는 생략 가능하다.

누적합계
```sql
SELECT EMPNO, ENAME, SAL
SUM(SQL) OVER(ORDER BY SQL
    ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW) AS TOTSAL
FROM EMP;
```
- 처음부터 CURRENT ROW까지의 합계를 계산한다.
  > 누적합계
- 1번째 행의 값이 1, 2번째 행의 값이 2, 3번째 행의 값이 3이면 `1 + 2 + 3 = 4`과 같이 계산된다.

### 1-3. 순위 함수 - RANK FUNCTION
: 윈도우 함수는 특정 항목과 파티션에 대해서 순위를 계산할 수 있는 함수를 제공한다.
|  순위 함수  |               설명                 |
|-----------|-----------------------------------|
|RANK       | - 특정항목 및 파티션에 대해 순위를 계산한다. <br> - **동일한 순위는 동일한 값**이 부여된다|
|DENSE_RANK | - **동일한 순위를 하나의 건수**로 계산하다.    |
|ROW_NUMBER | - **동일한 순위에 대해서 고유의 순위를 부여**한다.|


#### RANK FUNCTION 에시
#### 1. 내림차순 및 파티션
```sql
SELECT ENAME, SAL,
    RANK() OVER (ORDER BY SAL DESC) AS ALL_RANK, # SAL로 등수를 계산하고, 내림차순으로 조회한다.
    RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) AS JOB_RANK, # JOB으로 파티션을 만들고, JOB별로 SAL 순위를 조회하게 한다.
FROM EMP;
```
- 동일한 순위에는 같은 순위가 부여된다.
  > 1, 2, 2, 4, 5, 6, 6, 8

#### 2. DENSE RANK
```sql
SELECT ENAME, SAL,
    RANK() OVER (ORDER BY SAL DESC) AS ALL_RANK,
    DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSE_RANK
FROM EMP;
```
- `DENSE_RANK`는 동일한 순위를 하나의 건수로 인식해서 조회한다.
  > 1, 2, 2, 3, 4, 5, 5, 5, 6

#### 3, ROW NUMBER
```sql
SELECT ENAME, SAL,
    RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
    ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUM
FROM EMP;
```
- `ROW_NUMBER`함수는 동일한 순위에 대해서 고유의 순위를 부여한다.
  > DENSE_RANK기준 1, 2, 2, 4, 5가 ROW_NUMBER로 1, 2, 3, 4, 5로 조회된다.

### 1-4. 집계 함수 - AGGREGATE FUNCTION
|  집계 함수  |               설명                 |
|-----------|-----------------------------------|
|SUM        |파티션 별로 합계를 계산한다.              |
|AVG        |파티션 별로 평균을 계산한다.              |
|COUNT      |파티션 별로 행 수를 계산한다.             |
|MAX와 MIN   |파티션 별로 최댓값과 최솟값을 계산한다.     |

#### 집계 함수 예시

#### 1. SUM
```sql
SELECT ENAME, SAL,
SUM(SAL) OVER (PARTITION BY MGR) SUM_MGR
FROM EMP;
```
- 같은 `관리자 - MGR`에 파티션을 만들고 `합계 - SUM`를 계산한다.
  
### 1-5. 행 순서 관련 함수
- 행 순서 관련 함수는 **상위 행 값을 하위에 출력**하거나 **그 반대로 출력**할 수 있다.
- **특정 위치의 행을 출력**할 수 있다.

|  집계 함수  |               설명                 |
|-----------|-----------------------------------|
|FIRST_VALUE| - 파티션에서 **가장 처음에 나오는 값**을 구한다.|
|LAST_VALUE | - 파티션에서 **가장 나중에 나오는 값**을 구한다.|
|LAG        | - **이전 행**을 가지고 온다.           |
|LEAD       | - 윈도우에서 특정 위치의 행을 가지고 온다. <br> - 기본값은 1이다.|

#### 행 순서 관련 함수 예시
#### 1. FIRST_VALUE
```sql
SELECT DEPTNO, ENAME, SAL,
FIRST VALUE(ENAME) OVER (
    PARTITION BY DEPTNO
    ORDER BY SAL DESC ROS UNBOUNDED PRECEDING) AS DEPT_A
FROM EMP;
```
- 부서로 파티션을 나누고, 부서별로 급여가 가장 많은 직원의 이름을 4번째 칼럼에 배치한다.

#### 2. LAST_VALUE
```sql
SELECT DEPTNO, ENAME, SAL,
    LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO
    ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND
    DEPT) AS A 
FROM EMP;
```
- `LAST_VALUE`는 마지막행을 가지고 오고,
- `BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING`은 부서 내에서 급여가 가장 적은 사람을 가지고 온다.

#### 3. LAG
```sql
SELECT DEPTNO, ENAME, SAL, LAG(SAL, 2)
    OVER (ORDER BY SAL DESC) AS PRE_SAL
FROM EMP; 
```
- 해당 행에서 2번째 이전의 값을 가지고 온다.

### 1-6. 비율 관련 함수
- 누적 백분율, 순서별 백분율, 파티션을 N분으로 분할한 결과 등을 조회할 수 있다.

|    집계 함수    |                 설명                   |
|---------------|---------------------------------------|
|CUME_DIST      | - 파티션 전체 건수에서 현재 행보다 작거나 같은 건수에 대한 누적 백분율을 조회한다. <br> - 누적 분포상에 위치를 0~1사이의 값을 가진다.
|PERCENT_RANK   |행의 순서별 백분율을 조회한다.                |
|NTILE          |파티션 별로 전체 건수를 ARGUMENT 값으로 N등분한 결과를 조회한다.|
|RATIO_TO_REPORT|파티션 내에 전체 SUM(칼럼)에 대한 행 별 칼럼 값의 백분율을 소수점까지 조회한다.|

