# Servlet
> 서블릿은 자바 기반의 CGI 프로그램이며 CGI 규칙에 따라 웹 서버와 데이터를 주고받는다.  

> 이 글은 tomcat을 기준으로 설명한 글입니다.

### 웹 어플리케이션의 실행 과정
<img width=500px src="./img/web-application-run-process.png">

1. 웹 브라우저가 웹 서버에게 요청을 전송한다.
2. 웹 서버는 클라이언트가 요청한 프로그램을 찾아서 실행한다.
3. 해당 프로그램은 작업을 수행한 후 그 결과를 웹 서버에게 돌려준다.
4. 웹 서버는 그 결과를 HTTP 형식에 맞춰 웹 브라우저에게 보낸다.

이때 **웹 서버와 프로그램 사이의 데이터를 주고받는 규칙을 CGI(Common Gateway Interface)라고 한다.**

웹 서버에 의해 실행되며 CGI 규칙에 따라 웹 서버와 데이터를 주고받도록 작성된 프로그램을 CGI 프로그램이라 한다.  

### 장점
- threed를 이용하여 요청을 처리하므로 빠르다.
- 플랫폼에 독립적이다. (JAVA의 JVM)
- 보안(Servlet Container)

### 동작 과정
<img width=650px src="./img/servlet-process.png">

#### 1. 사용자의 요청
: 사용자가 웹서버에 요청을 전달한다.  
   &rarr; 만약 Servlet에 대한 요청인 경우 WAS에 요청을 전달한다.
#### 2. Web Container에서 request, response객체 생성
: Web Container는 사용자의 요청에 대한 HttpServletRequest 객체와, HttpServletResponse 객체를 생성한다.
#### 3. 사용자 요청처리
1. Web Container에서 배포서술자(web.xml)를 참조하여 사용자가 요청한 URL이 어떤 Servlet에 mapping되는지 찾는다.

2. 사용자가 요청한 Servlet이 이전에 요청된적 없다면 객체를 생성한후 `init()` 호출후 메모리에 로드한다.  
   **if** 이전에 객체를 생성한 적이 있으면 다시 생성하지 않는다.
3. Web Container에서 사용자의 요청을 처리할 Threed를 처리한다.
4. Threed가 생성된 후 해당 Threed를 통해 Servlet의 `service()`를 실행한다.
5. `service()` 에서 사용자의 요청 HTTP method에 따라 `doGet()`, `doPost()`, `doPut()`, `doDelete()`가 호출된다.  
   &rarr; 앞에서 생성한 `HttpServletRequest`, `HttpServletResponse` 객체를 Tomcat에 의해 인수로 전달받는다.

#### 4. 응답
: `doGet()` 또는 `doPost()` 등. 을 호출되어 사용자 요청에 따른 페이지를 생성한 뒤  
그것이 담긴 `HttpServletResponse`객체를 Web Container에서 HTTP Response로 바꾸어 Web Server에 전송한다.

#### 5. 소멸
1. `HttpServletRequest`, `HttpServletResponse` 객체를 소멸시킨다.

2. Threed를 종료시킨다.

### HttpServletRequest
> 사용자가 요청시 HttpServletResponse와 함께 웹컨테이너에서 자동으로 생성해준다
- 사용자의 요청과 관련된 정보(파라미터)와 동작을 가지고 있는 객체
- Servlet의 `service()` 인자로 넘겨준다.

#### 주요 기능
- 요청 파라미터 조회
- 사용자가 전달한 session 정보가 담겨있는 session 객체 조회
- Request scope(범위) 안에 존제하는 component간 공유 데이터 조회

### HttpServletResponse
> 사용자가 요청시 HttpServletRequest와 함께 웹컨테이너에서 자동으로 생성해준다
- 동일 정보와 동작을 가지고있는 객체
- Servlet의 `service()` 인자로 넘겨준다.

#### 주요 기능
- 다른 페이지로 Redircet
- Response Header정보 설정
- 쿠키저장

### Life cycle
1. Servlet 객체 생성은 최초 1회 이루어진다.
2. `init()` (Servlet 초기화) 또한 최초 1회만 이루어진다.
3. `service()` 는 특정 HTTP 요청(GET, POST 등)을 처리하는 메서드 (`doGet()`, `doPost()` 등)를 호출한다.
4. 서버는 `destroy()`를 호출하여 Servlet을 제거한다.  
   &rarr; 자원을 해제할때, Servlet이 수정되어 대시 메모리에 로딩해야 하는 경우, 서버가 종료될때