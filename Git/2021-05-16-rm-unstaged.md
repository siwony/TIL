---
layout: post
author: "정시원"
title: "Git 저장되지 않은 모든 변경 사항 취소 및 삭제"
categories: Git
date: 2021-05-16
tags: []
---

# Git 저장되지 않은 모든 변경 사항 취소 및 삭제
git을 사용할때 커밋되지 않았거나 저장되지 않은 변경 사항을 삭제하고 싶을떄가 있다.
이 떄 로컬에서 삭제하고 싶었다.

```bash
git reset # 모든 staged 파일이 unstage된다.
git checkout .  # 모든 변경 사항을 취소한다.
git clean -fdx  # 추척 할 수 없는 모든 파일 제거 (추적된 파일만 남는다.)
```
**-x 옵션은 무시(ignore) 된 파일도 모두 제거한다.**

#### 신중하게 알잘딱하게 하자