---
layout: post
author: "정시원"
title: "Stack Frame"
categories: cs
date: 2022-03-19
tags: [Memory]
---

# Stack Frame
### 메모리에서 Stack이란?
함수의 호출과 관계되는 지역 변수와 매개변수가 저장되는 영역이다.
- 함수의 호출과 함께 할당된다.
- 함수의 호출이 완료되면 소멸된다.
- 자료구조 stack이 사용된다.

### Stack Frame이란?
함수가 호출되면 스텍에는 *함수의 매개변수*, *호출이 끝난 뒤 돌아갈 복귀 주소*, *함수에서 선언된 지역변수*등이 저장되는데 이러한 **스택영역에 차례대로 저장되는 함수의 호출 정보를 `스택 프레임 - stack frame`** 이라고 한다.

실행 중인 함수는 자신만의 스택 영역을 사용하게 되어 Stack Frame을 열게되고, 종료 시 Stack Frame을 닫게 된다.

