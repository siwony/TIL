---
layout: post
author: "정시원"
title: "특정 port를 사용하고 있는 프로세스 종료"
categories: OS
date: 2021-05-18
tags: [Linux]
---

# 특정 port를 사용하고 있는 프로세스 종료
> 한번씩 서버를 열어놓고 나중에 실수로 IDE를 닫아버려서 종료를 안했을때가 있다.  

### 예시
```bash
lsof -i TCP:PORT // ex) lsof -i TCP:8080
kill -9 PID    // ex) kill -9 18234
```
> PORT : PORT 번호  
> PID : `lsof -i TCP:PORT`를 통해 구한 PID
1. PORT번호로 실행중인 프로세스의 PID를 구한다.
2. 위에서 PID를 통해 프로세스를 강제종료한다.

### 참고
- [KILL 명령어 옵션](https://bigsun84.tistory.com/355)