---
layout: post
author: "정시원"
title: "ADT - Abstract Data Type"
categories: cs
date: 2022-03-19
tags: [data-structure, ADT]
---

# ADT - Abstract Data Type
: 추상자료형(ADT)이란 **구체적인 기능의 완성을 언급하지 않고, 순수하게 기능이 무엇인지를 나열한 것**을 말한다.
> ex.  
> C언어의 구조체, 객체지향 프로그램언어(c++, c#, java)의 interface,  
> 연결리스트, 스택, 큐, 우선순위 큐, 이진 트리, 딕셔너리, 서로 집합, 해시 테이블, 그래프 등...

- 데이터나 연산이 무엇(What)인지는 정의되지만, 데이터나 연산을 어떻게(How) 구현할 것인지는 정의되지 않는다.
- 즉, 구체적인 구현 방법을 다루지 않는다.
  >  이는 자료구조에서 다룬다.

#### ADT의 구성요소
- Characters - 데이터(속성)의 선언
- Opertions - 연산의 선언

