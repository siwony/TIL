---
layout: post
author: "정시원"
title: "AWS EC2 + Amazon linux2 환경에 redis설치하기"
categories: DataBase
date: 2022-08-01
tags: [redis]
---

# AWS EC2 + Amazon linux2 환경에 redis설치하기
### 1. 사전과정
yum을 update하고 gcc와 make를 설치해야 한다.
> gcc와 make를 설치하는 이유는 redis를 다운받고 컴파일 하는 과정이 필요하기 때문이다.
```bash
sudo yum install update
sudo yum intsall gcc make
```

그 이후 관리하기 편하게 redis라는 디렉터리를 생성해주었다. (이 과정은 생략해도 상관 없다.)
```bash
mkdir redis && cd redis
```

### 2. Stable된 redis 다운로드
#### 2-1. stable된 redis를 다운받고 압축을 해제한다.
```bash
sudo wget http://download.redis.io/redis-stable.tar.gz
sudo tar xvzf redis-stable.tar.g
```

#### 2-2. 압축을 해제한 redis-stable 디렉토리에 이동한다.
```bash
cd redis-stable
```

#### 2-3. redis-stable 디렉토리 에서 make명령어를 통해 redis install
```bash
sudo make
```
make 명령어를 입력하게 되면 `redis-stable` 디렉토리 속 Makefile를 기반으로 redis를 설치할 것이다.
> 해당 글은 redis설치를 중점적으로 다루므로 make에 대해서 다루지 않을 것 이다.

그 후 src 디렉토리로 이동하면 여러 파일들이 생성되는데 대표적인 파일들을 설명하자면
- **redis-server**: Redis 그 자체이다.
- **redis-sentinel**: Redis Sentinel 실행 파일(모니터링 및 페일 오버) 이다.
- **redis-cli**: Redis와 대화하기 위한 CLI이다.
- **redis-benchmark**: 성능을 확인하는데 사용된다.
- **redis-check-aof**, **redis-check-rdb**: 드물게 손상된 데이터 파일에 유용하다.

**만약 "Error jemalloc/jemalloc.h: No such file or directory when making Redis"**가 발생한다면 다음 명령어를 입력하면 해결된다.
```bash
make MALLOC=libc
```
자세한 정보는 [stackoverflow](https://stackoverflow.com/a/43929348/18397196)에 올라온 답변을 참고

### 3. 설치된 redis-server와 redis-cli를 적절한 위치로 복사
> Redis 서버와 명령 행 인터페이스를 모두 적절한 위치에 복사하는 것이 좋다.  
> 이 글에서 리눅스 디렉토리 구조에 대해 다루지 않겠다.
```bash
sudo mkdir /etc/redis
sudo mkdir /var/lib/redis
sudo cp src/redis-server src/redis-cli /usr/local/bin/
sudo cp redis.conf /etc/redis
```

### 4. Redis 설정
vim 으로 redis.conf파일을 열어 설정을 변경할 수 있디.
```bash
sudo vim /etc/redis/redis.conf
```

이건 작성자가 메모 하고 싶어 남겨놨다. (단순 테스트 용으로 사용했다.)
```conf
...
bind 0.0.0.0
...
protected-mode no
...
daemonize yes
...
logfile /var/log/redis.log
...
dir /var/lib/redis 
```
- `bind`: 외부에서 접속할 수 있는 IP를 등록한다. 0.0.0.0으로 설정하면 모두 접근할 수 있다.
- `protected-mode`: redis 보안에 관련된 설정이다. [참고](http://redisgate.kr/redis/server/protected-mode.php)
- `daemonize`: redis실행시 foreground혹은 background로 실행할 것인지에 대한 설정이다. yes로 설정시 background로 실행된다.
- `logfile`: 로그 파일의 위치및 파일명을 나타낸다.
- `dir`: dbfilename로 설정해준 rdb 파일이 저장되는 dir 경로를 나타낸다.

### 5. init script 설정
자동 실행을 위한 스크립트를 다운로드 한다.

해당 스크립트를 `/etc/init.d`에 설치하면 이후 `service redis-server start`와 같이 간편하게 실행할 수 있다.

```bash
sudo wget https://raw.githubusercontent.com/saxenap/install-redis-amazon-linux-centos/master/redis-server

sudo mv redis-server /etc/init.d # /etc/init.d wget으로 다운받은 파일을 /etc/init.d 디렉토리로 옮긴다.

sudo chmod 755 /etc/init.d/redis-server
```
이후 wget으로 다운받은 `redis-server`를 vim으로 열어 redis="/usr/local/bin/redis-server"가 있는지 확인하자
```
vim /etc/init.d/redis-server 
```

### 6. redis 실행
실행 방법에는 총 2가지 방법이 있다.
```bash
sudo /usr/local/bin/redis-server
```
혹은
```bash
sudo service redis-server start
```

### 7. redis 종료
`sudo /usr/local/bin/redis-server`를 통해 실행했으면 `control + c`를 통해 나가면 된다.

`service redis-server stop`을 통해 redis를 종료할 수 있어야 하지만... 안된다. 나중에 쉘스크립트를 배우면 init script를 내가 직접 작성해야겠다.