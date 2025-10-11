---
layout: post
author: "정시원"
title: "Spring Boot 한글 깨짐 현상 해결 방법"
categories: back-end
date: 2022-03-19
tags: [spring, spring-boot]
---

# Spring Boot 한글 깨짐 현상 해결 방법
### 한글 깨짐 현상이 일어나는 곳
Controller에서 `@PathVariable`혹은 `@RequestParam`에서 한글로 된 문자열을 받을 때 깨짐 현상이 일어날 수 있다.
### 해결방법
>application.properties에 아래와 같이 추가한다.
```properties
# Charset of HTTP requests and responses. Added to the "Content-Type" header if not set explicitly.
# Spring Boot 2.3.0부터 기본값이다.
server.servlet.encoding.charset=UTF-8 
# Enable http encoding support.
server.servlet.encoding.enabled=true
# Force the encoding to the configured charset on HTTP requests and responses.
server.servlet.encoding.force=true
```
