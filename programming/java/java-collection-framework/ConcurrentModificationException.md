# 리스트 순회중 만난 ConcurrentModificationException
### 1. 문제의 발생과 배경
알고리즘을 풀다가 리스트를 `enhanced for loop(for each)`를 통해 순회하며  `List.remove()`연산을 해야 하는 상황이 있었다. 필자는 아무렇지 않게 순회중 `List.remove()` 연산을 하게 되었는데 `ConcurrentModificationException`가 발생하였다.

처음에는 `ConcurrentModificationException`라는 이름을 보고 동시성 관련 예외라고 잠깐 생각했지만 싱글스레드 환경에서 발생했으므로 다른 원인이 있다는 것을 짐작하여 구글링을 하게 되었다.
그리고 나중에 이러한 일을 겪지 않으려 이 글을 작성한다.

`ConcurrentModificationException`이 발생한 코드의 예시는 다음과 같다.
```java
private static boolean solution(String[] phone_book) {
    final LinkedList<String> phone_books = Arrays.stream(phone_book)
            .collect(LinkedList::new, LinkedList::add, LinkedList::addAll);
    ...

    for (String s : phone_books) {  // 이 부분!
        ...
        phone_books.remove(s);
        ...
    }
}
```

### ConcurrentModificationException란?
[`ConcurrentModificationException`의 공식문서](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ConcurrentModificationException.html)를 살펴보면 첫번째 문단에 다음과 같이 나와있다.

> This exception may be thrown by methods that have detected concurrent modification of an object when such modification is not permissible.

이 문장을 번역해보면  
**"이 예외는 객체의 동시 수정이 허용되지 않는경우 동시 수정을 감지한 메서드에서 thorw될 수 있다."** 즉, 동시성 관련하여 예외가 발생할 수 있지만 3번째 문단은 다음과 같이 나와있다.

> Note that this exception does not always indicate that an object has been concurrently modified by a different thread. If a single thread issues a sequence of method invocations that violates the contract of an object, the object may throw this exception. For example, if a thread modifies a collection directly while it is iterating over the collection with a fail-fast iterator, the iterator will throw this exception.

대충 번역을 해보면 "이 예외는 항상 다른 스레드에 의해 동시에 수정됨을 나타내는 것이 아니고, 단일 스레드가 객체의 계약을 위반하는 메서드 호출 시퀀스를 실행하는 경우 발생할 수 있다. 예를 들어 **fail-fast iterator로 컬렉션을 반복하는 동안 컬렉션을 수정하는 경우 iterator는 이 예외를 thorw한다.**"

위에서 h3 [1. 문제의 발생과 배경](#1-문제의-발생과-배경)부분에서 Linked List가 `enhanced for loop`를 통해 순회하며 `List.remove`를 한 부분에서 `ConcurrentModificationException`이 발생했다. 

이정도까지 왔으면 짐작이 될 것이다. **`LinkedList`는 fail-fast `Iterator`를 사용한다.**

[`LinkedList`의 공식 문서](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/LinkedList.html)를 살펴보면 4문단에 다음과 같이 나와있다.
> The iterators returned by **this class's iterator and listIterator methods are fail-fast: if the list is structurally modified at any time after the iterator is created, in any way except through the Iterator's own remove or add methods, the iterator will throw a ConcurrentModificationException.** Thus, in the face of concurrent modification, the iterator fails quickly and cleanly, rather than risking arbitrary, non-deterministic behavior at an undetermined time in the future.

볼드 처리한 부분을 요약해보면 "**이 클래스의 iterator와 listIterator 메서드는 fail-fast이고, 구조적으로 수정되는 경우 반복자의 자체 제거 또는 추가 메서드를 통하지 않는 경우를 제외하고 반복자는 `ConcurrentModificationException`을 throw합니다.**"

## 해결방법

### 1. List.remove()가 아닌 Iterator.remove()를 사용한다.
`List.remove()`가 아닌 Iterator를 삭제하는 방법인 `iterator.remove()`를 사용하면 된다.

```java
private static boolean solution(String[] phone_book) {
    final LinkedList<String> phone_books = Arrays.stream(phone_book)
            .collect(LinkedList::new, LinkedList::add, LinkedList::addAll);
    ...

    Iterator<String> iterator = phone_books.iterator()
    while(iterator.hasNext()){
        ...
        iterator.remove();
        ...
    }
}
```
이 방법은 스레드 환경에 안전하지 않다. 하지만 싱글스레드 환경에서는 이렇게 해결해도 된다. 필자는 알고리즘 풀이에서 발생한 예외라 이렇게 해결했다.

### 2. java.util.concurrent 패키지의 CopyOnWirteArrayList를 활용하자