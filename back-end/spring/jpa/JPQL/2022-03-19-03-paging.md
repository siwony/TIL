---
layout: post
author: "정시원"
title: "Paging"
categories: back-end
date: 2022-03-19
tags: [spring, jpa, JPQL]
---

# Paging 

### JPA는 페이징을 두개의 API로 추상화 되어있다.
- setFirstResult(int startPosition) : 조회 시작 위치(0부터 시작)
- setMacResult(int maxResult) : 조회할 데이터 수
  
### 예시
```java
List<Member> em.createQuery("select m from Member m order by m.age desc", Member.class)
    .setFirstResult(0)
    .setMaxResults(10)
    .getResultList();

for(Member member1 : result){
    System.out.println(result) // 10개의 member.toString() 이 출력된다.
}
```