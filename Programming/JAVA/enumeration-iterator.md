# Enumeration 와 Iterator
> Enumeration 와 Iterator는 서로 동작하는것이 비슷하다.  
> 먼저 이 두개에 대해 알기전에 Fila-Fast 방식에 대해 알아야 한다.

### Fila-Fast 방식
: 순차적 접근이 모두 끝나기 전에 콜렉션 객체에 변경이 일어날 경우 순차적 접근이 실패되면서 `ConcurrentModificationException`를 return하는것

Enumeration은 순차적 접근 시 콜렉션 객체에 변경이 일어나도 이를 무시하고,  
끝까지 동작하는 반면에Iterator는 fail-fast 방식으로 동작한다.

### Enumeration
> 일반적으로 1.2 이후 버전에서는 Enumeration보다 Iterator를 사용하는 것을 권장하고 있다.   
> 하지만 
- JDK 1.2 부터 지원한다.
- 반복을 시작하기전 원본 데이터에 대해 snap-shot 을 찍고 해당 snap-shot에 대한 반복을 시작한다.  
  &rarr; 반복을 시작하기 전 원본과 snap-shot에 대한 불일치가 생길 수 있다.
- Iterator와 다르게 삭제가 없다.

#### Method
- `boolean hasMoreElements()` : Vector로 부터 생성된 Enumeration의 요소가 있으면 true, 아니면 false 반환
- `E nextElement()` : Enumeration 내의 다음 요소를 반환한다. 


### Iterator
- JDK 1.4 부터 지원한다.
- Fila-Fast 방식을 지원한다.  
- Enumeration와 다르게 삭제가 있다.

#### Method
- `boolean hasNext()` : 읽어올 요소가 남아있는지 확인하는 메소드. 요소가 있다면 true, 없다면 false
- `E next()` : 다음 데이터를 반환한다.
- `void remove()` : `next()`로 읽어온 요소를 삭제한다.