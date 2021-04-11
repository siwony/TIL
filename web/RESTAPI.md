# REST, API, REST API
### 목차
- [REST](#REST-Representational-State-Transfer (표현-상태 전이))
- [API](#API(Application-Programming-Interface))
- [REST API](#REST-API)
- [RESTful API](#RESTful-API)
## REST Representational State Transfer (표현 상태 전이)
: "웹에 존재하는 모든 자원(이미지, 동영상, DB 자원)에 고유한 URL을 부여해 활용"하는 것, 자원을 정의 및 자원에 대한 주소를 지정하는 방법을 의미한다.  

### 구체적 개념
: HTTP URI 를 통해 자원을 명시하고 HTTP Method를 통해 해당 자원의 대한 CRUD Operation을 적용한다.
- REST는 자원 기반의 구조(ROA, Rswource Oriented Architecture)설계의 중심에 Resource가 있고, HTTP Method를 통해 Resource를 처리하도록 설계된 것.

**CRUD Operation**
- Create : 생성(POST)
- Read : 조회(GET)
- Update : 수정(PUT)
- Delete : 삭제(DELETE)
- HEAD : header 정보 조회(HEAD)

### REST 필요 이유?
- 애플리케이션 분리 및 통합
- 다양한 클라이언트의 등장
- 다양한 플랫폼, 디바이스에서 통신할 수 있어야 한다.


### REST 의 구성요소
- **자원(RESOURCE), URI**  
    : 모든 자원은 고유한 ID를 가지고 ID는 서버에 존재하고 클라이언트는 각 자원의 상태를 조작하기 위해 요청을 보낸다. 
    >HTTP에서 이러한 자원을 구별하는 ID는 'Students/1' 같은 HTTP URL이다.
- **행위(Verb), HTTP Method**  
    : 클라이언트는 URL를 이용해 자원을 지정하고 자원을 조작하기 위해 Method를 사용한다.  
    >HTTP프로토콜에서는 <U>GET</U>, <U>POST</U>, <U>PUT</U>, <U>DELETE</U> 와 같은 Method를 제공
- **표현(Representations)**  
    : 클라이언트가 서버로 요청을 보냈을 때 서버가 응답으로 보내주는 자원의 상태를 Representation이라고 한다. 
    >REST에서 하나의 자원은 JSON, XML, TEXT, RSS등 여러형태의 Representation으로 나타낼수 있다.

### 인터페이스의 일관성
> 인터페이스의 일관성이 잘 지켜졌는지에 따라 REST를 잘 사용했는지 판단 할 수 있다.
#### 자원의 식별
: 웹 기반의 REST에서 리소스를 접근할 떄 URI를 사용한다.  

ex)  
https://foo.co.kr/user/100  
- Resource : user
- 식별자 : 100

#### 메세지를 통한 리소스 조작
: Web에서는 다양한 방식(Html, json 등..)으로 데이터를 전달 할 수 있다.
- 어떠한 타입을 알려주기위해 HTTP Header에 content-type을 통해 타입을 지정해 줄수 있다.
- 리소스 조작을 위해 데이터 전체를 전달하지 않고 이를 메세지로 전달한다.

#### 자기서술적 메세지
: 요청하는 데이터가 어떻게 처리 되어야 하는지 충분한 데이터를 포함 할 수 있어야한다.
- HTTP기반의 REST에서는 HTTP Method, Header 정보, URI의 포함되는 정보로 표현 할 수 있다.

GET : https://foo.co.kr/user/100, 사용자 정보 요청  
POST : https://foo.co.kr/user, 사용자 정보 생성  
PUT : https://foo.co.kr/user, 사용자 정보 생성 및 수정  
DELETE : https://foo.co.kr/user/100, 사용자 정보 삭제  

그외 담지 못 한 정보들을 URI의 메세지를 통하여 표현한다.

#### Application 상태에 대한 엔진으로써 하이퍼미디어
:REST API를 개발할 때 단순히 Client요청에 대한 데이터만 응답 해주는 것이 아닌 관련된 리소스에 대한 Link정보까지 같이 포함해야한다.


### REST 의 특징
- **Uniform Interface(인터페이스 일관성)**  
    : URL로 지정한 리소스에 대한 조작을 통일하며 한정적인 인터페이스로 수행한다  
    > HTTP표준에만 따른다면 모든 플랫폼에 사용이 가능하다.
- **Stateless(무상태성)**  
    : HTTP는 Stateless 프로토콜 이므로 REST 역시 무상태성을 가진다.  
    > 클라이언트의 Context 를 서버에 저장하지 않는다.
- **Cacheable(캐시 기능)**  
    : 클라이언트는 서버의 응답을 Cache(임시저장) 할 수 있어야한다.
    - 클라이언트가 Cache를 통해 응답을 재사용할 수 있어야한다. &rarr; 이를 통해 서버의 부하를 낮춘다.
    >웹 표준 HTTP 프로토콜을 그대로 사용하므로, 웹에서 사용하는 기존의 인프라를 그대로 활용가능
- **Self-descriptiveness (자체 표현 구조)**  
    : REST API 메시지만 보고도 이를 쉽게 이해 할 수 있는 자체 표현 구조로 되어 있다.
- **Client/Server 구조**  
    : 자원이있는 Server, 자원을 요청하는 Client의 구조를 가진다.
- **(Layered System)계층화**  
    : API서버는 순수 비즈니스 로직을 수행하고 그 앞단에 사용자 인증, 암호화, 로드밸런싱 등을 하는 계층을 추가하여 구조상 유연성을 줄 수 있다.

### 장점
- **쉬운사용**
    > HTTP 프로토콜 인프라를 그대로 사용하므로 별도의인프라를 구축할 필요가 없다.
- **클라이언트-서버 역활의 명확한 분리**
    > 클라이 언트는 REST API를 통해 서버와 정보를 주고받는다. REST의 특징인 Stateless에 따라 서버는 클라이언트의 Context를 유지할 필요가 없다.
- **특정 데이터 표현을 사용가능**
    > REST API는 헤더 부분에 URL처리 메소드를 명시하고 필요한 실제 데이터 를 'body'에 표현할 수 있도록 분리, JSON, XNL등 원하는 Representation 언어로 사용가능

### 단점
- **메소드의 한계**
    >REST는 HTTP 메소드를 이용하여 URL를 표현한다.  
    이러한 표현은 쉬운 사용이 가능하다는 장점이 있지만 **메소드 형태가 제한적인 단점이 있다.**
- **표준이 없음**
    >REST는 설계 가이드일 뿐 표준이 아니다.

### Resource
: REST는 자원접근을 URL로 하게된다. 이 때문에 URL 설계시 규칙의 유의해야 한다.
- '/'의 쓰임세는 계층 관계를 표현시 사용한다.
- URL로 이루는 resouce들은 명사로 이루어져야 한다.
- REST resource 간에는 연관 관계를 표현시 다음과 같은 방법을 사용한다.
    > /리소스명/리소스ID/관계가 있는 다른 리소스  
    > GET : /users/{userid}/devices (has 관계)
- URL에서는 -(하이픈)을 권장
- 소문자로 작성
- 확장자 포함x

## API(Application Programming Interface)
: 응용 프로그램에서 사용할 수 있도록, **운영체제나 프로그래밍 언어가 제공하는 기능을 제어할 수 있게 만든 인터페이스**
- Client, Server와 같은 서로 다른 프로그램에서 Request, Response을 주고 받을 수 있도록 하는 체계
- 구현방식을 몰라도 제품/서비스가 서로 커뮤니케이션을 할 수 있다.


## REST API
: REST 기반으로 서비스 API를 구현 및 제공 하는 것
- 공공데이터, 구글 맵, 마이크로 서비스 등 대부분이 REST API를 통해 제공
- HTTP 표준을 기반으로 구현여 HTTP를 지원하는 프로그램 언어를 사용하여 Client 및 Server를 구현 할 수 있다.

## RESTful API
: HTTP와 URI 기반으로 자원에 접근할 수 있도록 제공하는 애플리케이션 개발 인터페이스
- REST의 6가지 규칙을 잘 지켜 설계된 API를 지칭한다.
- 'REST API'를 제공하는 웹 서비스를 **'RESTful'** 하다고 할 수 있다.
- RESTful은 REST를 REST답게 쓰기 위한 방법이다.
    >즉 공식적인 Architecture가 아니다.

### 배경
- 최근의 서버 프로그램은 크로스 플랫폼에 대응을 해야한다.
- 범용적으로 사용성을 보장하는 서버 디자인이 필요하게 되었다.
- 웹의 장점을 최대한 활용할 수 있는 Architecture로써 REST를 발표하게 되었다.

### 특징
- 여러시스템을 분산해 확장성과 재사용성을 높여 유지보수 및 운용을 편리하게 할 수 있다. 즉 **플렛폼의 제약을 두지 않기위하여 사용한다.**
- HTTP를 지원하는 프로그램 언어로 Client, Server를 구현할 수 있다.

### REST API 디자인 가이드
REST API설계시 가장 중요한 항목이다. 2가지를 꼭 기억하자!  

**URL은 정보의 자원을 표현해야 한다.**
- URL (Uniform Resource Locator) 만으로 내가 어떤 자원을 제어하려고 하는지 알 수 있어야 한다, (자원의위치, 종류 등..)
- Server가 제공하는 정보는 JSON 이나 XML 형태로 HTTP body에 포함되어 전송 시킨다.  

**자원에 대한 행위는 HTTP Method(GET, PUT, POST, DELETE 등)로 표현한다.**  
: HTTP Method를 명시적으로 해야한다.
- 기존의 웹 서비스 처럼, GET을 이용해서 UPDATE와 DELETE를 해도되지만, RESTArchitecture 에 부합하지 않다.