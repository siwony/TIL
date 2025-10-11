---
layout: post
author: "정시원"
title: "Package"
categories: programming
date: 2022-04-05
tags: [java, grammar, legacy]
---

# Package
- 서로 연관됨 클래스 또는 인터페이스들을 묶어 놓은 묶음
- 클래스들이 필요할 때만 사용될 수 있도록 함
- 클래스를 패키지 이름 과 함께 계층적인 형태로사용
- 다른 그룹에 속한 클래스와 발생할 수 있는 클래스 이름간 충돌 막아줌

### 패키지 정의 방법
- 보통 도메인 이름을 거꾸로 적은 후, 그 뒤에 프로젝트 이름을 붙여서 만듬
- 프로젝트 이름뒤에 다른 이름이 나올 수 있다.
- 각각의 폴더명은 숫자로 시작할 수 없다.
- 도메인 이름이 8cruz.com 이고 프로젝트 이름이 `javastudy` 라면 `com.eightcruz.javastudy` 로 패키지를 지정 할 수 있다.
### 사용방법
- improt {도매인} 처럼 사용
- 클래스 이름대신에 * 를 적어도 된다. ``import com.eightcruz.javastudy.*;``
- improt를 하지않고 다음과 같이 사용할 수 있다.  
    ``com.eightcruz.javastudy.Hello hello = new com.eightcruz.javastudy.Hello(); ``
