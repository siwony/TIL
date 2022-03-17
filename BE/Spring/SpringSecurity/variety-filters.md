# Sprint Security의 다양한 Filter

### HeaderWriterFilter
: 응답 헤더에 security 관련 헤더를 추가해주는 역할을 담당한다.
- 딱히 신경쓸 필요는 없다
- Security FilterChain에서 3번째로 동작하는 SecurityFilter이다.

#### 다음과 같은 security 관련 header 를 추가한다.
- `XContentTypeOptionsHeaderWriter`: 마임 타입 스니핑 방어.
- `XXssProtectionHeaderWriter`: 브라우저에 내장된 XSS 필터 적용.
- `CacheControlHeadersWriter`: 캐시 히스토리 취약점 방어.
- `HstsHeaderWriter`: HTTPS로만 소통하도록 강제.
- `XFrameOptionsHeaderWriter`: clickjacking 방어.

### CsrfFlter
: CSRF attack 을 방어하기 위한 filter 이다.
- Spring의 CsrfFilter 는 CSRFtoken 을 활용하여 CSRF attack 을 방어한다.
#### [CsrfFilter란?](CSRF.md)

### CorsFilter
: 허가된 사이트나 클라이언트의 요청인지 검사한다.
- Cors(교자 출처 리소스 공유) 관련 필터이다.

### LogoutFilter
: 로그아웃에 대한 처리를 담당하는 필터이다.

### UsernamePasswordAuthenticationFilter
: 설정된 로그인 URL로 오는 요청을 감시하며, 유저 인증 처리한다.
- **ID와 PW를 사용하는 form 기반 인증에서 사용한다.**
- AuthenticationManager를 통한 인증 실행
- 인증 성공 시, 얻은 Authentication 객체를 SecurityContext에 저장 후 AuthenticationSuccessHandler 실행
- 인증 실패 시, AuthenticationFailureHandler 실행

### Session Management
: 서버의 세션 정책을 검사하는 필터
- session-fixation 공격을 방어
- 세션 타임아웃을 감지
- 인증된 사용자가 동시에 열 수 있는 세션 수를 제한하는 등에 사용

### ConcurrentSessionFilter
: 동시에 여러 세션관리하는 filter이다.
- SessionManagementFilter에서 최대 세션 허용 개수를 초과할 경우 session.expireNow()를 통해서 세션을 만료 시킨다.

### RememberMeAuthenticationFilter
: 세션이 사라지거나 만료가 되더라도 쿠키 또는 DB를 사용하여 저장된 토큰 기반으로 인증을 지원하는 필터이다.
- RemebmerMe 쿠키 여부 확인하여 인증한다.
]
### BearerTokenAuthenticationFilter
: Authorization 해더에 Bearer 토큰 인증처리한다.
- 주로 JWT인증을 할때 사용한다.

### RequestCacheAwareFilter
: 특정 로직 성공후, 이전 요청 정보를 캐시에 담는다.
- 현재 요청과 관련있는 캐시 요청이 있는지 확인하고 있다면 캐시 요청을 처리해준다.
- 주로 로그인 성공후 이정 요청 정보를 재구성하기 위해 사용한다.

### SecurityContextHolderAwareRequestFilter
: Security 관련 서블릿 API 를 지원해주는 필터이다.
- 딱히 신경쓸 일은 없는 필터
- 큐리티 관련 메서드들을 스프링 시큐리티 기반으로 구현체를 연결해주는 역할을 한다.

### AnonymousAuthenticationFilter
: 익명/인증 사용자를 구분하기 위한 필터
- 인증객체( Authentication )의 유무에 따라서 처리 
- 인증객체가 없을때 임의의 사용자로 인증객체를 생성 (AnonymousAuthenticationToken)
- 세션에 저장하지 않는다.

### ExceptionTranslationFilter
: Spring Security 인가(`AccessDeniedException`)와 인증(`AuthenticationException`)Exception 을 처리하는 필터 예외 처리하는 필터

### FilterSecurityInterceptor
: 어떤 리소스에 접근하기 전 마지막에 AccessDecisionManager를 사용하여 인가처리를 하는 필터
- FilterChainProxy가 호출하는 Filter중 하나이다.
- 대부분의 경우에 가장 마지막에 사용된다.
