# Git Cache 삭제
> 실수로 파일을 push한후 ignore할때 github에서는 ignore가 안되는 경우가 있다.  
> 이러한경우 캐시삭제를 한 후 다시 push하면 해결된다.

### 코드
```bash
git rm -r --cached . # 모든 캐시를 삭제한다.
git add . // 모든 변경사항 staging
git commit -m "원하는 commit msg"