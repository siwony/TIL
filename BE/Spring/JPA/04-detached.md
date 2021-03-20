# 준영속 상태 
: **영속 상태의 Entity 가 영속성 컨텍스트에서 분리되는것**
- 영속에서 준영속으로 바뀌는 상태다.
- 영속성 컨텍스트가 제공하는 기능을 사용못한다. -> 준영속으로 만들었기 때문

### 준영속 방법
- **`em.detach(영속된-엔티티-객체)`**  
  : **특정 Entity만 준영속상태로 바꾼다.**
  ```java
  Member member = em.find(Member.class, 150L); 
  member.setName("siwony_");  

  em.detach(member); //준영속

  tx.commit();  // insert 쿼리문이 날라가지 않는다.
  ```
  selete 쿼리 만 날라가고 insert 쿼리는 날라가지 않는다.
- **`em.clear()`**  
  : **영속성 컨텍스트를 완전히 초기화 한다.**
  ```java

  Member member = em.find(Member.class, 150L); //select 쿼리 나감
  member.setName("siwony_");  

  em.clear(); //영속성 컨텍스트를 초기화 한다.

  Member member2 = em.find(Member.class, 150L); //select 쿼리 나감
  tx.commit(); 
  ```
  중간에 한번 `em.clear();`를 했기 때문에 select 쿼리가 두번나간다.
  > test case 를 할때 유용하다
- **`em.close`**
  : **영속성 컨텍스트를 종료한다.**