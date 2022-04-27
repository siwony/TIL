# SpringMVC는 어떻게 데이터를 반환할까? 
> 부제: `ViewResolver`와 `MessageConverter`

### 해당 글을 적게 된 동기
Spring은 MVC2를 따르기 위해 모든 요청에 대한 응답을 `DispacherServlet`에서 모두 담당하는 것이 아닌 JSP, HTML과 같이 view만을 반환하는 `ViewResolver`를 통해 view를 반환한다. 그렇다면, **"JSON혹은 XML과 같은 데이터를 받고 비즈니스 로직을 처리 후 다시 JSON이나 XML과 같은 데이터는 어떻게 데이터를 반환하여 클라이언트에 전달하는지"** 의문을 가지게 되었는데...

SpringMVC 요청 흐름을 검색하면 다음과 같이 간략한 다이어그램을 볼 수 있다.
<img width="750" src="img/spring-mvc-request-stream.png">

View는 `ViewResolver`를 통해 View를 전달받는데, XML이나 JSON같은 데이터는 어떤식으로 반환하는지에 대한 정보를 찾기도 힘들고 제대로 된 다이어그램도 찾을 수 없어 직접 디버깅과 구글링을 통해 탐구할 것이다.

### @ResponseBody
`@ResponseBody` 어노테이션을 사용한 Controller는 `ViewResolver`가 아닌 `MessageConverter`를 통해 사용자에게 데이터를 반환한다.
> +`@RestController`속에 `@ResponseBody` 어노테이션이 있다.

## 1. 요청/응답 과정을 핥아보자
앞으로 살펴볼 클래스들의 UML이다.
> 누락된 부분 있을 수 있으므로 제보 부탁드려요 :)

<img src="img/DispatcherServlet-UML.png">

### 1-1. 사전작업
1. `DispatcherServlect`클래스 내부에 들어간다.
2. `DispatcherServlect#doService`를 찾는다.
3. 메서드의 첫번 째 줄인 `this.logRequest(request);`에 breaking point를 건다.

<img src="img/dispatherServlet-pre-ready.png">

이후 아무 `@RestController`를 만들어서 해당 컨트롤러를 실행할 예정이다.

필자는 다음과 같은 컨트롤러를 만들었다.

```java
@RestController
public class HelloController {

    @GetMapping("/hello")
    private String hello(){
        return "hello";
    }
}
```

### 1-2. 디버깅을 해보자

#### 1. 컨트롤러(헨들러)를 가져와 실행할 수 있는 상태를 만드는 과정
`doService` 메서드에서 계속 Step Over를 하다보면 `doDispatch(request, response)`를 찾을 수 있다.

<img width="800" src="img/find-doDispatch.png">

`doDispathc(request, response)` 내부로 들어가기 위해 디버거의 Step Into를 사용하면 `doDispatch`메서드로 들어가진다 그 후,
`mappedHandler = this.getHandler(processedRequest);`구분이 나올때까지 Step Over를 한다.

<img width="800" src="img/find-handler-mapping.png">

그 후 계속 Step Over를 하다보면 HandlerMapping부분을 찾을 수 있는데 `getHandler(processedRequest)`부분에서 다시 한번 Step Into를 하면  

<img width="800" src="img/getHandler.png">

1. `handlerMappings`변수에 5개의 HandlerMapping이 존재하는 것을 확인할 수 있고
2. 핸들러들을 순회하면서
3. `RequestMappingHandler`를 찾은 다음
4. `RequestMappingHandler`가 [사전작업 파트](#1-1-사전작업)에서 필자가 만든 `HelloController#hello`를 `hander`가 가지고 있는것을 볼 수 있다. 

이렇게 HandlerMapping을 통해 컨트롤러(헨들러) Bean객체를 `DispatcherServlet`에게 전달한 후,
getHandler를 통해 얻은 Handler를 실행할 수 있는 HandlerAdapter를 찾는 것을 볼 수 있다.

<img width="800" src="img/find-handlerAdapter.png">

`getHandlerAdapter`내부로 들어가면 이번에는 for문을 통해 사용할 HandlerAdapter를 찾는 과정이 진행된다.  
HandlerAdapter는 사진과 같이 4개가 존재한다.
<img width="800" src="img/get-handler-adapter-inside.png">

디버깅을 계속 진행하다보면 `RequestMappingHandlerAdapter`가 선택되는 것을 확인할 수 있다. 이제 hendler를 실행할 수 있는 HandlerAdapter를 찾았고 실행할 단계만 남아있다.

## Reference
- https://devlog-wjdrbs96.tistory.com/409
- https://velog.io/@prayme/Spring은-Http-Message-Body를-어떻게-Java의-객체로-역직렬화할까