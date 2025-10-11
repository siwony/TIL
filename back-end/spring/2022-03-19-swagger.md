---
layout: post
author: "정시원"
title: "Swagger"
categories: back-end
date: 2022-03-19
tags: [spring]
---

# Swagger
: 개발자가 REST API 서비스를 설계, 빌드, 문서화할 수 있도록 하는
프로젝트 Open Api Specification(OAS)를 위한 프레임워크   

**사용이유는 다음과 같다**
- 다른 개발팀과 협업을 진행할 경우
- 이미 구축되어있는 프로젝트에 대한 유지보수를 진행할 경우
- 백엔드의 API를 호출하는 프론트엔드 프로그램을 제작할 경우

### 기능
- **API 디자인**
    >Swagger-editor를 통해 API를 문서화하고 빠르게 명세할 수 있다.
- **API Development**
    >Swagger-codegen을 통해 작성된 문서를 통해 SDK를 생성하여 빌드 프로세스를 간소화 할 수 있도록 도와준다.
- **API Documentation**
    >Swagger-UL를 통해 작성된 API를 시각화 시킨다.
- **API Testing(post man 대체)**
    >Swagger-Inspector 
- **Standardize**
    >Swagger-hub를 통해 개인, 팀원들이 API정보를 공유하는 HUB

### 장점
- API 정보 현행화 기능
- API를 통해 Parameter, 응답 정보, 예제 등 Spec 정보 전달 용이
- 실제 사용되는 Parameter로 테스트 가능

### Swagger Tool 종류
- Swagger Codegen  
    : Swagger로 정의된대로 클라이언트/서버 코드를 생성하는 CLI 툴
- Swagger UI  
    : Swagger API 명세서를 HTML 형식으로 확인할 수 있는툴(jupjup에서 활용)
- Swagger Editor  
    : Swagger 표준에 따른 API 설께서/명세서를 작성하기 위한 에디터

### Spring Boot 에 Swagger UI 적용하기
> Swagger UI를 적용하여 Spring Boot에서 사용하고 있는 REST API를 문서화할 수 있다.

**1. 빌드파일에 의존성 추가**
버전 알잘딱 해서 추가하면 된다.
- [SpringFox Swagger2](https://mvnrepository.com/artifact/io.springfox/springfox-swagger2)
- [SpringFox Swagger UI](https://mvnrepository.com/artifact/io.springfox/springfox-swagger-ui)


**2. Swagger Config 클래스 작성**
```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.ResponseMessageBuilder;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.service.ResponseMessage;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
​
import java.util.ArrayList;
import java.util.Collections;
​
@Configuration
@EnableSwagger2
public class SwaggerConfig {
    @Bean
​
    public Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
                .select()
                .apis(RequestHandlerSelectors.any()) // 현재 RequestMapping으로 할당된 모든 API 리스트
                .paths(PathSelectors.any()) // 모든 API 참조
                .build();
    }
}
```
Spring Boot 실행후 `/swagger-ui.html`로 접속하여 swagger UI가 적용된 것을 확인