# Git Cache 삭제
실수로 ignore하지 않은 파일을 커밋한 후 ignore를 해도 계속 파일이 추적되는 경우가 있다.
.gitignore파일에 추가하기 전에 stage에 올라간 파일들이 cache처리되어 기록에 남아버리기 떄문이다.
이러한경우 git 캐시삭제를 한 후 다시 push하면 해결된다.


### 코드
```bash
git rm -r --cached . # 모든 캐시를 삭제한다.
git add . # 모든 변경사항 staging
git commit -m "원하는 commit msg"