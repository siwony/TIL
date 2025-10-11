---
layout: post
author: "정시원"
title: "MongoDB"
categories: DataBase
date: 2022-03-15
tags: [mongodb]
---

# MongoDB

## 특징
### Reliability
서비스 장애에도 서비스는 계속 동작
- Replica Set 구조로 장애가 발생더라도 데이터를 유지할 수 있다.

### Scalability
데이터와 트래픽 증가에 따라 `수평확장 - scale-out` 가능
- 서버가 중단 없이 데이터를 샤딩하여 분산할 수 있다.

### Flexibility
여러가지 형태의 데이터를 손쉽게 저장
- JSON기반의 도큐먼트 기반으로 스키마가 없어 데이터를 유연하게 저장할 수 있다.

### Index Support
다양한 조건으로 빠른 데이터 검색


#### 다양한 형태의 Index 제공
- Hashed Index
- Multikey Index
- Partial Index
- TTL Index
- Geospatial Index

## Reference
- https://tv.kakao.com/channel/3693125/cliplink/414072595