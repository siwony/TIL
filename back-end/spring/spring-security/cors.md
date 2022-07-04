# CORS해결기 근데 이제 Spring Security를 곁들인
Web Application 처음 프론트엔드 백앤드로 나눠서 협업을 진행하다보면 한번쯤 CORS에러를 겪는다. 

CORS는 브라우저의 보안 정책중 하나지만, 서버에서 요청을 응답할 떄 CORS관련 Header를 작성하여 보내줘야 한다.  
MDN문서에 CORS관련해서 자바 코드로 된 예제가 있으니 참고하길 바란다.(https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Access-Control-Allow-Origin)  

### SpringMVC의 CORS설정
일반적으로 Spring Boot를 통해 WAS를 만들게 된다면, Spring MVC를 사용하게 된다. `WebMvcConfigurer`를 상속받은 후 `addCorsMappings` 매서드를 통해 CORS를 설정할 수 있다.

대부분 아래 예제 코드에 나와있는 방식으로 CORS문제를 해결할 것이다.
> 이렇게 코드를 통해 설정하면 Spring MVC가 내부적으로 Filter를 통해 CORS관련 Header를 만들어준다.
```kotlin
@Configuration
class WebMvcCorsConfig: WebMvcConfigurer{

    override fun addCorsMappings(registry: CorsRegistry) {
        registry
            .addMapping("/**")
            .allowedOrigins("https://www.hirecruit.site")
            .allowedMethods(*allowedHttpMethod())
            .allowCredentials(true)
            .maxAge(3000);
    }

    private fun allowedHttpMethod(): Array<String> =
        arrayOf(
            HttpMethod.GET.name,
            HttpMethod.POST.name,
            HttpMethod.PATCH.name,
            HttpMethod.PUT.name,
            HttpMethod.DELETE.name,
            HttpMethod.HEAD.name,
            HttpMethod.OPTIONS.name,
        )
}
```

### 하지만 Spring Security를 사용하게 된다면?
Spring Security는 Spring기반의 애플리케이션의 보안(인증/인가/취약점 방어 등)을 담당하는 Spring하위의 프레임워크이다.
기본적으로 Spring Security도 필터 기반으로 동작하고 있다. (아까 CORS설정도 filter를 통한다는 사실도 꼭 기억하자)

Spring Security를 사용해서 사용자의 역할(Role)별로 endpoint의 접근을 관리할 수 있다. 아래는 hirecruit프로젝트에 사용되었던 설정 클래스의 일부이다.
```kotlin
@Configuration
class SecurityConfig: WebSecurityConfigurerAdapter(){
    ...
    override fun configure(http: HttpSecurity) {
        ...
        http.authorizeRequests{
                it.antMatchers(
                    "/worker/me/**"
                ).hasAnyRole(Role.WORKER.name, Role.MENTOR.name)
        }
        ...
    }
}
```
`/worker/me/**`표현식에 해당하는 endpoint에 대해 `WORKER`와 `MENTOR`의 역할을 가지고 있는 사용자만 접근할 수 있다.  
그렇지 않은 사용자가 해당 endpoint에 접근하면 401혹은 개발자가 작성한 handler에 따라 동작이 달라지겠지만 일반적인 API서버를 만든다면 401를 리턴하게 될 것이다.

### 401 error와 함께 발생한 CORS
preflight요청은 서버에 어떤 method, header, content type을 지원하는지 사전에 확인하는 요청이다.  
preflight요청은 주로 브라우저의 스크립트로 보내는 Fetch, Axios요청에 사용된다.

preflight 요청은 OPTIONS method를 사용하여 요청한다.  
OPTIONS method는 요청시 header, cookie, body를 포함하지 않아 client에서 사용자 인증정보를 보낼 수 없다. 

그러므로 클라이언트에서는 preflight요청이 실패하였으므로 cors에러가 반환되었고, preflight요청 후 본 요청에 대해 실패하였으므로 `error.response.status`객체를 통해서 status code를 불러올 수 없었고 이로인해 예외처리를 하지 못하는 상황이 되었다.

그래서 모든 OPTIONS 메서드의 요청을 모두 접근할 수 있게 변경하였다.
```kotlin
@Configuration
class SecurityConfig: WebSecurityConfigurerAdapter(){
    ...
    override fun configure(http: HttpSecurity) {
        ...
        http.authorizeRequests{
                it.antMatchers(HttpMethod.OPTIONS, "/**").permitAll() // CORS를 위해 OPTION method는 모든 요청에 대해 권한없이 접근할 수 있다.
                it.antMatchers(
                    "/worker/me/**"
                ).hasAnyRole(Role.WORKER.name, Role.MENTOR.name)
        }
        ...
    }
}
```

하지만 여기서 끝난 것이 아니다. security에 cors설정을 적용시키려면 cors설정은 enable 해줘야한다.
```kotlin
@Configuration
class SecurityConfig: WebSecurityConfigurerAdapter(){
    ...
    override fun configure(http: HttpSecurity) {

        http.cors() // 여기
        ...
        http.authorizeRequests{
                it.antMatchers(HttpMethod.OPTIONS, "/**").permitAll() // CORS를 위해 OPTION method는 모든 요청에 대해 권한없이 접근할 수 있다.
                it.antMatchers(
                    "/worker/me/**"
                ).hasAnyRole(Role.WORKER.name, Role.MENTOR.name)
        }
        ...
    }
}
```
`http.cors()`를 통해 `WebMvcConfigurer`를 통해 설정한 cors설정을 적용하였다.