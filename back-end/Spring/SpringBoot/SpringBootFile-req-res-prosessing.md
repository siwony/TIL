# Spring Boot file Req, Res 처리
~~이 글은 siwony_의 엄청난 삽질을 통해 작성되었습니다.~~  
## 동기
[JubJub](https://github.com/GSM-Web-Technology/Jup-Jup-Server)프로젝트에서 기자재 정보와 기자재이미지를 DB에 저장하는 기능의 필요하다.
## 문제점
#### 1. Back-end를 하면서 File처리를 다루어 본적이 없었다.
#### 2. File을 Client에게서 어떻게 받고 전달하는지에 대한 지식이 없었다.
#### 3. Spring을 이번프로젝트에서 처음 사용했다.
~~3번 같은경우 그냥 구르면 된다 just do googling~~  
## MultipartFile 으로 파일 req, res
### 파일 받기(Request)
JubJub 프로젝트에서 기자재를 저장하는 Controller 이다.  
**file을 받는 방법은 그냥 MultipartFile타입의 변수로 받으면된다.**
```java
    @PostMapping("/equimpent")
    public void save(@RequestParam("img_equipment") MultipartFile img_equipment, 
                    @RequestParam String name,
                    @RequestParam String content,
                    @RequestParam int count) throws Exception {
        EquipmentUploadDto equipmentUploadDto
                = EquipmentUploadDto.builder()
                .img_equipment(img_equipment)
                .name(name)
                .content(content)
                .count(count)
                .build();
        equipmentService.save(equipmentUploadDto);
    }
```
**주의사항**
- form-data를 보내므로 **@RequestBody같은 어노테이션을 붙이면안됨**
-  MultipartFile 외에 primitive type의 fields를 함께 수신하고 싶다면(파일이랑 json을 같이 보내는 등), 
    파일을 제외한 나머지 필드들의 타입은 무조건 text로 해야한다  
    >위에 코드에서 name, countentm count를 Dto를 이용해서 데이터를 body에서 받지 않고 RequsetParam으로 전달받은 이유도 이와 같다.(**Body 에 json요청 불가능**)
### 파일 Client에 보내기(Response)
Client가 ``/equipment/img/{name}`` 으로 Get방식의 요청을 하면 서비스에서 name으로 해당 이미지를 찾아 Controller에 전달후 img를 byte배열로 응답을 한다.
```java
    @GetMapping(value="/equipment/img/{name}", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public byte[] findByNameGetEquipment_img(@PathVariable String name) throws Exception {
        return equipmentService.findByNameGetEquipment_img(name);
    }
``` 
<img width="300" src="../img/eximg.png">

예시로 나는 img 태그를 이용해 가져와지는지 테스트했다.