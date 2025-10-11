---
layout: post
author: "정시원"
title: "고아 객체(ORPAN)"
categories: back-end
date: 2022-03-19
tags: [spring, jpa]
---

# 고아 객체(ORPAN)
: 부모 엔티티와 자식관계가 끊어진 엔티티
- 고아 객체 제거: 부모 엔티티와 자식관계가 끊어진 엔티티를 제거한다.
- `orpanRemoval = true`
- ```java
  Parent parent1 = em.find(Parent.class, id);
  parent1.getChildren().remove(0) // 자식 엔티티를 컬렉션에서 제거
  ```
- `DELETE FROM CHILD WHERE ID=?`

### 예시
부모 클래스
```java
@Entity
public class Parent {
    @Id @GeneratedValue
    private Long id;

    private String name;

    @OneToMany(mappedBy=parent, orpanRemova =true)
    private List<Childe> childList = new ArrayList<>();

    public void addChilde(Child Child){
        childList.add(child);
    }
}
```
자식 클래스
```java
@Entity
public class Child {
    @Id @GeneratedValue
    private Long id;

    private String name;

    @ManyToOne
    @JoinColumn("parent_id")
    Parent parent;
```
결과
```java
Childe child1 = new Child();
Childe child2 = new Child();

Parent parent = new Parent();
parent.addChild(child1);
parent.addChild(child2);

em.flush(); //DB에 변경 내역 추가
em.clear(); //영속성 컨텍스트 초기화

Parent findParent = em.find(Parent.class, parent.getId()); // 처음 추가했던 parent조회
em.remove(findParent) // 처음 추가했던 parent를 제거하여 추가됬던 2개의 자식이 고아가되어 삭제 된다.


```


### 주의
- 참조가 제거된 객체는 다른 곳에서 참조하지 않는 고아객체로 간주하고 삭제한다.
  
- **참조하는 곳이 하나일 때만 사용해야 한다.** &rarr; 엔티티가 개인소유 일 때
- `@OneToOne`, `@OneToMany`만 가능하다.


**참고**  
>개념적으로 부모를 제거하면 자식은 고아가 된다.    
>따라서 객체 제거 기능을 사용하면 부모를 제거할 때 자식도 함께  제거된다.  
>이것은 `CascadeType.REMOVE`처럼 동작한다.

### 영속성 전이 + 고아 객체, 생명주기
#### `CascadeType.ALL + orphanRemovel=true`
: 두 옵션을 모두 활성화하면 부모 엔티티를 통해 자식 앤티티의 생명주기를 관리 할 수있다.
- 주로 `도메인 주도 개발(DDD)`의 `Aggregate Root`개념을 구현할 때 유용하다.