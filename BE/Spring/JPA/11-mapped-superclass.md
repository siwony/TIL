# @MappedSuperclass
<img width=450px src=./img/mapped-superclass.png>

- 공통 매핑정보가 필요할 때 사용한다.(id, name)
- 엔티티x, 테이블 매핑 x
- 부모 클래스를 상속 받는 **자식 클래스에 매핑 정보만 제공한다.**
- 조회 및 검색이 불가능하다.
- 직접 생성해서 사용할 일이 없으므로 **추상 클래스 권장한다.**
- ex. [JPA Auditing - BaseTimeEntity ](./Auditing.md)

