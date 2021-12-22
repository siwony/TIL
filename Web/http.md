# HTTP - Hyper Text Transfer Protocol
: 인터넷에서 데이터를 주고받을 수 있는 프로토콜
- 구성요소: Client, Web Server, Proxy
- 80 PORT를 기본으로 사용한다.
  > https는 443

### 특징
- `HTML`, `XML`, `JSON`등 컴퓨터에서 다룰 수 있는 모든 형식의 파일은 전송 가능하다.
- 무상태 프로토콜이다. - Stateless
  > 이전 데이터 요청과 다음 데이터 요청이 서로 관련이 없다.
- 클라이언트 서버 구조
- 단순하며 확장 가능하다.

## 통신 방식
### 1. 요청(request) - 응답(response) 방식
<img width=450px src=./img/http-communication.png>

- Request Response 구조
- 클라이언트는 서버에 요청을 보내고, 응답을 대기한다.
- 서버가 요청에 대한 결과를 만들어 응답한다.

클라이언트와 서버가 분리되었다는 것이 중요하다.  
서버는 비즈니스 로직과 데이터에 대해 집중할 수 있고, client는 UI/UX에 집중할 수 있어 서로 독립적으로 진화할 수 있다.

### 2. 비상태성 - Stateless
: HTTP는 요청하고 응답을 하면 요청을 끊어버린다.
- 확장성이 높다.
- 응답 서버를 쉽게 바꿀 수 있다.

#### 2 - 1. **한계점**  
- 이전에 통신한 정보를 알 수 없다.
  > 쿠키, 세션으로 해결한다.

### 3. 비 연결성 - Connectless
- HTTP는 기본적으로 연결을 유지하지 않는 모델이다.
- 서버 자원을 매우 효율적으로 사용할 수 있다.
  > 매우 많은 유저가 서비스를 사용해도 실제 서버에서 동시에 처리하는 요청을 수십개 이하로 매우 작다.

#### 3 - 1. 한계점
- TCP/IP 연결을 새로 맺어야 한다.
  > 3 way handshake 시간 추가
- HTML, JS, CSS, 추가 이미지 등 수 많은 자원이 함께 다운로드 된다.

이러한 문제를 HTTP-지속-연결(Persistent Connections)로 문제를 해결했고, HTTP/2, HTTP/3에서 더 많은 최적화가 되었다.

## HTTP 메시지
전반적인 HTTP 메시지


### 1. 시작줄
<img width=600px src="./img/HTTP_Request_Headers.png"> 

#### 1. 시작줄
> 첫 줄은 시작줄로 메서드 구조 버전으로 구성되었다.
- `POST` : HTTP Method
- `HTTP/1.1` : HTTP 버전

#### 2. Header - 두 번째 줄
: 두번째 줄부터는 헤더이며 요청에 대한 정보를 담고 있다. `User-Agent`, `Upgrade-Insecure-Requests` 등... 이 헤더에 해당되며 헤더의 종류는 매우 많다.

#### 3. 본문(body) -header에서 한 줄 뛰어쓴다.
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

