---
layout: post
author: "정시원"
title: "람다 표현식"
categories: programming
date: 2022-03-29
tags: [java, grammar, java8]
---

# 람다 표현식
: 간단히 메소드를 하나의 식으로 표현한 것이다.

### 표현방법
#### 1. 람다
`(인자 리스트) -> {바디}`
#### 2. 인자리스트
- 인자가 없을 떄 : `()`
  ```java
  Supplier<Integer> get10 = () -> 10;
  //혹은
  Supplier<Integer> get10 = () -> {
      return 10
  };
  ```
- 인자가 한개일 때: `(one)`, `one`

- 인자가 여러개 일 때: `(one, two)`
  ```java
  BinaryOperator<Integer> sum = (a, b) -> a + b;
  //혹은
  BinaryOperator<Integer> sum = (Integer a, Integer b) -> a + b;
  ```
- 인자의 타입을 생략 가능하다.
- 컴파일러가 추론(infer)하지만 명시할 수 있다.  
   ex. `(Integer one, Integer two)` 

### 변수 캡처(Variable Capture)
#### effectiv final
: `final`로 선언은 되지 않았지만 변수의 값이 사실상 변하지 않는 `final`한 변수
- 만약 나중에 `effective final`로 선언된 변수의 값이 변경된다면 `effective final`이 아니다. 
- Java 8부터 지원하는 기능이다.
- 익명 클래스 구현체, 람다에서 사용가능하다.
  
예시
```java
public void run(){
    int baseNumber = 10; // 사실상 baseNumber가 변하지 않는다.

    IntConsumer printInt = (i) -> System.out.println(i + baseNumber);

    // baseNumber++ 와 같이 변수의 값을 변경한다면 effectiv final이 아니다.
}
```

#### 로컬 변수 캡처
: `final` 혹은 `effective final(사실상 final)` 인 경우에만 참조할 수 있다.
- 그렇지 않을 경우 `concurrency(동시성)` 문제가 생길 수 있어서 컴파일러가 방지한다.

예시
```java
public void run(){
    final int baseNumber = 10;

    IntConsumer printInt = (i) -> System.out.println(i + baseNumber);
}
```

#### 변수의 쉐도잉(Variable Shadowing)
> **익명 클래스는 새로 scop를 만들지만, 람다는 람다를 감싸고 있는 스콥과 같다.**
```java
public void run(){
	int num = 10; 
    num++; //num 을 증가하였으므로 effective Final이 아니다.
	
	//로컬 클래스
	class local
	{
		void print()
		{
            // 여기서 num은 local class속 printf()에 scope를 가져 run매서드의 num을 가린다.
			int num = 1; 
			System.out.println(num); //1를 출력한다.
		}
	}
	
	//익명 클래스
	Consumer<Integer> anomy = new Consumer<Integer>() {
		
		@Override
		public void accept(Integer t) {
            // 여기서 num은 Consumer class속 accept()에 scope를 가져 run매서드의 num을 가린다.
			int num = 1 + t;
			System.out.println(num); //1 + 입력받은값(t)가 출력된다.
		}
	};
	
	//람다식
    /**
    /* 람다식은 run() 메서드와 scope가 같으므로 run()의 num을 참조하지만
    /* run()의 num은 effective Final이 아니므로 컴파일 오류가 난다.
    **/ 
	Consumer<Integer> lamda = (num) -> // num에 오류
	{
		int num=11; // 오류
		System.out.println("hi");
	};
}
```