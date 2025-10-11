---
layout: post
author: "정시원"
title: "WAS - Web Application Server"
categories: network
date: 2022-03-17
tags: [web]
---

# WAS - Web Application Server
: DB 조회나 다양한 로직 처리를 요구하는 동적인 컨텐츠를 제공하기 위해 만들어진 Application Server
>ex) Tomcat, JBoss, Jeus, Web Sphere 등...
- HTTP를 통해 컴퓨터나 장치에 애플리케이션을 수행해주는 미들웨어(소프트웨어 엔진)이다.
-  “웹 컨테이너(Web Container)”, “서블릿 컨테이너(Servlet Container)” 라고도 불린다
    - Container: JSP, Servlet을 실행시킬 수 있는 소프트웨어
    - **즉 WAS 란 JSP, Servlet 구동 환경제공**
### WAS 역활
- WAS = Web Server + Web Container
- Web Server 기능들을 구조적으로 분리하여 처리하고자하는 목적으로 제시
    - 분산 트랜잭션, 보안, 메시징, 쓰래드 처리 등 기능을 처리하는 분산환경
    - 주로 DB서버와 같이 수행

### 주요기능
- 프로그램 실행환경과 DB접속 기능 제공
- 여러 개의 트렌잭션 관리 기능
- 비즈니스 로직 실행