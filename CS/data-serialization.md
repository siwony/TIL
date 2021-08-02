# 데이터 직렬화
### 직렬화(serialization) 의 사전적 의미
: CS의 데이터 스토리지 문맥에서 데이터 구조나 오브젝트 상태를 같거나  
"다른 컴퓨터 환경"에 저장하고 나중에 재구성할 수 있는 포맷으로 변환하는 과정이다.

- "다른 컴퓨터 환경"은 다른 컴퓨터의 인 메모리, 파일 시스템, 네트워크 연결 링크 간 전송 등을 의미한다.

위 말을 풀어 해석하면 다음과 같다.  

**메모리를 디스크에 저장하거나 네트워크 통신에 사용하기 위한 형식으로 변환하는 것**

### 직렬화는 왜 필요할까?
개발 시 어느 언어든 상관없이 데이터들의 구조는 크게 다음과 같다.
#### 1. 값 데이터 형식(Value Type)
- 우리가 흔히 선언해서 사용하는 int, float, char 등 
- 값 형식 데이터들은 Stack에 메모리가 쌓이고 직접 접근이 가능하다.
#### 2. 참조 형식 데이터(Reference Type)
- Java, C#, C++ 등 Object와 C의 `malloc`같은 동적 메모리 생성에 관련된 것들을 참조 형식 데이터라 한다.
- 해당 형식의 변수를 선언하면 Heap에 메모리가 할당되고,
- Stack에서는 이 Heap 메모리를 참조하는(Heap에 메모리 번지 주소를 가지고 있음) 구조로 되어있다.

이 두가지 데이터 중에서 **디스크에 저장하거나 통신에는 값 형식 데이터(Value Type)만 가능하다.**   

이유는 다음과 같다.
- `참조 형식 데이터`는 Stack에 실제 데이터 값이 아닌 Heap에 할당되어있는 메모리 번지 주소를 가지고 있다.
- 네트워크 통신 관점으로 보면 `참조 형식 데이터`는 데이터를 전달하는게 아니라 **주소를 전달하는것** 이므로 아무 의미없다.
  > A라는 유저의 특정 주소를 B한테 보내면 무슨의미가 있을까. B유저가 받은 주소값을 참조하면 전혀 데이터가 다른데..
- 참조 형식 데이터의 `Heap 테이터 영역`에 저장되어 있는 값을 다른곳에서 사용한다 해도   
  언어마다 `Heap 데이터 영역`을 다루는 방법이 없다. 즉, 표준이 없다.

그래서 직렬화를 하는이유는  
**사용하고 있는 데이터들을 파일 저장 혹은 데이터 통신 등 여러 곳에서 파싱 할 수 있는 유의미한 데이터를 만들기 위함이다.**

### 그래서 직렬화란?
: 각 주소 값이 가지는 데이터들을 전부 끌어모아 값 형식(Value Type)데이터로 변환후 데이터를 스트림에 쓰기 위해 연속적인 serial데이터로 변환하는 것이다.

#### 직렬화의 대표적인예
Binary, Text, JSON, XML, YML

다음 글은 역직렬화에 대해 글을 작성할 것이다!