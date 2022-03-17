# Ds_store gitignore
> MacOs 에서 개발을 할 때 거슬리는 것은 mac의 cache file인 Ds_store가 프로젝트 폴더에 생기는 것이다.  
> 실제로 본인은 협업 프로젝트에서 .Ds_store를 엄청 올려버렸다.. ex([jubjub](https://github.com/GSM-Web-Technology/Jup-Jup-Server))  
> 이러한 상황을 미리 방지 + 앞으로 써먹기 위해 이 md를 작성한다.

다음과 같이 작성하면된다.  
`.gitignore`
```
### Ds_Store ignore ###

.DS_Store
._.DS_Store
**/.DS_Store
**/._.DS_Store
```