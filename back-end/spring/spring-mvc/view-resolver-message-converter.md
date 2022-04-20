# SpringMVC는 어떻게 데이터를 반환할까? 
> 부제: ViewResolver와 MessageConverter

### @ResponseBody
`@ResponseBody` 어노테이션을 사용한 Controller는 ViewResolver대신 MessageConverter를 사용한다.  
