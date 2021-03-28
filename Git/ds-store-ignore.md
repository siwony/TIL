# Ds_store gitignore
> mac을 이용하여 개발하다 보면 프로젝트 안에 .Ds_store파일이 엄청 많이 생길수 있다.(ex. jubjub)
> 이러한 상황을 미연에 방지하기 위해 이 md를 작성한다.

다음과 같이 작성하면된다.  
`.gitignore`
```
### Ds_Store ignore ###

.DS_Store
._.DS_Store
**/.DS_Store
**/._.DS_Store
```
