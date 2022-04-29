# Keyword
## 1. Hard Keywords
식별자로 사용할 수 없는 키워드를 의미한다.

### 1-1. as
`as`키워드는 **타입 캐스팅**과 **별칭 기능**의 두 가지 역할을 한다.

#### 타입 캐스팅
```kotlin
val x: String = y as String
```
위 코드는 `y`를 String으로 캐스팅하여 `x`에 대입하는 코드이다.  
컴파일 오류는 발생하지 않지만, **런타임 시 캐스팅이 불가능한 타입일 경우 Exception이 발생한다.**
&rarr; 이를 Unsafe 캐스팅이라고 한다.

```kotlin
val x: String? = y as String?
```
`Nullable` 한 값을 캐스팅 해야 하는 경우 ?연산자를 이용하여 y가 null일 경우 캐스팅을 하지 않고 x에 null를 대입하게 된다.

as를 통한 타입 캐스팅은 런타임시에 캐스팅이 실패 할 경우 Exception이 발생하는데 Exception이 발생하지 않고, null를 대압하고 싶다면 `as?`키워드를 사용할 수 있다.
```kotlin
val x: String? = y as? String
```
물론 null를 허용해야 하므로 타입뒤에 `?`를 사용해야 한다.

#### alias
as는 import 구문에서 alias의 역할을 맡고있다.

예시로 Animal.Info와 Human.Info 클래스를 import 한다고 하면, 둘다 동일한 Info라는 이름을 가지기 때문에 충돌이 일어난다.
자바는 이럴 경우 해당 클래스를 접근 할 때 한쪽클래스는 패키지명까지 모두 작성해야 한다.

하지만 코틀린에서는 as키워드를 사용해 alias를 지정할 수 있다.
```kotlin
import Animal.Info
import Human.Info as humnInfo
```

### 1-2. fun
함수임을 나타내는 키워드다.

```kotlin
fun 함수명(args...): 반환타입{
    ...
}

//예시
fun add(a:Int, b:Int): Int{
    return a + b;
}
```

### 1-3. in
`for loop`, `range expressions`, `when expressions`, `generic` 등에 쓰일 수 있다.

#### for loop
```kotlin
val items: Array<Int> = arrayOf(1, 2, 3)
for (i: Int in items)
    println("i = " + i)  
```
Java의 `for each(enhanced for loop)`와 동일하게 동작하며 1, 2, 3를 출력한다.

#### range expressions
in 키워드는 다음과 같이 조건식으로도 사용이 가능하다. 
```kotlin
val items: Array<Int> = arrayOf(1, 2, 3)
val hasOne: Boolean = 1 in items
println(hsaOne)
```
> true 출력

Java에서 Collection에 있는 원소를 찾으려면 `items.contains(1)`와 같이 contains연산을 해야 한다.

#### when expressions
Java의 switch처럼 동작한다.

```kotlin
when(a) {
    a in 1..10 -> println("a is in 1 ~ 10")
}
```

#### generic
제네릭에서 in연산을 통해 반공변성을 사용할 수 있지만 길어지므로 다른 글에 적도록 하겠다.

#### !in
in 앞에 부정연산자를 붙은 키워드이고 in의 반대를 나타낸다.  
`range expressions`, `when expressions`와 같은 조건식에서만 사용할 수 있다.

### 1-4. is
타입캐스팅과 관련된 키워드이다.

Java에서는 타입캐스팅과 관련된 코드를 작성하려면 아래와 같이 Boilerplate한 code를 작성할 수 밖에 없다.
```java
Object hello = "hello";
if(hello instanceof String)
    System.out.println(((String)hello).length());
```

하지만 Kotlin은 컴파일러가 is로 체크하는 부분을 추적하여 자동으로 캐스팅해준다.
> 이를 Smart Cast라고 한다.
```kotlin
Any hello = "hello";
if(hello is String)
    System.out.println(hello.length());
```

#### when expression
is 키워드는 `when expression`에서 사용할 때 가장 강력한 기능인 거 같다.
```kotlin
when (a) {
    is Int -> print(a)
    is String -> print(a.length)
    is IntArray -> print(x.size)
}
```

#### !is
- is에 부정연산자 `!`가 붙은 연산자이다.
- `in`, `!in`과 같이 반대의 관계이다.
- `is`연산자가 사용되는 모든 곳에 사용할 수 있다.

### 1-5. this
// TODO implicit label에 대해 공부하기 및 `extendsion function`에 대해 공부하기  
공식홈페이지의 코드가 너무 어렵다 공부하고 적어야겠다.

### 1-6. throw
java와 같이 `Exception`을 발생시키는 키워드이다.

추가적으로 Kotlin은 Java와 다르게 CheckedException의 예외 처리를 강제하지 않는다.

### 1-7. type aliases
말 그대로 타입에 별칭을 줄 수 있다.

- `generic`, `function`, `class` 등 여러곳에 사용할 수 있다.
- class, method 블럭 외부에 선언해야 한다.

```kotlin
typealias FileTable<K> = MutableMap<K, MutableList<File>>
typealias NodeSet = Set<Network.Node>

fun main() {
    var fileTable: FileTable<Int> = HashMap()
    var nodeSet: NodeSet = HashSet()
}
```
이와 같이 generic선언이 긴 경우 커스텀한 타입으로 선언 할 수 있고

함수도 Java의 functional interface와 비슷하게 커스텀한 타입으로 선언할 수 있다.
```kotlin
typealias MyHandler = (Int, String, Any) -> Unit
typealias Predicate<T> = (T) -> Boolean

fun function(handler: MyHandler, predicate: Predicate<Int>) {
    handler.invoke(10, "20", 30)
    if(predicate.invoke(10))
        println("predicate is true");
}

fun main() {
    function(
        {a, b, c -> println("$a $b $c")},
        {a -> a == 10}
    )
}
```
출력결과
```
10 20 30
predicate is true
```

클래스도 커스텀한 별명을 만들어낼 수 있다.
```kotlin
class A {
    class Inner
}

typealias AInner =  A.Inner
typealias Password = String
typealias Username = String

fun main() {
    val node: AInner = AInner()
    val userPassword : Password = "password"
    val username: Username = "siwony"
}
```

### 1-8. val, var
- val은 immutable한 값을 갖는다. java에서 final 키워드와 같다.
- var은 mutable한 값을 갖는다. 즉 값이 변할 수 있다.

### 1-9. when expression
`when expression`은 Java의 switch와 비슷하다.


```java
switch (x) {
    case 1 : 
        System.out.println("1");
        break;
    
    case 2 : 
        System.out.println("2");
        break;
    
    default : 
        System.out.println("not found");
        System.out.println("go back!");
}
```
이 코드는 충분히 볼만하지만 만약 개발중에 `break`를 빼먹게 된다면 프로그램의 정합성을 해치게 된다.
그리고 여러 사람들이 느끼기에는 default가 의미적으로 안맞다고 하는 사람도 있다.

반면 코틀린 코드를 보면
```kotlin
when (x) {
  1 -> println("1")
  2 -> println("2")
  else -> {
        println("not found")
        println("go back!")
    }
}
```
break를 신경쓰지 않아도 되고 if else조건식을 사용하는 느낌을 준다.

그럼 만약 여러 케이스에 대해 동일하게 처리해야 하면 어떻게 해야 할까?
```kotlin
when (x) {
  1, 2, 3, 4 -> println("1 or 2 or 3 or 4")
  5 -> println("2")
  else -> {
        println("not found")
        println("go back!")
    }
}
```
그냥 한줄에 콤마(`,`)로 구분하여 적을 수 있다!

## Reference
- https://medium.com/@joongwon/kotlin-kotlin-키워드-및-연산자-해부-1-hard-keywords-3062f5fe2d11