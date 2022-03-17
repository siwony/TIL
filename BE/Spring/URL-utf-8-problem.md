# URL의 Character Set 이 UTF-8이 아니라서 생기는 문제
### 배경
>[기자재 관리 시스템(Jub-Jub)](https://github.com/GSM-Web-Technology/Jup-Jup-Server) server에서 AWS s3에다가 파일을 Delete 기능을 구현하고 있었다.  
>Create, Read로직은 선배님이 해주셨고 나는 Delete 로직을 구현해야 했다.  

**전반적인 로직은 다음과 같다.**  
**Create** 로직은 AWS S3에다가 파일을 업로드 하고, s3에 저장된 그 파일의 URL을 DB에 저장하는 로직이다.  
**Read** 로직은 Client 에게 s3에 저장되어있는 파일의 URL를 DB에서 조회하여 반환한다.  
**Delete** 로직은 DB에 저장되어 있는 파일를 접근할 수 있는 URL에서 s3내의 저장 경로를 추출하여 s3 접근후 삭제한다.
### 문제 상황
문제는 Delete 로직을 작성할때 일어났다. URL은 **`Percent-encoding`** 라는 방식의 Character Set 을 사용한다.  
> ex) 고양이 -> %EA%B3%A0%EC%96%91%EC%9D%B4  
 
즉 create 로직에서 `Percent-encoding`을 UTF-8로 decoding 하여 저장하지 않고 그대로 저장해서 문제가 생겼다.

파일의 이름을 URL에서 추출하니까 한글로 된 리소스는 character set 이 다르므로 **원본파일의 이름의 문자열과 URL에서 추출한 이름의 문자열은 전혀 달라 접근을 할 수가 없었다.**  

### 문제 해결방법
Java 에서 `java.net.URLDecoder.decode(URL, character set)` 을 이용하여 Create 로직을 다음과 같이 UTF-8로 decode 하여 DB에 저장한다.
```java
uploadImageUrl = URLDecoder.decode(uploadImageUrl, "UTF-8");
```