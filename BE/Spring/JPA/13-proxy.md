# Proxy

### em.find() vs em.getReference()
- `em.find()` : DB를 통해서 실제 엔티티 객체 조회
- `em.getReference()` : DB 조회를 미루는 가짜(Proxy)엔티티 객체 조회 
  <img width=500px src=./img/em-get-reference.png>

### Proxy 객체의 초기화
```java
Member member = em.getReference(Member.class)
member.getName();
```
<img width=500px src=./img/proxy-object-reset.png>

1. `getName()`을 요청을 한후 Member target의 값이 없다.
2. 그러면 JPA 영속성 컨텍스트에 초기화를 요청한다.
3. 영속성 컨텍스트는 DB를 조회후 
4. 실제 Entity를 생성한다
5. 그후 진짜 Entity(Member)과 Member target을 연결해서 `getName()`이 반환된다.

### Proxy 객체의 특징
- 처음 사용할 때 한 번만 초기화 된다.
- Proxy(대리자) 객체를 초기화 할 때, Proxy 객체가 Entity로 바뀌는게 아니다.  
  &rarr; **Hibernate Proxy(대리자) 객체가 Entity를 대신 접근해주는 것이다.**
- 실제 클래스를 상속 받아서 만들지고, 실제 클래스와 겉 모양이 같다.
- 원본 클래스와 타입 채크시 `instance of` 를 사용해야한다.  
  &rarr; 실제 엔티티객체와 비교할지 proxy 객체와 비교할지 모르기 때문이다.
- 영속성 컨텍스트에 찾는 엔티티가 이미 있으면` em.getReference()`를 호출해도 실제 엔티티를 반환한다.
- 영속성 컨텍스트의 도움을 받을 수 없는 준영속 상태라면 프록시를 초기화할때 예외를 던진다.  
  &rarr; 하이버네이트는 org.hibernate.LazyInitializationException 예외를 터트림
- 실제 객체의 참조(target)를 보관한다.  
  <img width=400px src=./img/proxy-delegate.png>  
    > proxy 가 Entity를 대신 호출해준다. 즉 클라이언트(개발자)는 Proxy 객체를 통해 Entity를 조회한다.

### Proxy 확인
- 프록시 인스턴스의 초기화 여부 확인  
  `PersistenceUnitUtil.isLoaded(Object entity)`
- 프록시 클래스 확인 방법  
  `entity.getClass().getName()` 출력(..javasis.. or HibernateProxy)
- 프록시 강제 초기화  
  org.hibernate.Hibernate.initialize(entity);
- JPA표준은 강제 초기화가 없다  
  강제 호출: `member.getName()`

## 결론
em.getReference()는 안쓰지만 JPA의 내부 동장방식에 대해 알아야 된다.