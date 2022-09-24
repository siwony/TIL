# 식(expression)과 문(statement)
> Java에서 볼 수 없던 특징이라 정리하게 됨

## 정의
- 식(expression) : **값을 만들며**, 다른 식의 하위 요소로 계산에 참여
 
- 문(statement) : 자신을 둘러싼 가장 안쪽 블록의 최상위 요소이며, **아무런 값을 만들어내지 않는다.**

## 예시
### if-else
> 사실 조건식을 리턴하면 한줄로 코딩이 가능하지만 예를 들기 위해 일부로 풀어씀

Java의 if-else는 '문'으로 분류된다.
```java
boolean isOdd(int num){
  if((num % 2) != 0)
    return true;
  else
    return false;
}
```

하지만 Kotlin에서의 if-else '식'으로 사용할 수 있기 때문에 return 문에 if-else를 사용할 수 있다.
```kotlin
fun isOdd(num: Int): Boolean{
  return if((num % 2) != 0) true
        else false
}
```

if-else문 이외에 when도 값을 리턴하는 '식'으로 사용된다.

## Kotlin의 함수표현
Kotlin은 2가지 방법으로 함수를 표현할 수 있다.

### 1. 블록(문)이 본문인 함수
본문이 중괄호{}(블록)로 둘러싸인 함수

#### 특징
- 타입추론이 불가능하다.
- 그러므로 반환 타입을 생략할 수 없다.

#### 예시
```kotlin
fun argsToArray(vararg nums: Int): Array<Int> {
  return arrayOf(nums)
}
```

### 2. 식이 본문인 함수
등호와 식으로 이루어진 함수

#### 특징
- 컴파일러가 식을 분석할 수 있어 타입 추론이 가능
- 추론이 가능 하므로 타입생략 가능
- 별도의 키워드 명시 없이 마지막에 나온 값이 return값이 됨

#### 예시
```kotlin
fun argsToArray(vararg nums: Int) = arrayOf(nums)
```