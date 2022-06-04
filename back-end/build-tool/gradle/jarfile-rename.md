# Gradle에서 jar file의 이름을 변경하는 방법
일반적으로 gradle에서 jar파일을 얻으려면 `gradle build`명령어를 사용하게 된다. 그러면 프로젝트 루트를 기준으로 `/build/lib` 하위에 jar파일이 생성된다.  

그러면 jar 파일은 `{artifactId}-{version}.jar`형식으로 생성되는데 이 점을 이용하여 build된 jar 파일의 이름을 변경할 수 있다.

#### build.gradle
만약 jar file를 `siwony-1.0.jar`로 생성하고 싶다면 다음과 같이 build.gradle를 수정하면 된다.
```kotlin
version = '1.0'
base.archivesName.set("siwony")
```
그러면 build 후 `siwony-1.0.jar`파일이 생성되는 것을 확인할 수 있다.

`base.archivesName.set("siwony")`는 `base.archivesBaseName = "siwony"`로 사용할 수 있지만 해당 방법은 gradle 8에서 Deprecate될 예정이라 권장하지 않는다.