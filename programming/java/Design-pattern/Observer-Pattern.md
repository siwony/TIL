---
layout: post
author: "정시원"
title: "Observer Pattern"
categories: programming
date: 2022-03-29
tags: [java, Design-pattern]
---

# Observer Pattern
: 변화가 일어 났을때, 미리 등록된 다른 클래스에 통보해주는 패턴
> 객체 사이에 일 대 다의 의존 관계를 정의해 두어, 어떤 객체의 상태가 변할 때 그 객체에 의존성을 가진 다른 객체들이 그 변화를 통지받고 자동으로 갱신될 수 있게 만듭니다.


- event listener에서 해당 패턴을 사용 하고 있다.
- 관찰자 패턴이라고 하기도 한다.

### Oberver Pattern 테이블
<img width=450px src=./img/observer-pattern-table.png>

### Oberver Pattern 의 구현
#### Butten에 대한 IButtonListener 인터페이스 만들기
```java
public class IButtonListener{

    public void clickEvent(String event);
}
```
#### 버튼을 구현할 Button 클래스 만들기
```java
public class Button{

    private String name;
    private IButtonListener buttonListener;

    public Button(String name){
        this.name = name;
    }

    public void click(String message){
        buttonListener.clickEvent(message);
    }

    public void addListener(IButtonListener buttonListener){
        this.buttonListener = buttonListener;
    }
}
```

#### 결과
```java
public class Main{

    public static void main(String[] args){

        Button button = new Button("버튼");

        button.addListener((event) -> {
            System.out.println(event);
        });

        button.click("메시지 전달 : click 1"); // 출력: 메시지 전달 : click 1
        button.click("메시지 전달 : click 2"); // 출력: 메시지 전달 : click 2
        button.click("메시지 전달 : click 3"); // 출력: 메시지 전달 : click 3
        button.click("메시지 전달 : click 4"); // 출력: 메시지 전달 : click 4

    }
}
```
1. Button 객체를 button변수에 생성
2. button에 `addListener` 메서드에 람다를 이용해 IButtonListener 구현
3. button에 `click` 메서드가 동작하면 `addListener`를 통해 등록된 `IButtonListener` 구현체에 `clickEvent` 메서드가  동작한다.

### 특징
- 한 객체의 상태가 바뀌면 그 객체에 의존하는 다른 객체들에게 연락이 가고 자동으로 정보가 갱신되는 1:N 의 관계를 정의한다.
- 연결은 인터페이스를 이용하여 느슨한 결함성을 유지한다.
- JAVA에서 기본으로 Observable 클래스와 Observer 인터페이스를 제공한다. &rarr; 현제는 despatched 됐다.
- Swing, Android 등에서 UI관련된 곳에서 이 옵저버 패턴이 많이 사용된다.