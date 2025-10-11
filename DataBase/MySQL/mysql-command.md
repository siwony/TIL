---
layout: post
author: "정시원"
title: "MySQL 명령어"
categories: DataBase
date: 2020-12-20
tags: [MySQL]
---

# MySQL 명령어
## 기본적인 명령어
### DB사용
```sql
use DB명
```
### show
```sql
show databases;  --DB조회
show tables -- table조회
```
### create
```sql
create database DB명 --DB만들기
create table talbe명 --table만들기
```
### table 구조 확인
```sql
desc table명
```
## 유저관련 명령어
### 유저 조회
```sql
use mysql
select user, host from user
```
mysql 이라는 DB를 사용하고 user와 host 를 user 테이블에서 불러온다.
### 유저 추가
```sql
create user `test`@`localhost` IDENTIFIED by '1234'
```
### 유저 제거
```sql
drop user `유저이름`@`호스트`
```