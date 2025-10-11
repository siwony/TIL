---
layout: post
author: "정시원"
title: "REMOTE HOST IDENTIFICATION HAS CHANGED Error"
categories: back-end
date: 2022-03-19
tags: [ssh]
---

# REMOTE HOST IDENTIFICATION HAS CHANGED Error
어느날 AWS ec2에 SSH접속시 다음과 같은 에러가 나왔다.
```sh
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
{HOST KEY}
Please contact your system administrator.
Add correct host key in /Users/{user}/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /Users/{user}/.ssh/known_hosts:18
ECDSA host key for {YourIP} has changed and you have requested strict checking.
Host key verification failed.
```

### 문제원인
> 스누핑과 같은 해킹으로 의심되기 때문에 위와같은 경고를 출력한다.

기존에 접속하던 시스템의 변경으로 인해 저장된 원격 시스템의 고유값이 기존에 저장된 값과 다를때 발생한다.

### 해결방법
1. 다음과 같이 호스트 정보를 업데이트 한다.  
   `ssh-keygen -R [ IP or DomainName]`
2. known_hosts 파일 직접 수정  
   에러 문구를 보면 다음과같은 에러메세지를 볼 수 있다.
   > Offending ECDSA key in /Users/{user}/.ssh/known_hosts:18

   해당 위치로 이동해서 해당 라인을 삭제한다. 위 에러메세지에서는 18줄을 삭제하면 해결된다.