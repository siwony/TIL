# Spring Security
: **스프링 기반의 어플리케이션의 보안(인증, 권한)을 담당하는 프레임워크**
- 보안 관련 체계적인 옵션 지원
- filter 기반으로 동작
- spring MVC 와 분리되어 관리 및 동작
> 만약 Spring Security를 사용하지 않는다면 자체적으로 세션을 체크하고 redirect 등을 해야 할 것이다.

[용어](/ETC/dev-terminology.md#String-cecurity)
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

