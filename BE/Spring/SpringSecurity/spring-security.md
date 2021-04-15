# Spring Security
: **스프링 기반의 어플리케이션의 보안(인증, 권한)을 담당하는 프레임워크**
- 보안 관련 체계적인 옵션 지원
- filter 기반으로 동작
- spring MVC 와 분리되어 관리 및 동작
> 만약 Spring Security를 사용하지 않는다면 자체적으로 세션을 체크하고 redirect 등을 해야 할 것이다.


### 용어 정리
- **접근 주체(Principal)** : 보호된 대상에 접근하는 유저
- **인증(Authenticate)** : 현재 유저가 누구인지 확인(ex. 로그인)
    >애플리케이션의 작업을 수행할 수 있는 주체임을 증명
- **인가(Authenticate)** : 현재 유저가 어떤 서비스, 페이지에 접근할 수 있는 권한이 있는지 검사
- **권한** : 인증된 주체가 애플리케이션의 동작을 수행할 수 있도록 허락되었는지 결정
    - 권한 승인이 필요한 부분으로 접근하려면 인증 과정을 통해 주체가 증명 되어야만 한다.
    - 권한 부여에도 두가지 영역이 존재하는데 웹 요청 권한, 메소드 호출 및 도메인 인스턴스에 대한 접근 권한 부여

### 서블릿 컨테이너(Servlet Container)
: tomcat과 같은 웹 애플리케이션을 서블릿 컨테이너라고 부른다.  
<img width=450px src=./img/servlet-container.png>

- **웹 애플리케이션(JAVA EE Application)** 은 기본적으로 필터와 서블릿으로 구성되어 있다.  
- filter는 체인처럼 엮여있기 때문에 필터 체인이라고도 불리는데, 모든 request 는 이 필터 체인을 반드시 거쳐야만 서블릿 서비스에 도착하게 된다.

### Spring Security의 필터체인
<img width=550px src=./img/spring-security-filter-chain.png>  

- 스프링 시큐리티는 DelegationFilterProxy라는 필터를 만들어 메인 필터체인에 끼워넣고, 그 아래 다시 SecurityFilterChain 그룹을 등록한다.
- 이 필터체인은 한개 이상이고, url 패턴에 따라 적용하는 필터체인을 다르게 할 수 있다.
- web resource는 패터턴을 따르더라도 필터를 무시(ignore)하고 통과시켜주기도 한다.

### Spring Boot 필터
**필터체인에는 다양한 필터들이 들어간다.**  
<img width=450px src=./img/security-filters.png>

각각의 필터는 각각의 서로 다른 관심사를 해결한다.  
#### 다양한 필터들
- `HeaderWriterFilter` : Http 해더를 검사한다.
- `CorsFilter` : 허가된 사이트나 클라이언트의 요청인지 검사한다.
- `CsrfFilter` : server가 응답한 리소스에서 올라온 요청인지 검사. &rarr; 주로 API서버에서는 `disable()` 한다.
- `LogoutFilter` : 로그아웃 관련 필터
- `UsernamePasswordAuthenticationFilter` : (ID와 PW를 사용하는 form 기반 인증) 설정된 로그인 URL로 오는 요청을 감시하며, 유저 인증 처리한다.
- `ConcurrentSessionFilter` : 동시에 여러 세션관리하는 필터
- `BearerTokenAuthenticationFilter` : Authorization 해더에 Bearer 토큰 인증처리
- `BasicAuthenticationFilter` : Authorization 해더에 Basic 토큰 인증처리
- `RequestCacheAwareFilter` : 특정 로직 성공후, 이전 요청 정보를 캐시에 담는다. = &rarr; 주로 로그인 성공후.. 이정 요청 정보를 재구성하기 위해 사용한다.
- `SecurityContextHolderAwareRequestFilter` : 시큐리티 관련 서블릿 API 를 지원해주는 필터
- `RememberMeAuthenticationFilter` : 세션이 사라지거나 만료가 되더라도 쿠키 또는 DB를 사용하여 저장된 토큰 기반으로 인증을 처리하는 필터(RemebmerMe 쿠키 여부 확인)
- `AnonymousAuthenticationFilter` : 미인증시 Anonymous 사용자 &rarr; 인증/미인증 을 구별하기 위해
- `SessionManagementFilter` : 서버에서 지정한 세션정첵 검사
- `ExcpetionTranslationFilter` : `AccessDeniedException`과 `AuthenticationException`을 처리하는 필터
  - FilterChainProxy가 호출하는도중 발생하는 예외를 처리하는 예외 처리기
- `FilterSecurityInterceptor` : 어떤 리소스에 접근하기 전 마지막에 AccessDecisionManager를 사용하여 인가처리를 하는 필터
## spring security 의 구조
아래 그림은 Form 기반 로그인에 대한 플로우를 보여주는 그림이다.
<p align=center><img width=600 src=../img/spring-security-architecture.png>  <p>

1. 사용자가 Form을 통해 로그인 정보 입력 및 인증 요청
2. AuthenticationFilter(구현체 UsernamePasswordAuthenticationFilter) 가  
    HttpServletRequest에서 사용자가 보낸 아이디와 패스워드를 인터셉트 한다.
    >FrontEnd 에서 유효성검사를 할 수 있지만 안전을 위해 검사한다. (ex. null chk)
3. AuthenticationFilter에게 인증용 객체(UsernamePasswordAuthenticationFilter) 을 전달 받는다.
4. 실제 인증을 할 AuthenticationProvider에게 Authentication객체 (UsernamePasswordAuthenticationFilter)을 다시 전달한다
5. DB에서 사용자 인증 정보를 가져올 UserDetailsService 객체에게 UserID를 넘겨주고, DB에서 인증에 사용할 사용자 정보(사용자 ID, 암호화된 PW, 권환 등)를 UserDetails  
라는 객체로 전달 받는다.
    >UserDetails(인증용 객체와 도메인 객체를 분리하지 않기 위해서 실제 사용되는 도메인 객체에 UserDetails를 상속하기도 한다.)
6. AuthenticationProvider는 UserDetails 객체를 전달 받은 이후 실제 사용자의 입력정보와 UserDetails 객체를 가지고 인증을 시도
7. 8, 9, 10, 인증이 완료되면 사용자 정보를 가진 Authentication 객체를 SecurityContextHoder 에 담은 후 AuthenticationSuccessHandle를 실행
    > 실패시 uthenticationFailureHandler를 실행

