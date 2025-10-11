---
layout: post
author: "정시원"
title: "API"
categories: programming
date: 2022-03-17
tags: []
---

# API 
> API(Application Programing Interface)

: 응용 프로그램에서 사용할 수 있도록, 운영 체제나 프로그래밍 언어가 제공하는 기능을 제어할 수 있게 만든 인터페이스(Interface)를 뜻한다.

#### 인터페이스? (Interface)
: 서로 다른 두 물체간의 접점, 상호작용을 말한다.
> ex.) 마우스나, 키보드로 우리는 컴퓨터와 상호작용을 한다.

### API 특징
- API는 다양한 형태로 존재한다.
- API 자체는 어디까지나 사양(specification)만을 정의하기 때문에 구현(Implementation)과는 독립적이다.
- 윈도우의 MFC나 Win32, C++의 표준 템플릿 라이브러리 (STL), Java SE API 등이 이에 해당한다.

## 웹 API
> 대표적으로 RESTful API가 있다.
- API는 기본적으로 프로그래밍 인터페이스이다.  
- 하지만, 다른 분야에 쓰일수 있도록 웹에 맞춰진 통신 인터페이스이다.

### 특징
- 소스코드를 통해 결과를 입력받거나 출력받는 일반 API와 달리 웹 API는 웹을 이용하므로 거의 대부분 웹 프로토콜을 통해 주고 받는다.
- 즉, `GET/POST` 등의 method형태로 필요한 인수를 전달받으면 거기에 맞는 결과값을 `JSON`이나 `XML` 형태로 전송해준다.
  > ex) GET `/board` 대충 게시판을 모두 가져오는 api

### 대표적인 웹 API 종류
- HTTP
- REST
- SOAP