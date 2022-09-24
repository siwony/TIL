# try-with-resource 구문과 use함수
Java에서는 자원을 close를 해야 할 떄 [`try-with-resources`](../java/grammar/try-with-resources.md)문으로 자원이 일을 한 후 자동으로 `close()`를 호출해주는 구문이 있다.

```java
... 생략
private boolean isRunning(Process process) throw Exception {
    String line;
    StringBuilder pidInfo = new StringBuilder();

    try (BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
        while ((line = input.readLine()) != null) {
            pidInfo.append(line);
        }
    } 
    return !StringUtils.isEmpty(pidInfo.toString());
}
```

그렇다면 이를 어떻게 kotlin으로 사용할 수 있을까? 바로 표준 함수인 **use함수를 이용해 가능하다.**
```kotlin
private fun isRunning(process: Process): Boolean {
    var line: String?
    val pidInfo = StringBuilder()
    BufferedReader(InputStreamReader(process.inputStream)).use { input ->
        while (input.readLine().also { line = it } != null) {
            pidInfo.append(line)
            return pidInfo.isNotEmpty() // 여기서도 가능하다!
        }
        // return pidInfo.isNotEmpty() 
    }
}
```
여기서 주의해야 하는점은 "람다 본문에서 사용한 **return은 비지역 반환**"이다. 즉, return문은 람다가 아닌 `isRunning`함수를 끝내며 값을 반환한다.

### 좀 더 자세히
use함수는 `kotlin.io`패키지에서 확인할 수 있다.
```kotlin
inline fun <T : Closeable?, R> T.use(block: (T) -> R): R
```
use함수의 body를 보면  `Closeable`를 상속한 클레스에서만 사용할 수 있고, 함수 시그니처의 block은 24 ~ 30줄에 작성한 람다를 의미한다.

> 코드: https://github.com/JetBrains/kotlin/blob/6a670dc5f38fc73eb01d754d8f7c158ae0176ceb/libraries/stdlib/jvm/src/kotlin/io/Closeable.kt#L22

## Reference
https://shinjekim.github.io/kotlin/2019/11/01/Kotlin-%EC%9E%90%EB%B0%94%EC%9D%98-try-with-resource-%EA%B5%AC%EB%AC%B8%EA%B3%BC-%EC%BD%94%ED%8B%80%EB%A6%B0%EC%9D%98-use-%ED%95%A8%EC%88%98/