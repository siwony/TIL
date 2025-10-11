---
layout: post
author: "정시원"
title: "Fetch Join"
categories: back-end
date: 2022-04-19
tags: [spring, jpa, JPQL]
---

# Fetch Join
Fetch Join은 일반적인 SQL JOIN이 아닌 JPQL에서 성능 최적화를 위해 제공하는 기능이다.  
**Fetch Join은 연관된 엔터티 혹은 컬렉션을 한번에 조회하는 기능이다.** (한방쿼리)

#### Fetch Join 예
JPQL
```sql
select m from Member m join fetch m.team
```
select projection에 Member의 m만 적었지만 m에 연관된 team도 같이 SQL문에 조회되는 쿼리가 나간다.

```sql
SELECT M.*, T.* FROM MEMBER m 
INNER JOIN TEAM T ON M.TEAM_ID=T.ID
```
> '*' 은 필드를 생략했습니다.

즉, 쿼리로 어떠한 객체 그래프를 한번에 조회 하는지 명시하는 방법이 Fetch Join이다.

### Fetch Join의 특징
- JPQL은 결과를 반환할 때 연관관계를 고려하지 않는다.
- 일반JOIN은 SELECT절에 지정한 엔티티만 조회하고,  
  select절에 지정된 엔터티와 연관관계가 맻어진 엔터티 혹은 컬렉션을 한번에 조회한다.

## Fetch Join 요약
- N + 1문제를 해결할 수 있다.
- 1 대 N 조회 시 카테시안 곱이 발생한다.
  > distinct를 사용하여 중복을 제거할 수 있다.
- 컬렉션을 Fetch Join하면 페이징 API를 사용할 수 없다.
  > Batch Size를 통해 해결할 수 있다.
- 둘 이상의 컬렉션을 Fetch Join 할 수 없다,
  > Hibernate에서는 경고를 남기고 DB가 아닌 메모리에서 페이징 처리를한다.
- Fetch Join 대상에는 별칭을 줄 수 없다.
  > 하이버네이트의 경우 가능하지만 가급적 사용하지 말자