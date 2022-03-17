# HTTP POST 메서드와 Content-Type
Spring Boot를 사용해 API서버를 만들면 POST메서드를 통해 요청을 받을 때 body에 JSON형태로 통신한다는 전제로 개발을 하게 된다.  

하지만, JSON 형태가 아닌 다른 형식으로 클라이언트에서 요청을 보내야 할 때가 있다.  
파일을 전송하거나 파일과 데이터를 함께 전송하고 싶으면 `multipart/form-data` 형식으로 요청하고,  
POST 형식에서 QueryString 형태로 body에 값을 전송하고 싶다면 `application/x-www-form-urlencoded` 형식으로 요청한다.

#### multipart/form-data
각각의 데이터를 구분하는 boundary와 데이터를 구분하는 boundary 사이에 데이터와 데이터를 구분하는 Content-Type이 필수적으로 있는 요청 방식

**요청 예시**
```http
POST /foo HTTP/1.1
Content-Length: 68137
Content-Type: multipart/form-data; boundary=---------------------------974767299852498929531610575
Content-Disposition: form-data; name="description"
---------------------------974767299852498929531610575

some text

---------------------------974767299852498929531610575
Content-Disposition: form-data; name="myFile"; filename="foo.txt"
Content-Type: text/plain

(content of the uploaded file foo.txt)

---------------------------974767299852498929531610575--
```

#### application/x-www-form-urlencoded
`&`로 분리되고, `=` 기호로 키와 값을 연결하는 key-value tuple로 인코딩되는 형식의 요청 방식

예시
```http
POST / HTTP/1.1
Host: foo.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 13

say=Hi&to=Mom
```

### 이 문서를 정리하게 된 동기
`@RequestBody`를 통해 특정 API에서 데이터를 받을 때 Content-Type이 `application/x-www-form-urlencoded`인 요청받았다면 다음과 같은 에러가 발생한다.
```json
{
    "timestamp": "2021-11-30T14:01:38.862+00:00",
    "status": 415,
    "error": "Unsupported Media Type",
    "trace": "org.springframework.web.HttpMediaTypeNotSupportedException: Content type 'multipart/form-data;boundary=--------------------------626757645175388487558235;charset=UTF-8' not supported\n\tat org.springframework.web.servlet.mvc.method.annotation.AbstractMessageConverterMethodArgumentResolver.readWithMessageConverters(AbstractMessageConverterMethodArgumentResolver.java:206)\n\tat org.springframework.web.servlet.mvc.method.annotation.RequestResponseBodyMethodProcessor.readWithMessageConverters(RequestResponseBodyMethodProcessor.java:160) ...",
    "message": "Content type 'multipart/form-data;boundary=--------------------------626757645175388487558235;charset=UTF-8' not supported",
    "path": "/board/write"
}
```
이 문서는 위와 같은 에러를 겪고 Content-Type의 개념과 Content-Type 별 요청을 어떻게 처리해야 하는지 궁금하게 되었고 이를 공부한 후 작성한 글이다. 

## applicationx-www-form-urlencoded Content-Type의 데이터를 받는 방법
### 1. @RequestParam
> 지저분한 방법이라 3번을 사용하는 것을 추천한다.
```java
@PostMapping(value = "signup")
public String upload(@RequestParam String email,
                        @RequestParam String password) {

    return "응애";
}
```

### 2. `@RequestBody MultiValueMap<K, V>`
`MultiValueMap과` 함께 `@RequestBody`를 사용하면 `AnnotationMethodHandlerAdapter`에 의해 `FormHttpMessageConverter`가 등록하게 된다.

```java
@PostMapping("signup")
public String upload(@RequestBody MultiValueMap<String, String> data) { 
    log.info("MultiValueMap<String, String>: {}", data);
    return data.toString();
}
```
Content-Type은 `application/x-www-form-urlencoded`이고 `/signup`에 `name=siwony&password=1234` 이렇게 요청을 보내면 다음과 같이 로깅이 되어 출력된다.
```sh
MultiValueMap<String, String>: {email=[siwon103305@gmail.com], password=[siwon]}
```
`MultiValueMap`은 `Map<K, List<V>>`을 상속받고 있다. 이유는 

### 3. @ModelAttribute
[**커맨드 객체**](command-object.md)와 함께 `@ModelAttribute`를 사용하면 2번과 같이 `FormHttpMessageConverter`가 등록되어 해당 객체로 바인딩 할 수 있다.
- `@ModelAttribute`는 생략 가능하다.
```java
@PostMapping("signup")
public String upload(@ModelAttribute MemberDto memberDto) { 
    log.info("MultiValueMap<String, String>: {}", memberDto);
    return data.toString();
}


// MemberDto
@Getter @NoArgsConstructor  // Getter와 기본생성자는 무조건 존재해야 한다.
public class MemberDto{
    private String email;
    private String password;
}
```

## multipart/form-data의 데이터를 받는 방법

### 1. @RequestParam
지저분한 방법이라 2번을 사용하는 것을 추천한다.

**예시**
```java
@PostMapping(value = "signup")
public String upload(@RequestParam String email,
                    @RequestParam String password,
                    @RequestParam Multipart img) {
    return "응 그래";
}
```

### 2. @ModelAttribute 
`applicationx-www-form-urlencoded Content-Type`의 데이터를 받는 방법이랑 똑같이 인자에  
*`@ModelAttribute` + 커맨드객체* 와 같은 방법으로 사용한다.  
**하지만 요청시 데이터를 받아 바운딩 할 객체에는 다음 예시와 같이 `MultipartFile`객체가 존재해야된다.**

#### 올바른 예시
```java
// controller
@PostMapping("signup")
public String login(@ModelAttribute MemberDto memberDto) { 
    log.info("MultiValueMap<String, String>: {}", memberDto);
    return data.toString();
}

============================================================

// MemberDto
@Getter @NoArgsConstructor  // Getter와 기본생성자는 무조건 존재해야 한다.
public class MemberDto{
    private String email;
    private String password;
    private MultipartFile img;
}
```
만약 위 예시의 `MultipartFile`타입의 `img`맴버 변수가 없을 경우 해당 요청의 Content-Type은 applicationx-www-form-urlencoded로 판단하고 415에러가 발생한다.

이는 `@PostMapping`의 consumes속성에 `application/x-www-form-urlencoded`를 지정하면 된다.
> 하지만 구지 file데이터를 받지 않는데 `multipart/form-data`를 사용해야 하는 이유가 있을까?

#### consumes속성을 바꾼 예시
```java
import org.springframework.http.MediaType;

// class 선언 생략

@PostMapping(value = "signup", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public String login(@ModelAttribute MemberDto memberDto) {
    log.info("MemberDto: {}", memberDto);
    return memberDto.toString();
}
```





