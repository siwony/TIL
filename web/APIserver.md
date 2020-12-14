#APIserver
## API(Application Programming Interface)
: 다른 소프트웨어를 제어하기 위해 미리 약속된 인터페이스 나 규약
> Web과App 에서 사용되는 Api는 보통 서비스에서 소스는 공개하지 않고 해당 기능을 제공하려고 할떄 이용
## REST API
: Representational State Transfer (표현 상태 전이)  
  HTTP 기반으로 필요한 자원에 접근하는 방식을 정해놓은 아키텍쳐  
<br/>
### REST API 의 특징
- 서버에 있는 resource는 각각의 바로접근 가능한 고유 [URI](https://github.com/siwony/TIL/blob/main/web/web-foundation.md#2-urluniform-resource-locator)가 존재
- 모든 요청은 요청마다 정보를 주기 떄문에 Session을 보관할 필요가 없다. 
  이로인해 자유도가 높아지고 유연한 아키텍쳐 적응 가능
- HTTP Method 를 이용 (GET, POST, PUT, DELETE)
<br/>
### REST API 의 구성
 Resource, Method, message 세가지로 구성되어 있다.