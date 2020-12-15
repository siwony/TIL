#APIserver
## API(Application Programming Interface)
: 다른 소프트웨어를 제어하기 위해 미리 약속된 인터페이스 나 규약
> Web과App 에서 사용되는 API는 보통 서비스에서 소스는 공개하지 않고 해당 기능을 제공하려고 할떄 이용
## REST API
: Representational State Transfer (표현 상태 전이)  
  HTTP 기반으로 필요한 자원에 접근하는 방식을 정해놓은 아키텍쳐  
 >효과: 반복되는 코드를 API로 이용함으로써 소스 코드의 재사용을 높여 개발 <code>생산성</code>을 높일수있다
<br/>
### REST API 의 특징
- 서버에 있는 resource는 각각의 바로접근 가능한 고유 [URI](https://github.com/siwony/TIL/blob/main/web/web-foundation.md#2-urluniform-resource-locator)가 존재
- 모든 요청은 요청마다 정보를 주기 떄문에 Session을 보관할 필요가 없다.   
  이로인해 자유도가 높아지고 유연한 아키텍쳐 적응 가능
- HTTP Method 를 이용 (GET, POST, PUT, DELETE)
<br/>
### REST API 의 구성
 Resource, Method, message 세가지로 구성되어 있습니다.
#### Resource
: REST는 자원접근을 URL로 하게됩니다. 이 때문에 URL 설계시 규칙의 유의해야 합니다.
- '/'의 쓰임세는 계층 관계를 표현시 사용
- URL로 이루는 resouce들은 명사로 이루어져야 함
- REST resource 간에는 연관 관계를 표현시 다음과 같은 방법을 사용
    > /리소스명/리소스ID/관계가 있는 다른 리소스  
    > GET : /users/{userid}/devices (has 관계)
- URL에서는 -(하이픈)을 권장
- 소문자로 작성
- 확장자 포함x
### HTTP Method
|HTTP method | CRUD |    의미     |
|------------|------|------------|
|POST        |C     |리소스 생성|
|GET         |R     |리소스 조회|
|PUT         |U     |리소스 수정(= 덮어씀)|
|DELETE      |D     |리소스 삭제|
