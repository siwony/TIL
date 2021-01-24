# JAVA Data Type
## 종류
### 기본형 타입(primitive data type)
- 총 8가지의 기본형 타입(Primitive data type)을 미리 정의하여 제공
- 기본값이 있기 떄문에 Null  
    if null 넣고 싶으면 WrapperClass 활용
- 실제 갑을 저장하는 공간 스택(Stack)메모리에 저장
### 참조형 타입(Reference type)
- 기본형 타입을 제외한 타입
- 비어있는 객체를 의미하는 Null 존재
- 값이 저장되어 있는곳의 주소값을 저장하는 공간으로 Heap(힙) 메모리에 저장
- 객체나 배열을 Null 값으로 받으면 NullPointException발생

**byte**
- 자바의 기본 데이터 전송 단위  
- default = 0
- Wrapper class Byte

**short**  
- default = 0
- Wrapper class Shrot

**int**  
- default = 0
- Wrapper class Integer

**long**  
- default = 0L (명시적표현 L사용)
- Wrapper class Long

**float**
- default = 0f (명시적표현 f사용)
- Wrapper class Float

**double**  
- default = 0.0d (명시적표현 d사용)
- Wrapper class Double

**boolean**  
- default = false
- Wrapper class Boolean

**char**  
- default = ‘\u0000’
- Wrapper class Character

**String**  
- new 연산 없이도 인스턴스를 생성할수 있는 reference data type  
 
### 형변환
**묵시적 형변환**
```java
int x = 400;
long y = x;
```
**강제 형변환**
```java
long x = 5;
int y = (int)x;
```