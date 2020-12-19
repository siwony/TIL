# MySQL 기본 명령어(실행, 접속, 상태확인, 제시작, 종료)
- ### 실행
    ```bash
    $ mysql.server start
- ### 접속
    ```bash
    $ mysql -u root -p #root 계정으로 비밀번호를 물어봐서 접속
    ```
    비밀번호가 없으면 -p는 생략이 가능하다.
- ### 상태확인
    ```bash
    $ mysql.server status
    ```
- ### 재시작
    ```bash
    $ mysql.server restart
    ```
- ### 종료
    ```bash
    $ mysql.server stop
    ```