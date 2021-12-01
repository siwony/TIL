# 커맨드 객체 - Command Object
: `HttpServletRequest`를 통해 들어온 `RequestParameter`들을 `setter`를 이용하여 객체에 정의되어있는 속성에 Binding 되는 Object를 의미한다.

### 필요성
Spring Boot에서 다음과 같이 Parameter로 요청을 받는 코드가 있다.
```java
@PostMapping("signup")
public String upload(
        @RequestParam(value = "email", required = true) String email,
        @RequestParam(value = "password", required = true) String password,
        @RequestParam(value = "profile", required = false) String profile,
        @RequestParam(value = "profileImg", required = false) MultipartFile profileImg) {
    ...
    userService.signup(email, password, profile, profileImg);
    ...
    return result;
}

```
위 코드는 인자가 많고 인수를 검증하는 코드가 있어 지저분하다. Controller는 데이터를 받고 설정 후 검증까지 한다. 이를 분리 할 수 없을까?

아래 작성된 코드와 같이 RequestParam값을 객체로 바운됭 하여 `RequestParam`의 값을 받는다.  
추가적으로 bean validation을 활용하면 아래와 같이 바운딩되는 값에 대해 검증이 가능하다.
```java
// signup controller
@PostMapping("signup")
public String upload(@Valid MemberSignupDto memberSignupDto) { // @Modle
    ...
    userService.signup(memberSignupDto);
    ...
    return result;
}

//MemberSignupDto 객체
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
public class MemberSignupDto{
    String email;
    String password;

    String profile;
    MultipartFile profileImg;
}
```

### 커맨드 객체의 바운딩 규칙
> 두 가지 규칙 모두 setter가 존재해야 한다.
#### 1. `NoArgsConstructor`와 `AllArgsConstructor` 둘 다 있는 경우
`NoArgsConstructor` 호출 &rarr; `setter`를 호출하여 parame을 필드에 각각 초기화

#### 2. AllArgsConstructor만 있는 경우
`AllArgsConstructor` 호출 &rarr; RequestParameter을 필드에 각각 초기화 &rarr; `setter` 호출하여 RequestParameter를 필드에 각각 다시 초기화하여 덮어씌운다.