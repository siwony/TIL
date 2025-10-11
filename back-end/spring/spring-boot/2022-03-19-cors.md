---
layout: post
author: "정시원"
title: "CORS 문제 해결"
categories: back-end
date: 2022-03-19
tags: [spring, spring-boot]
---

# CORS 문제 해결
> the moment(학교가 불편한 순간) 프로젝트에서 협업 도중생긴 CORS이슈  
> 여기는 CORS에 대해 다룹니다.
## CORS란?
: `Cross-Origin Resource Sharing(교차 출처 리소스 공유)` 의 약자로  
 브라우저에서 실행 중인 스프립트에서 시작되는 `cross-origin HTTP` 요청을 제한하는 브라우저 보안 기능이다.

브라우저는 `same-origin policy(동일 출처 정책)`에 의해 `cross-origin`의 리소스를 요청을 차단한다.

### cross-origin 종류
- 다른 도메인 (ex. `foo.com` &rarr; `example.com`)
- 다른 하위 도메인 (ex. `google.com` &rarr; `docs.google.com`)
- 다른 포트 (ex. `foo.com` &rarr; `foo.com:800`)
- 다른 프로토콜 (ex. `https://foo.com` &rarr; `http://foo.com`)

## 해결방안
제일 쉬운 해결방안은 서버 단에서 특정 `origin` 혹은 `모든 origin` 을 허용하도록 설정 하면 된다.

`WebMvcConfigurer` 를 상속받은 `WebConfig`를 다음과 같이 작성한다.
```java
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // 모든 요청에 대해서 허용
                // http://localhost:8080, http://localhost:5000 에서 들어오는 요청을 허용한다.
                .allowedOrigins("http://localhost:8080", "http://localhost:5000") 
}
```
하지만 여기에서 끝나면 `GET`, `POST` 요청은 정상적으로 요청이 되지만   
`HEAD`, `PUT`, `DELETE` HTTP method에 대해서는 CORS가 발생한다.

SpringBoot 에서는 `allowedOrigins` 를 통해 CORS허용을 하면 기본적으로 GET, POST, HEAD 만 허용을 해준다.  
따라서 `allowedMethods`를 이용해 허용할 HTTP Method를 추가해준다.
```java
@Override
public void addCorsMappings(CorsRegistry registry) {
    registry.addMapping("/**") // 모든 요청에 대해서
            .allowedOrigins("http://localhost:8080", "http://localhost:5000", "**") // local, docker
            .allowedMethods(
                    HttpMethod.GET.name(),
                    HttpMethod.HEAD.name(),
                    HttpMethod.POST.name(),
                    HttpMethod.PUT.name(),
                    HttpMethod.DELETE.name()
            )
        ;
}
```