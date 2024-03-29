# B+Tree - B+트리
동작 방식은 B트리와 유사하나, **리프노드는 연결리스트의 형태**를 띄어 선형 검색이 가능하다.

> 실제 DB의 인덱싱은 B+트리로 이루어져 있다.


### B+Tree의 특징
1. **모든 key, data가 리프노드**에 모여있다.
2. **모든 리프노드가 연결리스트의** 형태를 띄고 있다.
    > B트리는 옆에 있는 리프노드를 검사할 때, 다시 루트노드부터 검사해야 하지만 B+트리는 리프노드에서 선형탐식을 수행할 수 있어 시간복잡도가 굉장히 줄어든다.
3. **리프노드의 부모 key는 리프노드의 첫번째 key보다 작거나 같다.**


B트리와 같이 M차 B+트리는 다음과 같은 특징을 갖는다.
- 노드는 최대 `M`개 부터 `M / 2`개 까지의 자식을 가질 수 있다.
- 노드에는 최대 `M − 1`개 부터 `(M / 2) − 1`개의 키가 포함될 수 있다.
- 노드의 키가 `x`개라면 자식의 수는 `x+1`개 이다.
- 최소차수는 자식수의 하한값을 의미하며, 최소차수가 t라면 M=2t−1을 만족한다. 
  > 최소차수 t가 2라면 3차 B트리이며, key의 하한은 1개이다.