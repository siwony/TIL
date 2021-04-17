> 이 글은 Spring Boot + Spring Security 기준으로 쓰여진 글입니다.
#### 목차
- [Spring Security](#spring-security) &larr;
- [Spring Security Start!](spring-security-start.md)
- [Spring Security Filter](spring-security-filters.md)
- [다양한 Spring Security Filters](spring-security-variety-filters.md)

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

### spring security의 form 기반의 로그인 구조
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
