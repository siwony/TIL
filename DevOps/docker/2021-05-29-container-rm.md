---
layout: post
author: "정시원"
title: "컨테이너, 이미지 삭제"
categories: DevOps
date: 2021-05-29
tags: [docker]
---

# 컨테이너, 이미지 삭제
### 컨테이너 삭제
```sh
docker rm {CONTAINER_ID}
```
#### 만약 컨테이너가 실행중일경우
강제 삭제
```sh
docker rm -f {CONTAINER_ID} # 컨테이너가 실행중일경우 강제 종료후 삭제한다.
```
종료 후 삭제
```sh
docker kill {CONTAINER_ID} # container를 종료한다.
docker rm {CONTAINER_ID}
```
- `docker kill {CONTAINER_ID}` 는 `docker stop {CONTAINER_ID}`로 대체 가능하다.
- `docker kill {CONTAINER_ID} {CONTAINER_ID}` 다음과같이 복수개를 종료 할 수 있다.  
  삭제도 마찬가지다.

#### 삭제된 컨테이너 확인
```sh
docker ps -a
```

### 이미지 삭제
```sh
docker rmi {IMAGE_ID}
```

## Docker container, image 모두삭제
### 모든 docker container 삭제
```sh
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

### 모든 docker image 삭제
```sh
docker rmi $(docker images -q) 
```