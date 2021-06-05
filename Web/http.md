# HTTP
> Hyper Text Transfer Protocol

: 인터넷에서 데이터를 주고받을 수 있는 프로토콜

### 특징
- 이름에는 하이퍼텍스트 전송용 프로토콜이지만 HTML, XML, JSON 등 컴퓨터에서 다룰 수 있는것은 모두 전송 가능하다.
- TCP를 기반으로 REST의 특징을 모두 구현하고 있는 Web기반의 프로토콜
- 주로 TCP를 사용하고 HTTP/3 부터는 UDP를 사용한다.
- 80 포트를 사용한다.
- 무상태 프로토콜이다. - Stateless
- 텍스트 기반의 통신 규약이다.

### 통신 방식
#### 1. 요청(request) - 응답(request) 방식
<img width=450px src=./img/http-communication.png>

1. Client가 Server에 요청(Request)를한다.
2. Server는 Client에 요청(Request)에 응답후 응답(Response)한다.

#### 2. 비상태성 (Stateless, Connectless)
: HTTP는 요청하고 응답을 하면 요청을 끊어버린다.
- server와 client는 독립적이다.
- 접속유지 최소화, 연결상태 처리, 정보의 저장관리가 불필요해 서버 디자인이 간단하다.
- 이전 통신 정보를 알 수 없다. &rarr; 쿠키, 세션등을 사용하여 해결한다.

### Request
: Client가 서버에게 연락하는 것을 요청이라고 하며 요청을 보낼때는 요청에 대한 정보를 담아 서버로 보낸다.

### 대표적인 HTTP Method  
|HTTP method | CRUD |    의미     |
|------------|------|------------|
|POST        |C     |리소스 생성|
|GET         |R     |리소스 조회|
|PUT         |U     |리소스 수정(= 덮어씀)|
|DELETE      |D     |리소스 삭제|

### HTTP Request - 요청
<img width=600px src="./img/HTTP_Request_Headers.png"> 

#### 1. 시작줄
> 첫 줄은 시작줄로 메서드 구조 버전으로 구성되었다.
- `POST` : HTTP Method
- `HTTP/1.1` : HTTP 버전

#### 2. Header - 두 번째 줄
: 두번째 줄부터는 헤더이며 요청에 대한 정보를 담고 있다. User-Agent, Upgrade-Insecure-Requests 등등이 헤더에 해당되며 헤더의 종류는 매우 많다.

#### 3. 본문(body) -header에서 한 줄 띈다
: 본문은 요청을 할 때 함께 보낼 데이터를 담는 부분이다. 

### Requset headers
#### 1. Request Header  
: 페치될 리소스나 client 자체에 대한 자세한 정보를 포함하는 header.
- HTTP 요청에서 사용되지만 메시지의 컨텐츠와는 관련이 없는 HTTP header이다.

#### 2. General Header
: 요청과 응답 모두에 적용되지만 바디에서 최종적으로 전송되는 데이터와는 관련이 없는 헤더.
- Via와 같은 header는 메시지 전체에 적용된다.
- 가장 흔한 general header: `Date`, `Cache-Control`, `Connection`

#### 3. Entity Header
: 컨텐츠 길이나 MIME 타입과 같이 entity body에 대한 자세한 정보를 포함하는 header.
- `Content-Length`와 같이 요청 본문에 적용된다.
- 요청 내 Body(본문)이 없을경우 전송되지 않는다.

### HTTP Response - 응답
<img width=600px src="./img/HTTP_Response_Headers.png">

#### 1. 시작줄
: 첫 줄은 버전 상태코드 상태메시지로 구성되어 있다. 200은 성공적인 요청이라는 뜻이다.

#### 2. Header - 두 번째 줄
: 두번째 줄부터는 헤더이며 요청에 대한 정보를 담고 있다.

#### 3. 본문(body) -header에서 한 줄 띈다
: 본문은 응답할 데이터를 보넨다. 

### 주요 Status Code(상태코드)
> 자세히는 [MDN HTTP 상태 코드](https://developer.mozilla.org/ko/docs/Web/HTTP/Status) 에 나와있다.
- **1xx (조건부 응답)**: 요청을 받았으며 작업을 계속한다.  
- **2xx (성공)** : 클라이언트가 요청한 동작을 이해했고 승락했으며 성공적으로 처리했음을 가르킴
- **3xx (리다이렉션 만료)**: 클라이언트는 요청을 마치기 위해 추가 동작을 취해야 한다.
- **4xx (요청오류)**: 클라리언트에 오류가 있음을 나타낸다.
- **5xx (서버오류)**: 서버가 유효한 요청을 명백하게 수행하지 못했음을 나타낸다.
