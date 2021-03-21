# Spring Boot 한글깨짐현상 해결방법
### 한글깨짐 현상이 일어나는 곳
- Controller에서 `@PathVariable`로 받거나 `@RequestParam`에서 한글을 받을때 생길수 있다.
### 해결방법
>application.properties 에 아래와 같이 추가한다.
```properties
# Charset of HTTP requests and responses. Added to the "Content-Type" header if not set explicitly.
server.servlet.encoding.charset=UTF-8
# Enable http encoding support.
server.servlet.encoding.enabled=true
# Force the encoding to the configured charset on HTTP requests and responses.
server.servlet.encoding.force=true
```
