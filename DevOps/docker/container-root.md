# container에서 root 권한 명령어 실행
docker container에서 curl를 통해 docker을 실행하려고 했지만 예상치 못한 에러가 나왔다.  
```sh
List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)
```

### 문제원인
- docker container에 접속을 하면 sudo 같은 명령어를 지원을 하지 않는다.
  ```sh
  > sudo
    bash: sudo: command not found
  ```
- Docker container에 접속을 하면 user권환으로 접속이 된다.

### 해결방법
접속하기전에 root 권환을 줘서 접속하면 된다.
```sh
docker exec -itu 0 [DOCKER-CONTAINER-ID] /bin/bash
```