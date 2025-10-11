---
layout: post
author: "정시원"
title: "Spring Security Filter"
categories: back-end
date: 2022-03-19
tags: [spring, spring-security]
---

# Spring Security Filter
>Spring Security는 서블릿 컨테이너를 지나기 전에 필터를 통해 인증, 인가를 한다.


### 서블릿 컨테이너(Servlet Container)
: tomcat과 같은 웹 애플리케이션을 서블릿 컨테이너라고 부른다.  
<img width=450px src=./img/servlet-container.png>

- **웹 애플리케이션(JAVA EE Application)** 은 기본적으로 필터와 서블릿으로 구성되어 있다.  
- filter는 체인처럼 엮여있기 때문에 필터 체인이라고도 불리는데, 모든 request 는 이 필터 체인을 반드시 거쳐야만 서블릿 서비스에 도착하게 된다.


### Spring Security의 필터체인
<img width=550px src=./img/spring-security-filter-chain.png>  

- 스프링 시큐리티는 `DelegationFilterProxy`라는 필터를 만들어 메인 필터체인에 끼워넣고, 그 아래 다시 `SecurityFilterChain` 그룹을 등록한다.
- 이 필터체인은 한개 이상이고, url 패턴에 따라 적용하는 필터체인을 다르게 할 수 있다.
- web resource는 패턴을 따르더라도 필터를 무시(ignore)하고 통과시켜주기도 한다.

### Spring Boot 필터
**Spring Security와 관련된 Filter들은 연결된 여러 Filter들로 구성되어있다. 이 때문에 Chain이라는 표현을 사용하고 있다**  
<img width=500px src=./img/security-filter-chain-2.png>

**필터체인에는 다양한 필터들이 들어간다.**  
<img width=450px src=./img/security-filters.png>

각각의 필터는 각각의 서로 다른 관심사를 해결한다.  

#### 스프링 Security가 무슨 필터가 동작하는지 확인하는 방법
Spring Security의 설정Class @EnableWebSecurity 에 debug 속성을 ture로 준다.  
`@EnableWebSecurity(debug = "true")`