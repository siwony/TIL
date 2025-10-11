---
layout: post
author: "정시원"
title: "Bean Validator에서 검증에 실패한 필드를 클라이언트에게 알려주자!"
categories: back-end
date: 2022-06-04
tags: [spring, spring-mvc]
---

# Bean Validator에서 검증에 실패한 필드를 클라이언트에게 알려주자!
Spring boot에서 Bean Validator는 `@Valid`가 달린 인수에 대해 검증이 실패하게 된다면 `MethodArgumentNotValidException`를 던지게 된다.  
이를 이용해 클라이언트가 보낸 잘못된 데이터를 다음과 같이 예쁜(?) Json 메세지로 반환해보자
```json
{
    "message": "'name':'공백일 수 없습니다.', 'homepageUri':'올바른 URL이어야 합니다.'"
}

```

## 1. MethodArgumentNotValidException
`MethodArgumentNotValidException`([공식문서](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/bind/MethodArgumentNotValidException.html))는 내부적으로 `BindException`를 상속받고 있고 `BindException`는 `BindingResult`객체를 맴버 변수로 가지고 있다.  
`BindingResult`는 에러가 발생한 필드에 대한 정보를 담고있는 FelidError를 List형태로 여러개 가지고 있고,  
`FelidError`속에는 검증이 실패한 필드이름(`FelidError.field`)과, 이에 대한 기본메세지(`FelidError.defaultMessage`) 정보가 담겨있다. 이를 이용해 간단하게 ExceptionHandler를 만들어보자.

## 2. @RestControllerAdvice를 통한 예외처리
나는 다음과 같이 로직을 작성했다.
```kotlin
@RestControllerAdvice
class GlobalExceptionHandler{

    @ExceptionHandler(MethodArgumentNotValidException::class)
    private fun validationException(ex: MethodArgumentNotValidException): ResponseEntity<ExceptionResponseEntity>{
        val bindingResult: BindingResult = ex.bindingResult

        val errorResult = StringBuilder()
        for (fieldError in bindingResult.fieldErrors) {
            /**
             * 유효성검사에 통과하지 못한 field name
             */
            val fieldErrorName = fieldError.field

            /**
             * 유효성 검사에 통과하지 못한 field에 대한 기본 메세지
             */
            val errorMessage = fieldError.defaultMessage

            errorResult.append("'$fieldErrorName'").append(":")
            errorResult.append("'${errorMessage}.'")
            errorResult.append(", ")
        }
        errorResult.delete(errorResult.lastIndexOf(", "), errorResult.lastIndex + 1) // 마지막 리스트일 경우  ", " 문자열을 제거한다.

        return ResponseEntity.status(HttpStatus.BAD_REQUEST.value())
            .body(ExceptionResponseEntity(errorResult.toString()))
    }
}
```
`bindingResult.fieldErrors`를 순회한다. for문을 통해 클라이언트에 반환할 메세지를 만들것이기 떄문에 errorResult변수에 `StringBuilder`객체를 생성했다.

검증에 실패한 필드의 이름과 에러 메시지를 가져오고 이를 맨 처음에 보여줬던 json파일의 message값처럼 문자열을 생성한다. ExceptionResponseEntity는 String필드 1개만 가지고 있는 객체이다.