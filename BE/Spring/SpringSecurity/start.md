# Spring security 시작하자

### 의존성 추가
#### Maven
`pom.xml`
```xml
<dependencies>
  <!-- ... other dependency elements ... -->
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
  </dependency>
</dependencies>

```

#### Gradle
`builde.gradle`
```gradle
dependencies {
  compile "org.springframework.boot:spring-boot-starter-security"
}
```

### Spring Security Configuration
> Spring Security의 설정을 Java 코드로 할 수있다.

다음과 같이 Security 설정은 커스텀 할 수 있다. 다음은 JWT인증을 구현한 Config이다.   
refernce: https://github.com/GSM-Web-Technology/Jup-Jup-Server/blob/main/src/main/java/com/gsm/jupjup/config/security/SecurityConfiguration.java#L23
```java
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .cors().and()
                .httpBasic().disable() // rest api 이므로 기본설정 사용안함. 기본설정은 비인증시 로그인폼 화면으로 리다이렉트 된다.
                .csrf().disable() // rest api이므로 csrf 보안이 필요없으므로 disable처리.
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS) // jwt token으로 인증할것이므로 세션필요없으므로 생성안함.
                .and()
                .authorizeRequests() // 다음 리퀘스트에 대한 사용권한 체크
                .antMatchers("/*/signin", "/*/signup","/exception/**", "/*/member/**", "/*/logout", "/*/dev/**", "/*/userinfo").permitAll() // 가입 및 인증 주소, 오류, 이메일 인증은 누구나 접근가능
                .antMatchers("/*/admin/**").hasRole("ADMIN") // admin으로 시작하는 요청은 관리자만 접근 가능
                .anyRequest().authenticated() // 그외 나머지 요청은 인증된 사용자만 접근 가능
                .and()
                .exceptionHandling().accessDeniedHandler(new CustomAccessDeniedHandler()) //관리자 에러
                .and()
                .exceptionHandling().authenticationEntryPoint(new CustomAuthenticationEntryPointHandler()) //로그인 에러
                .and()
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);  // jwt token 필터를 id/password 인증 필터 전에 넣음
    }

    @Override // ignore check swagger, h2 database resource
    public void configure(WebSecurity web) {
        web.ignoring().antMatchers("/v2/api-docs", "/swagger-resources/**",
                "/swagger-ui.html", "/webjars/**", "/swagger/**", "/h2-console/**", "/configuration/ui");
    }

}
```
`http..httpBasic().disable()`를 지우면 로그인 폼으로 리다렉트 된다.